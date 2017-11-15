//
//  MaterialViewController.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    var typeOfVideo: Int!
    
    @IBOutlet weak var videoLoader: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if typeOfVideo == 1 {
            getVideo(videoCode: "qvw7j9eKGdg")
        } else {
            getVideo(videoCode: "WAgChRfDc9s")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getVideo(videoCode: String){
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        videoLoader.loadRequest(URLRequest(url: url!))
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

