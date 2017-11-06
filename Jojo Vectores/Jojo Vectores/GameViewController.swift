//
//  GameViewController.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var realScene = GameScene()

    @IBOutlet weak var magnitudeTextField: UITextField!
    @IBOutlet weak var directionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                realScene = sceneNode
                realScene.viewController = self
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)
                    
                    view.ignoresSiblingOrder = true
                    
                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
        
        navigationItem.title = "Práctica"
    }

    @IBAction func addVector(_ sender: UIBarButtonItem) {
        realScene.addVector()
    }
    
    @IBAction func removeVector(_ sender: UIBarButtonItem) {
        realScene.removeVector()
    }
    
    @IBAction func showComponents(_ sender: UIButton) {
        realScene.showComponents()
    }
    
    @IBAction func calculateSum(_ sender: UIButton) {
        // pendiente
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
