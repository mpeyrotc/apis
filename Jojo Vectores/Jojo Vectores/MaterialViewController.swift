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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = Bundle.main.url(forResource: "Manual", withExtension: "pdf")
        
        if let url = url {
            
            let urlRequest = NSURLRequest(url: url)
            pdfView.loadRequest(urlRequest as URLRequest)
            
            view.addSubview(pdfView)
        }

        // Do any additional setup after loading the view.
        navigationItem.title = "Material de Estudio"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        
        return UIInterfaceOrientationMask.landscape
        
    }
    
    override var shouldAutorotate: Bool {
        
        return false
        
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

}
