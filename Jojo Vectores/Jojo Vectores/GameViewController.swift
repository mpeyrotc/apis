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
    @IBOutlet weak var magLb: UILabel!
    @IBOutlet weak var dirLb: UILabel!
    @IBOutlet weak var stackLb: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
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
    
    @IBAction func moveVector(_ sender: UIButton) {
        realScene.moveVector()
    }

    @IBAction func showComponents(_ sender: UIButton) {
        realScene.showComponents()
    }
    
    
    @IBAction func calculateSum(_ sender: UIButton) {
        realScene.sumVectors()
    }

    func setConstraints(){
        print(UIDevice.current.modelName)
        switch UIDevice.current.modelName {
        case "iPhone 5":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 210.0).isActive = true
        case "iPhone 5c":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 210.0).isActive = true
        case "iPhone 5s":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 210.0).isActive = true
        case "iPhone 6":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 230.0).isActive = true
        case "iPhone 6 Plus":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        case "iPhone 7":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 230.0).isActive = true
        case "iPhone 7 Plus":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        case "iPhone SE":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 210.0).isActive = true
        case "iPhone 8":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 110.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 230.0).isActive = true
        case "iPhone 8 Plus":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        case "iPhone X":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        case "Simulator":
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        default:
            magnitudeTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            directionTextField.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            magLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            dirLb.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
            stackLb.widthAnchor.constraint(equalToConstant: 250.0).isActive = true
        }

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

public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad6,11", "iPad6,12":                    return "iPad 5"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,3", "iPad6,4":                      return "iPad Pro 9.7 Inch"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro 12.9 Inch"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro 12.9 Inch 2. Generation"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro 10.5 Inch"
        case "AppleTV5,3":                              return "Apple TV"
        case "AppleTV6,2":                              return "Apple TV 4K"
        case "AudioAccessory1,1":                       return "HomePod"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}
