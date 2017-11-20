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
    
    @IBOutlet weak var PracticaBT: UIButton!
    @IBOutlet weak var EvaluacionBT: UIButton!
    @IBOutlet weak var EstudioBT: UIButton!
    @IBOutlet weak var CreditosBT: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setButtons()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
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
    
    func setButtons(){
        let practicaColor = UIColor(rgb: 0x81C0E8)
        PracticaBT.backgroundColor = practicaColor
        PracticaBT.layer.borderColor = UIColor.black.cgColor
        PracticaBT.layer.borderWidth = 1.5
        PracticaBT.layer.cornerRadius = 10
        PracticaBT.clipsToBounds = true
        
        let evaluacionColor = UIColor(rgb: 0xCBEF43)
        EvaluacionBT.backgroundColor = evaluacionColor
        EvaluacionBT.layer.borderColor = UIColor.black.cgColor
        EvaluacionBT.layer.borderWidth = 1.5
        EvaluacionBT.layer.cornerRadius = 10
        EvaluacionBT.clipsToBounds = true
        
        let estudioColor = UIColor(rgb: 0x76ED47)
        EstudioBT.backgroundColor = estudioColor
        EstudioBT.layer.borderColor = UIColor.black.cgColor
        EstudioBT.layer.borderWidth = 1.5
        EstudioBT.layer.cornerRadius = 10
        EstudioBT.clipsToBounds = true
        
        let creditosColor = UIColor(rgb: 0xEAA78C)
        CreditosBT.backgroundColor = creditosColor
        CreditosBT.layer.borderColor = UIColor.black.cgColor
        CreditosBT.layer.borderWidth = 1.5
        CreditosBT.layer.cornerRadius = 10
        CreditosBT.clipsToBounds = true
        
        let bckColor = UIColor(rgb: 0xE0DFD5)
        view.backgroundColor = bckColor
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
}

