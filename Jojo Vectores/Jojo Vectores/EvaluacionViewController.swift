//
//  EvaluacionViewController.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import UIKit
import Foundation

protocol RestoreQuestionState {
    func setValues(questionIndex: Int, questionsAnswered: Int)
}

class EvaluacionViewController: UIViewController {
    @IBOutlet weak var questionTextArea: UITextView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var withoutHelpButton: UIButton!
    @IBOutlet weak var withHelpButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var questions: NSArray!
    var currentQuestion = -1
    var currentAnswer: Double!
    
    var delegate:RestoreQuestionState?
    
    var num_questions: Int!
    var answered_questions: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Evaluación"
        questionTextArea.text = ""
        
        let path = Bundle.main.path(forResource: "Property List", ofType: "plist")
        questions = NSArray(contentsOfFile: path!)
        
        if (currentQuestion == -1) {
            submitButton.isEnabled = false
            progressBar.progress = 0.0
            answered_questions = 0
        } else {
            showQuestion(currentQuestion: currentQuestion)
        }
        
        UserDefaults.standard.synchronize()
        
        num_questions = UserDefaults.standard.integer(forKey: "num_questions")
        progressLabel.text = String(answered_questions) + "/" + String(num_questions)
        progressBar.progress = Float(answered_questions) / Float(num_questions!)
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
    
    func createQuestion() {
        currentQuestion = Int(arc4random_uniform(UInt32(questions.count)))
        showQuestion(currentQuestion: currentQuestion)
    }
    
