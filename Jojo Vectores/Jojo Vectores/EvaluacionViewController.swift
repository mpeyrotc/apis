//
//  EvaluacionViewController.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import UIKit

class EvaluacionViewController: UIViewController {
    @IBOutlet weak var questionTextArea: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var withoutHelpButton: UIButton!
    @IBOutlet weak var withHelpButton: UIButton!
    
    var questions: NSArray!
    var currentQuestion = -1
    var currentAnswer: Double!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Evaluación"
        questionTextArea.text = ""
        
        let path = Bundle.main.path(forResource: "Property List", ofType: "plist")
        questions = NSArray(contentsOfFile: path!)
        
        if (currentQuestion == -1) {
            submitButton.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (sender as! UIButton == withoutHelpButton) ||
            (sender as! UIButton == withHelpButton) {
            if currentQuestion == -1 {
                let alerta = UIAlertController(title: "No se puede continuar",
                                               message: "Seleccione una pregunta para pasar al simulador.",
                                               preferredStyle: .alert)
                
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                present(alerta, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    
    @IBAction func displayNewQuestion(_ sender: UIButton) {
        currentQuestion = Int(arc4random_uniform(UInt32(questions.count)))
        let dict = questions[currentQuestion] as! NSDictionary
        
        // Create new question
        let question:String = dict.value(forKey: "description") as! String
        let identifier = dict.value(forKey: "identifier") as! String
        
        submitButton.isEnabled = true
        
        switch identifier {
        case "ONE":
            currentAnswer = 1
            break
        case "TWO":
            currentAnswer = 2
            break
        case "THREE":
            currentAnswer = 1
            break
        default:
            // nothing
            print("ERROR")
        }
        
        // set question visible to the user
        questionTextArea.text = question
        answerTextField.text = ""
    }

    @IBAction func submitAnswer(_ sender: UIButton) {
        var isCorrect:Bool = false
        
        if Double(answerTextField.text!) == nil {
            let alerta = UIAlertController(title: "Valor inválido",
                                           message: "La respuesta tiene un formato no numérico o inválido. Corrígalo y vuelva a intentarlo.",
                                           preferredStyle: .alert)
            
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
        } else {
            isCorrect = (abs(Double(answerTextField.text!)! - currentAnswer) < 0.1)
            
            var alerta:UIAlertController
            
            if isCorrect {
                alerta = UIAlertController(title: "MUY BIEN!",
                                               message: "Continúa así.",
                                               preferredStyle: .alert)
            } else {
                alerta = UIAlertController(title: "Inténtalo de nuevo",
                                               message: "Con paciencia y esfuerzo todo se puede!",
                                               preferredStyle: .alert)
            }
            
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
        }
    }
    
    @IBAction func hideKeyboard() {
       view.endEditing(true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "with_help" {

        } else {
            
        }
        hideKeyboard()
    }
}
