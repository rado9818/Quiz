//
//  Questions.swift
//  Quiz
//
//  Created by Radoslav Bonev on 4/27/18.
//  Copyright © 2018 Radoslav Bonev. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

class Questions{
    
    //a dafult set of questions
    static var questions:Array<Dictionary<String, String>> = [
        [
            "question" : "Which is the 6th planet in the Solar system?",
            "A" : "Venus",
            "B" : "Earth",
            "C" : "Saturn",
            "D" : "Neptune",
            "correct" : "C"
        ],
        [
            "question" : "Which is the 3th planet in the Solar system?",
            "A" : "Venus",
            "B" : "Earth",
            "C" : "Saturn",
            "D" : "Neptune",
            "correct" : "B"
        ],
        [
            "question" : "Which is the hottest planet in the Solar system?",
            "A" : "Venus",
            "B" : "Earth",
            "C" : "Saturn",
            "D" : "Neptune",
            "correct" : "A"
        ],
        [
            "question" : "Which is the largest planet in the Solar system?",
            "A" : "Jupiter",
            "B" : "Earth",
            "C" : "Saturn",
            "D" : "Neptune",
            "correct" : "A"
        ]

    ]
    
    
    public func getFromLocal(){
        //we can switch between the two loading modes later on
        Questions.questions.removeAll(keepingCapacity: false)
        Questions.questions = [
            [
                "question" : "Which is the 6th planet in the Solar system?",
                "A" : "Venus",
                "B" : "Earth",
                "C" : "Saturn",
                "D" : "Neptune",
                "correct" : "C"
            ],
            [
                "question" : "Which is the 3th planet in the Solar system?",
                "A" : "Venus",
                "B" : "Earth",
                "C" : "Saturn",
                "D" : "Neptune",
                "correct" : "B"
            ],
            [
                "question" : "Which is the hottest planet in the Solar system?",
                "A" : "Venus",
                "B" : "Earth",
                "C" : "Saturn",
                "D" : "Neptune",
                "correct" : "A"
            ],
            [
                "question" : "Which is the largest planet in the Solar system?",
                "A" : "Jupiter",
                "B" : "Earth",
                "C" : "Saturn",
                "D" : "Neptune",
                "correct" : "A"
            ]
        
        ]
    }
    
    public func getDataFromDirebase(){
        //make sure the list is empty before start downloading the data
        Questions.questions.removeAll(keepingCapacity: false)

        //create a reference in the hierarchy
        let ref = Database.database().reference().child("questions")
        ref.child("questions")

        //get the children in this level of the hierarchy at the given instant
        ref.observe(.value, with: { (snapshot) in
            //iterate through the children
            for i in 0..<snapshot.childrenCount{
                //create a key-value object with the elements of any given question
                let dictionary:Dictionary<String, String> = [
                    "question" : self.removeRedundant(what: String(describing: snapshot.childSnapshot(forPath: String(i)).childSnapshot(forPath: "question"))),
                    "A" : self.removeRedundant(what: String(describing: snapshot.childSnapshot(forPath: String(i)).childSnapshot(forPath: "A"))),
                    "B" : self.removeRedundant(what: String(describing: snapshot.childSnapshot(forPath: String(i)).childSnapshot(forPath: "B"))),
                    "C" : self.removeRedundant(what: String(describing: snapshot.childSnapshot(forPath: String(i)).childSnapshot(forPath: "C"))),
                    "D" : self.removeRedundant(what: String(describing: snapshot.childSnapshot(forPath: String(i)).childSnapshot(forPath: "D"))),
                    "correct" : self.removeRedundant(what: String(describing: snapshot.childSnapshot(forPath: String(i)).childSnapshot(forPath: "correct"))),
                ]
        
                //add the key-value object to the array
                Questions.questions.append(dictionary)
            }
    
        }, withCancel: { (error) in
        //in case an error happens, print it
        print(error.localizedDescription)
    
        })
    
    }
    
    //the api calls to the firebase happen to return some garbage info which is not relevant
    //to our questions. This is why we get rid of all of it
    private func removeRedundant(what:String)->String{
        var result = what
        result = result.replacingOccurrences(of: "Snap", with: "")
        result = result.replacingOccurrences(of: "(question) ", with: "")
        result = result.replacingOccurrences(of: "(A) ", with: "")
        result = result.replacingOccurrences(of: "(B) ", with: "")
        result = result.replacingOccurrences(of: "(C) ", with: "")
        result = result.replacingOccurrences(of: "(D) ", with: "")
        result = result.replacingOccurrences(of: "(correct) ", with: "")
        result = result.replacingOccurrences(of: "Optional(\" ", with: "")
        result = result.replacingOccurrences(of: "Optional( ", with: "")
        result = result.replacingOccurrences(of: ")", with: "")
        result = result.replacingOccurrences(of: "\")", with: "")
        //return the result
        return result
    }
    
    public func getQuestion() -> Dictionary<String, String>{
        //get a random question from the array
        let randomNum = arc4random_uniform(UInt32(Questions.questions.count))
        return Questions.questions[Int(randomNum)]
    }
}
