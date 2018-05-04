//
//  ViewController.swift
//  Quiz
//
//  Created by Radoslav Bonev on 4/27/18.
//  Copyright © 2018 Radoslav Bonev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //references to the UI elements
    @IBOutlet weak var numberQuestionsLabel: UILabel!
    @IBOutlet weak var changeQuestionsStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get an instance of the Questions class
        let q:Questions = Questions();
        
        //start loading the data from the database
        q.getDataFromDirebase();
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func stepperChanged(_ sender: Any) {
        //as soon as the value in the stepper is changed, notify the UIViewController
        numberQuestionsLabel.text = String(Int16(changeQuestionsStepper.value))
        QuestionViewController.questionsToAnswer = Int(changeQuestionsStepper.value)
    }
}

