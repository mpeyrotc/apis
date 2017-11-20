//
//  MaterialViewController.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import UIKit

class MaterialViewController: UIViewController {

    @IBOutlet weak var pdfView: UIWebView!
    @IBOutlet weak var tut1: UIButton!
    @IBOutlet weak var tut2: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtons()
        
        let url = Bundle.main.url(forResource: "Manual", withExtension: "pdf")
        
        if let url = url {
            
            let urlRequest = NSURLRequest(url: url)
            pdfView.loadRequest(urlRequest as URLRequest)
            
            view.addSubview(pdfView)
        }

        // Do any additional setup after loading the view.
        navigationItem.title = "Material de Estudio"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override var shouldAutorotate: Bool {
        
        return true
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MetodoGrafico" {
            if let viewController = segue.destination as? VideoViewController {
                viewController.typeOfVideo = 1
            }
        } else {
            if let viewController = segue.destination as? VideoViewController {
                viewController.typeOfVideo = 2
            }
        }
    }
    
    func setButtons(){
//        let buttonColor = UIColor(rgb: 0x633239)
//        let buttonBckColor = UIColor(rgb: 0xB75D69)
//        let buttonBorderColor = UIColor(rgb: 0x4F282D)
//        Componentesbt.tintColor = buttonColor
//        Componentesbt.backgroundColor = buttonBckColor
//        Componentesbt.layer.cornerRadius = 10
//        Componentesbt.clipsToBounds = true
//        Componentesbt.layer.borderColor = buttonBorderColor.cgColor
//        Componentesbt.layer.borderWidth = 1.5
        let buttonTopColor = UIColor(rgb: 0xEF6461)
        let buttonTintColor = UIColor(rgb: 0x002838)
        tut1.backgroundColor = buttonTopColor
        tut1.layer.cornerRadius = 10
        tut1.clipsToBounds = true
        tut1.tintColor = buttonTintColor
        tut1.layer.borderWidth = 1.5
        
        let buttonBotColor = UIColor(rgb: 0xE4B363)
        tut2.backgroundColor = buttonBotColor
        tut2.layer.cornerRadius = 10
        tut2.clipsToBounds = true
        tut2.tintColor = buttonTintColor
        tut2.layer.borderWidth = 1.5
        
        let bckColor = UIColor(rgb: 0xE0DFD5)
        view.backgroundColor = bckColor
        
    }

}