    func showQuestion(currentQuestion: Int) {
        let dict = questions[currentQuestion] as! NSDictionary
        var var_respuesta = 0.0
        // Create new question
        let question:String = dict.value(forKey: "description") as! String
        let identifier = dict.value(forKey: "identifier") as! String
        var question_result = "" // aqui se pone la pregunta ya con los valores seleccionados
        submitButton.isEnabled = true
        
        switch identifier {
        case "ONE":
            // VARIABLES
            let var_metros = Double(arc4random_uniform(UInt32(100.0)))// MAX METROS
            let var_grados = Double(arc4random_uniform(UInt32(80.0)))
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_METROS", with: String(describing: var_metros))
            question_result = question_result.replacingOccurrences(of: "VAR_ANGULO", with: String(describing: var_grados))
            // RESPUESTA
            var_respuesta = Double(var_metros) * cos(Double(var_grados) * Double.pi / 180.0)
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        ////////////////////////////////////////////////////////////////////////////////////////////
        case "TWO":
            // VARIABLES
            let var_metros = Double(arc4random_uniform(UInt32(100.0)))// MAX METROS
            let var_grados = Double(arc4random_uniform(UInt32(80.0)))
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_METROS", with: String(describing: var_metros))
            question_result = question_result.replacingOccurrences(of: "VAR_ANGULO", with: String(describing: var_grados))
            // RESPUESTA
            var_respuesta = Double(var_metros) * sin(Double(var_grados) * Double.pi / 180.0)
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        ////////////////////////////////////////////////////////////////////////////////////////////
        case "THREE":
            // VARIABLES
            let var_metros_x = Double(arc4random_uniform(UInt32(100.0)))// MAX METROS
            let var_metros_y = Double(arc4random_uniform(UInt32(100.0)))
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_METROS_X", with: String(describing: var_metros_x))
            question_result = question_result.replacingOccurrences(of: "VAR_METROS_Y", with: String(describing: var_metros_y))
            // RESPUESTA
            var_respuesta = sqrt((var_metros_x * var_metros_x) * (var_metros_y * var_metros_y))
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        ////////////////////////////////////////////////////////////////////////////////////////////
        case "FOUR":
            // VARIABLES
            let var_fuerza_1 = Double(arc4random_uniform(UInt32(200.0)))// MAX METROS
            let var_fuerza_2 = Double(arc4random_uniform(UInt32(200.0)))
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_FUERZA_1", with: String(describing: var_fuerza_1))
            question_result = question_result.replacingOccurrences(of: "VAR_FUERZA_2", with: String(describing: var_fuerza_2))
            // RESPUESTA
            var_respuesta = var_fuerza_1 + var_fuerza_2
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        ////////////////////////////////////////////////////////////////////////////////////////////
        case "FIVE":
            // VARIABLES
            let var_metros_x = Double(arc4random_uniform(UInt32(100.0)))// MAX METROS
            let var_metros_y = Double(arc4random_uniform(UInt32(100.0)))
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_METROS_X", with: String(describing: var_metros_x))
            question_result = question_result.replacingOccurrences(of: "VAR_METROS_Y", with: String(describing: var_metros_y))
            // RESPUESTA
            var_respuesta = atan((var_metros_y / var_metros_x) * Double.pi / 180.0)
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        ////////////////////////////////////////////////////////////////////////////////////////////
        case "SIX":
            // VARIABLES
            let var_peso = Double(arc4random_uniform(UInt32(50.0)))// MAX METROS
            let var_grados_1 = Double(arc4random_uniform(UInt32(80.0)))
            let var_grados_2 = Double(arc4random_uniform(UInt32(80.0)))
            //
            //            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_PESO", with: String(describing: var_peso))
            question_result = question_result.replacingOccurrences(of: "VAR_GRADOS_1", with: String(describing: var_grados_1))
            question_result = question_result.replacingOccurrences(of: "VAR_GRADOS_2", with: String(describing: var_grados_2))
            //            // RESPUESTA
            
            let parte_uno = ((cos(var_grados_1 * Double.pi / 180.0) / cos(var_grados_2 * Double.pi / 180.0)) * sin(var_grados_2 * Double.pi / 180.0)) + sin(var_grados_2 * Double.pi / 180.0)
            var_respuesta = var_peso / parte_uno
            
            //
            //
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        case "SEVEN":
            // VARIABLES
            let var_peso_1 = Double(arc4random_uniform(UInt32(100.0)))// MAX METROS
            let var_peso_2 = Double(arc4random_uniform(UInt32(100.0)))
            
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_PESO_1", with: String(describing: var_peso_1))
            question_result = question_result.replacingOccurrences(of: "VAR_PESO_2", with: String(describing: var_peso_2))
            // RESPUESTA
            var_respuesta = asin((var_peso_1 / (var_peso_2 * 2)) * Double.pi / 180.0)
            
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        case "EIGHT":
            // VARIABLES
            let var_grados = Double(arc4random_uniform(UInt32(80.0)))// MAX METROS
            let var_peso = Double(arc4random_uniform(UInt32(100.0)))
            
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_PESO", with: String(describing: var_peso))
            question_result = question_result.replacingOccurrences(of: "VAR_GRADOS", with: String(describing: var_grados))
            // RESPUESTA
            var_respuesta = var_peso * sin(var_grados * Double.pi / 180.0)
            
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        case "NINE":
            // VARIABLES
            let var_fuerza_1 = Double(arc4random_uniform(UInt32(100.0)))// MAX METROS
            let var_fuerza_2 = Double(arc4random_uniform(UInt32(100.0)))
            let var_fuerza_3 = Double(arc4random_uniform(UInt32(100.0)))
            
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_FUERZA_1", with: String(describing: var_fuerza_1))
            question_result = question_result.replacingOccurrences(of: "VAR_FUERZA_2", with: String(describing: var_fuerza_2))
            question_result = question_result.replacingOccurrences(of: "VAR_FUERZA_3", with: String(describing: var_fuerza_3))
            
            // RESPUESTA
            let var_x_1 = var_fuerza_1 * cos(45 * Double.pi / 180.0)
            let var_x_2 = var_fuerza_1 * cos(42 * Double.pi / 180.0)
            let var_x_3 = var_fuerza_1 * cos(79 * Double.pi / 180.0)
            
            let var_y_1 = var_fuerza_1 * sin(45 * Double.pi / 180.0)
            let var_y_2 = var_fuerza_1 * sin(42 * Double.pi / 180.0)
            let var_y_3 = var_fuerza_1 * sin(79 * Double.pi / 180.0)
            
            let var_x_total = var_x_1 + var_x_2 + var_x_3
            let var_y_total = var_y_1 + var_y_2 + var_y_3
            
            var_respuesta = sqrt((var_x_total * var_x_total) + (var_y_total * var_y_total))
            
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        case "TEN":
            // VARIABLES
            let var_distancia_1 = Double(arc4random_uniform(UInt32(100.0)))// NORTE
            let var_distancia_2 = Double(arc4random_uniform(UInt32(100.0))) // OESTE
            let var_distancia_3 = Double(arc4random_uniform(UInt32(100.0))) // SUR
            let var_distancia_4 = Double(arc4random_uniform(UInt32(100.0))) // ESTE
            
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_DIST_1", with: String(describing: var_distancia_1))
            question_result = question_result.replacingOccurrences(of: "VAR_DIST_2", with: String(describing: var_distancia_2))
            question_result = question_result.replacingOccurrences(of: "VAR_DIST_3", with: String(describing: var_distancia_3))
            question_result = question_result.replacingOccurrences(of: "VAR_DIST_4", with: String(describing: var_distancia_4))
            
            // RESPUESTA
            let var_x_total = var_distancia_1 - var_distancia_3
            let var_y_total = var_distancia_4 - var_distancia_2
            
            var_respuesta = sqrt((var_x_total * var_x_total) + (var_y_total * var_y_total))
            
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        case "ELEVEN":
            // VARIABLES
            let var_distancia_1 = Double(arc4random_uniform(UInt32(100.0)))// ESTE
            let var_distancia_2 = Double(arc4random_uniform(UInt32(100.0))) // SUR
            let var_distancia_3 = Double(arc4random_uniform(UInt32(100.0))) // ESTE
            let var_distancia_4 = Double(arc4random_uniform(UInt32(100.0))) // NORTE
            
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_DIST_1", with: String(describing: var_distancia_1))
            question_result = question_result.replacingOccurrences(of: "VAR_DIST_2", with: String(describing: var_distancia_2))
            question_result = question_result.replacingOccurrences(of: "VAR_DIST_3", with: String(describing: var_distancia_3))
            question_result = question_result.replacingOccurrences(of: "VAR_DIST_4", with: String(describing: var_distancia_4))
            
            // RESPUESTA
            let var_x_total = var_distancia_1 + var_distancia_3
            let var_y_total = var_distancia_4 - var_distancia_2
            
            var_respuesta = sqrt((var_x_total * var_x_total) + (var_y_total * var_y_total))
            
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        case "TWELVE":
            // VARIABLES
            let var_fuerza_1 = Double(arc4random_uniform(UInt32(100.0)))
            let var_fuerza_2 = Double(arc4random_uniform(UInt32(100.0)))
            
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_FUERZA_1", with: String(describing: var_fuerza_1))
            question_result = question_result.replacingOccurrences(of: "VAR_FUERZA_2", with: String(describing: var_fuerza_2))
            
            // RESPUESTA
            if(var_fuerza_1 > var_fuerza_2){
                var_respuesta = 1
            }else{
                var_respuesta = 2
            }
            
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
        case "THIRTEEN":
            // VARIABLES
            let var_fuerza_1 = Double(arc4random_uniform(UInt32(100.0)))// MAX METROS
            let var_fuerza_2 = Double(arc4random_uniform(UInt32(100.0)))
            let var_fuerza_3 = Double(arc4random_uniform(UInt32(100.0)))
            
            // EDITAR TEXTO DEL PROBLEMA
            question_result = question.replacingOccurrences(of: "VAR_FUERZA_1", with: String(describing: var_fuerza_1))
            question_result = question_result.replacingOccurrences(of: "VAR_FUERZA_2", with: String(describing: var_fuerza_2))
            question_result = question_result.replacingOccurrences(of: "VAR_FUERZA_3", with: String(describing: var_fuerza_3))
            
            // RESPUESTA
            let var_x_1 = var_fuerza_1 * cos(30 * Double.pi / 180.0)
            let var_x_2 = var_fuerza_1 * cos(40 * Double.pi / 180.0)
            let var_x_3 = var_fuerza_1 * cos(50 * Double.pi / 180.0)
            
            let var_y_1 = var_fuerza_1 * sin(30 * Double.pi / 180.0)
            let var_y_2 = var_fuerza_1 * sin(40 * Double.pi / 180.0)
            let var_y_3 = var_fuerza_1 * sin(50 * Double.pi / 180.0)
            
            let var_x_total = var_x_1 + var_x_2 + var_x_3
            let var_y_total = var_y_1 + var_y_2 + var_y_3
            
            var_respuesta = sqrt((var_x_total * var_x_total) + (var_y_total * var_y_total))
            
            currentAnswer = var_respuesta
            // IMPRIMIR RESPUESTA EN CONSOLA
            print(currentAnswer)
            break
            
            
            
            
        default:
            // nothing
            print("ERROR")
        }
        
        // set question visible to the user
        questionTextArea.text = question_result
        answerTextField.text = ""
        
        delegate?.setValues(questionIndex: currentQuestion, questionsAnswered: answered_questions)
    }
    
    @IBAction func displayNewQuestion(_ sender: UIButton) {
        createQuestion()
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
            
            if isCorrect {
                answered_questions! += 1
                progressBar.progress = Float(answered_questions) / Float(num_questions!)
                
                progressLabel.text = String(answered_questions) + "/" + String(num_questions)
                
                if (answered_questions != num_questions) {
                    createQuestion()
                }
            }
        }
    }
    
    @IBAction func startAgain(_ sender: UIButton) {
        answered_questions = 0
        progressLabel.text = String(answered_questions) + "/" + String(num_questions)
        progressBar.progress = 0.0
        createQuestion()
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
