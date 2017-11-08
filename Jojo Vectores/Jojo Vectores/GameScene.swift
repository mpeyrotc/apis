//
//  GameScene.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import SpriteKit
import GameplayKit

class VectorEndPoints {
    var startPoint: CGPoint?
    var endPoint: CGPoint?
}

class GameScene: SKScene {
    var path = UIBezierPath()
    var initialPos = CGPoint()
    var shape = SKShapeNode()
    var triangle = GKTriangle()
    var addVectorNow = false
    var points = [VectorEndPoints]()
    var arrows = [SKShapeNode]()
    var showingComponents = false
    
    override func sceneDidLoad() {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if addVectorNow {
            initialPos = pos
            shape = SKShapeNode()
            shape.name = "vector"
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if addVectorNow {
            path.removeAllPoints()
            shape.removeFromParent()
            shape = SKShapeNode()
            shape.name = "vector"
            path.move(to: initialPos)
            path.addLine(to: pos)
            
            shape.path = path.cgPath
            shape.position = CGPoint(x: frame.midX, y: frame.midY)
            shape.strokeColor = UIColor.blue
            shape.lineWidth = 10
            addChild(shape)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if addVectorNow {
            path.removeAllPoints()
            shape.removeFromParent()
            shape = SKShapeNode()
            shape.name = "vector"
            path.move(to: initialPos)
            path.addLine(to: pos)
            
            let newPoint = VectorEndPoints()
            newPoint.startPoint = initialPos
            newPoint.endPoint = pos
            points.append(contentsOf: [newPoint])
            
            shape.path = path.cgPath
            shape.position = CGPoint(x: frame.midX, y: frame.midY)
            shape.strokeColor = UIColor.blue
            shape.lineWidth = 10
            addChild(shape)
            addVectorNow = false
            
            path = createArrowTip(start: initialPos, end: pos)
            shape = SKShapeNode()
            shape.name = "arrow"
            
            shape.path = path.cgPath
            shape.strokeColor = UIColor.orange
            shape.fillColor = UIColor.orange
            shape.lineWidth = 5
            addChild(shape)
        }
    }
    
    func addVector() {
        addVectorNow = true
    }
    
    func removeVector() {
        if !children.isEmpty {
            children[children.count - 1].removeFromParent()
            _ = points.popLast()
        }
    }
    
    func showComponents() {
        if !showingComponents {
            points.forEach { (vectorPoints) in
                var path = UIBezierPath()
                
                shape = SKShapeNode()
                shape.name = "component"
                path.move(to: vectorPoints.startPoint!)
                var x = CGPoint()
                x.x = vectorPoints.endPoint!.x
                x.y = vectorPoints.startPoint!.y
                path.addLine(to: x)
                
                shape.path = path.cgPath
                shape.position = CGPoint(x: frame.midX, y: frame.midY)
                shape.strokeColor = UIColor.red
                shape.lineWidth = 5
                addChild(shape)
                
                path = UIBezierPath()
                
                shape = SKShapeNode()
                shape.name = "component"
                path.move(to: vectorPoints.startPoint!)
                var y = CGPoint()
                y.x = vectorPoints.startPoint!.x
                y.y = vectorPoints.endPoint!.y
                path.addLine(to: y)
                
                shape.path = path.cgPath
                shape.position = CGPoint(x: frame.midX, y: frame.midY)
                shape.strokeColor = UIColor.red
                shape.lineWidth = 5
                addChild(shape)
            }
            
            showingComponents = true
        } else {
            self.enumerateChildNodes(withName: "component") {
                node, stop in
                node.removeFromParent()
            }
            
            showingComponents = false
        }
    }
    
    func createArrowTip(start: CGPoint, end: CGPoint) -> UIBezierPath {
        let pendienteOriginal = (end.y - start.y) / (end.x - start.x)
        let pendientePerpendicular = -1 / pendienteOriginal
        let bNueva = end.y - pendientePerpendicular * end.x
        
        let cx = end.x - 12
        let cy = pendientePerpendicular * cx + bNueva
        let dx = end.x + 12
        let dy = pendientePerpendicular * dx + bNueva
        let angle = atan2(end.y - start.y, end.x - start.x)
        let ex = end.x + 40 * cos(angle)
        let ey = end.y + 40 * sin(angle)
        
        path = UIBezierPath()
        path.move(to: CGPoint(x: cx, y: cy))
        path.addLine(to: CGPoint(x: ex, y: ey))
        path.addLine(to: CGPoint(x: dx, y: dy))
        path.close()
        return path
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
}
