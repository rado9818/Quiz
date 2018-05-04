//
//  QuestionViewController.swift
//  Quiz
//
//  Created by Radoslav Bonev on 4/27/18.
//  Copyright © 2018 Radoslav Bonev. All rights reserved.
//

import UIKit

class QuestionViewController : UIViewController{
    public static var questionsToAnswer = 6;
    static var numQuestion = 0;
    static var correctCount = 0;

    //here are the answers. We will shuffle them later on
    var answers = ["A", "B", "C", "D"]
    

    let questionsGenerator:Questions = Questions()
    
    //here we will store the current question which we are answering
    var questions:Dictionary<String, String> = [:]
    
    //references to the UI elements
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //randomize the order of the answers
        randomize()
        
        setUpUI()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func randomize(){
        //traverse the array
        for i in 0 ..< answers.count - 1 {
            //generate a random index of the array
            let j = Int(arc4random_uniform(UInt32(answers.count - i))) + i
            //if the elements are different, swap them
            if i != j {
                (answers[i], answers[j]) = (answers[j], answers[i])
            }
        }
    }
    
    func setUpUI(){
        //get a random question
        questions = questionsGenerator.getQuestion()

        //set borders
        answer1.layer.borderWidth = 1.0;
        answer2.layer.borderWidth = 1.0;
        answer3.layer.borderWidth = 1.0;
        answer4.layer.borderWidth = 1.0;
        
        //set up ui elements with the questions itself and its answers
        questionLabel.text = questions["question"]
        answer1.setTitle(questions[answers[0]], for: .normal)
        answer2.setTitle(questions[answers[1]], for: .normal)
        answer3.setTitle(questions[answers[2]], for: .normal)
        answer4.setTitle(questions[answers[3]], for: .normal)

    }
    
    
    //bind an action to each button on which one ic clicked
    @IBAction func button1Action(_ sender: Any) {
        showNext(clicked: 0)
    }
    
    @IBAction func button2Action(_ sender: Any) {
        showNext(clicked: 1)
    }
    
    @IBAction func button3Action(_ sender: Any) {
        showNext(clicked: 2)
    }
    
    @IBAction func button4Action(_ sender: Any) {
        showNext(clicked: 3)
    }
    
    
    func showNext(clicked:Int){
        //we keep track on the number of answered questions
        QuestionViewController.numQuestion += 1
        
        //removeSpace function called to remove the artificats from the answer (which might have come from the server)
        if(removeSpace(what: questions["correct"]!) == answers[clicked]){
            //if it matches the osition of the correct answer, increment the counter
            QuestionViewController.correctCount += 1
        }
        
        setUpUI()
        
        //if we have just answered the last question, show an alert
        if(QuestionViewController.numQuestion+1 == QuestionViewController.questionsToAnswer){
            //compute the text for the alert. It will countain the number of the questions we have answered correctly
            let text:String = "Completed with " +  String(QuestionViewController.correctCount) + " correct answers"
            //display the alert
            let alert = UIAlertController(title: "Completed", message: text, preferredStyle: UIAlertControllerStyle.alert)
            //add an action to the alert
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            //display the alert with an animation
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    private func removeSpace(what:String)->String{
        var result = what
        //replace the white spaces with an empty string, that is, remove them
        result = result.replacingOccurrences(of: " ", with: "")
        return result
    }
}
