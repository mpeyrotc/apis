//
//  CreditsViewController.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController {

    @IBOutlet weak var linkTextView: UITextView!
    
    @IBOutlet weak var creditsTxt: UITextView!
    @IBOutlet weak var linkTxt: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setButtons()
        // Do any additional setup after loading the view.
        navigationItem.title = "Créditos"
        
        linkTextView.isEditable = false
        linkTextView.dataDetectorTypes = .link
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
    }
    
    func setButtons(){
        let bckColor = UIColor(rgb: 0xE0DFD5)
        view.backgroundColor = bckColor
        creditsTxt.backgroundColor = bckColor
        linkTxt.backgroundColor = bckColor
    }
}
