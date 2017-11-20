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

protocol SaveSimulatorState {
    func setValues(p: [VectorEndPoints], a: [SKShapeNode], v: [SKShapeNode])
}

class GameViewController: UIViewController {
    var realScene = GameScene()
    var delegate: SaveSimulatorState?

    @IBOutlet weak var magLb: UILabel!
    @IBOutlet weak var dirLb: UILabel!
    @IBOutlet weak var stackLb: UIStackView!
    @IBOutlet weak var stackTop: UIStackView!
    @IBOutlet weak var SumLb: UILabel!
    @IBOutlet weak var SumLb2: UILabel!
    @IBOutlet weak var Componentesbt: UIButton!
    @IBOutlet weak var movebt: UIButton!
    @IBOutlet weak var sumbt: UIButton!
    @IBOutlet weak var compX: UILabel!
    @IBOutlet weak var compY: UILabel!
    
    var points = [VectorEndPoints]() // holds the points that conform each vector drawn by the user.
    var arrows = [SKShapeNode]() // holds each triangle made by the vector to emulate their arrow tip.
    var vectors = [SKShapeNode]() // holds each line that represents a vector visually to the user.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtons()
        setLabels()
        setConstraints()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        if let scene = GKScene(fileNamed: "GameScene") {
            
            // Get the SKScene from the loaded GKScene
            if let sceneNode = scene.rootNode as! GameScene? {
                
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                let bckColor = UIColor(rgb: 0x1A1423)
                sceneNode.backgroundColor = bckColor
                realScene = sceneNode
                realScene.arrows = arrows
                realScene.vectors = vectors
                realScene.points = points
                realScene.controller = self
                
                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(realScene)
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
    
    @IBAction func resetVectors(_ sender: UIBarButtonItem) {
        realScene.resetSimulator()
    }
    
    @IBAction func calculateSum(_ sender: UIButton) {
        realScene.sumVectors()
    }

    func setConstraints(){
        print(UIDevice.current.modelName)
        switch UIDevice.current.modelName {
        case "iPhone 5":
            stackTop.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        case "iPhone 5c":
            stackTop.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        case "iPhone 5s":
            stackTop.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        case "iPhone 6":
            stackTop.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        case "iPhone 6 Plus":
            stackTop.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        case "iPhone 7":
            stackTop.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        case "iPhone 7 Plus":
            stackTop.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        case "iPhone SE":
            stackTop.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        case "iPhone 8":
            stackTop.widthAnchor.constraint(equalToConstant: 350.0).isActive = true
        case "iPhone 8 Plus":
            stackTop.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        case "iPhone X":
            stackTop.widthAnchor.constraint(equalToConstant: 400.0).isActive = true
        case "Simulator":
            stackTop.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        default:
            stackTop.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        }

    }
    
    func setButtons(){
        let buttonColor = UIColor(rgb: 0x633239)
        let buttonBckColor = UIColor(rgb: 0xB75D69)
        let buttonBorderColor = UIColor(rgb: 0x4F282D)
        Componentesbt.tintColor = buttonColor
        Componentesbt.backgroundColor = buttonBckColor
        Componentesbt.layer.cornerRadius = 10
        Componentesbt.clipsToBounds = true
        Componentesbt.layer.borderColor = buttonBorderColor.cgColor
        Componentesbt.layer.borderWidth = 1.5
        movebt.tintColor = buttonColor
        movebt.backgroundColor = buttonBckColor
        movebt.layer.cornerRadius = 10
        movebt.clipsToBounds = true
        movebt.layer.borderColor = buttonBorderColor.cgColor
        movebt.layer.borderWidth = 1.0
        sumbt.tintColor = buttonColor
        sumbt.backgroundColor = buttonBckColor
        sumbt.layer.cornerRadius = 10
        sumbt.clipsToBounds = true
        sumbt.layer.borderColor = buttonBorderColor.cgColor
        sumbt.layer.borderWidth = 0.7
    }
    
    func setLabels(){
        let labelColors = UIColor(rgb: 0xEACDC2)
        let labelBckColor = UIColor(rgb: 0x1A1423)
        magLb.textColor = labelColors
        magLb.backgroundColor = labelBckColor
        dirLb.textColor = labelColors
        dirLb.backgroundColor = labelBckColor
        
        let sumColor = UIColor(rgb: 0xCBEF43)
        let sumBckColor = UIColor(rgb: 0x1A1423)
        SumLb.textColor = sumColor
        SumLb.backgroundColor = sumBckColor
        SumLb2.textColor = sumColor
        SumLb2.backgroundColor = sumBckColor
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
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        // When you want to send data back to the caller
        // call the method on the delegate
        if let delegate = self.delegate {
            delegate.setValues(p: points, a: arrows, v: vectors)
        }
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
