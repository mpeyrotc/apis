//
//  MainViewController.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, RestoreQuestionState {
    
    var currentQuestionNumber = -1
    var currentQuestionsAnswered = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        navigationItem.title = "Atrás"
        
        if segue.identifier == "evaluation" {
            let targetView = segue.destination as! EvaluacionViewController
            targetView.delegate = self
            
            targetView.currentQuestion = currentQuestionNumber
            targetView.answered_questions = currentQuestionsAnswered
        }
    }
    
    // MARK: - RestoreQuestionState
    
    func setValues(questionIndex: Int, questionsAnswered: Int){
        self.currentQuestionNumber = questionIndex
        self.currentQuestionsAnswered = questionsAnswered
    }
}
