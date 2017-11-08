//
//  GameScene.swift
//  Jojo Vectores
//
//  Created by Marco A. Peyrot on 10/23/17.
//  Copyright © 2017 Marco A. Peyrot. All rights reserved.
//

import SpriteKit
import GameplayKit

// MARK: - Helper classes

/* This is a placeholder for the vertices, start and end, of each vector.
 *
 * Its main function is to keep track of this information for calculations
 * and drawing.
 */
class VectorEndPoints {
    var startPoint: CGPoint? // the start point of the vector
    var endPoint: CGPoint? // the end point of the vector
}

// MARK: - Main scene logic

class GameScene: SKScene {
    // global variables for the scene
    var path = UIBezierPath() // the path drawn by the user when creating a vector.
    var initialPos = CGPoint()  // holds the initial position of the new vector, the place where the user
                                // laid down his finger for the first time.
    var shape = SKShapeNode() // holds the object that will be drawn on the device screen.
    var triangle = GKTriangle() // holds the object (arrow tip) of the newly created vector.
    var addVectorNow = false // flag the application that the user wants to create a new vector.
    var showingComponents = false // flag the application that the user wants to show the components of the vectors.
    var viewController: GameViewController!
    var magnitude: Double! // magnitude of the new vector being created.
    var angulo: Double! // angle of the new vector being created, with respect to the horizontal.
    
    // helper data structures
    var points = [VectorEndPoints]() // holds the points that conform each vector drawn by the user.
    var arrows = [SKShapeNode]() // holds each triangle made by the vector to emulate their arrow tip.
    var vectors = [SKShapeNode]() // holds each line that represents a vector visually to the user.
    
    override func sceneDidLoad() {
        // not used, called before content is shown to the user
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    // Callback function that is called each time the user presses the device
    func touchDown(atPoint pos : CGPoint) {
        if addVectorNow {
            initialPos = pos
            shape = SKShapeNode()
            shape.name = "vector"
        }
    }
    
    // Callback function that is called each time the user moves 
    // his finger without separating it from the screen.
    func touchMoved(toPoint pos : CGPoint) {
        if addVectorNow {
            // remove the previous vector added to avoid seeing the path made by the user.
            vectors.popLast()?.removeFromParent()
            arrows.popLast()?.removeFromParent()
            createVectorBody(pos: pos)
            createVectorTip(pos: pos)
        }
    }
    
    // Callback function that is called each time the user removes his finger from the screen.
    func touchUp(atPoint pos : CGPoint) {
        if addVectorNow {
            createVectorBody(pos: pos)
            createVectorTip(pos: pos)
            
            // save the points of the newly created vector.
            let newPoint = VectorEndPoints()
            newPoint.startPoint = initialPos
            newPoint.endPoint = pos
            points.append(contentsOf: [newPoint])
            
            // set the new vector flag to off, since the vector has been created by the user.
            addVectorNow = false
        }
    }
    
    // MARK: - Helper functions
    
    // Creates a component for the vector represented by the two given points A and B.
    // The parameter y, specifies the type of component to create.
    func createComponent(pointA: CGPoint, pointB: CGPoint, y: Bool) {
        let path = UIBezierPath()
        shape = SKShapeNode()
        shape.name = "component"
        path.move(to: pointA)
        
        var x = CGPoint()
        if y {
            x.x = pointB.x
            x.y = pointA.y
        } else {
            x.x = pointA.x
            x.y = pointB.y
        }
        path.addLine(to: x)
        
        shape.path = path.cgPath
        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.strokeColor = UIColor.red
        shape.lineWidth = 5
        addChild(shape)
    }
    
    // shows the components as red lines for all vectors in view.
    func showComponents() {
        if !showingComponents {
            points.forEach { (vectorPoints) in
                // create X component.
                createComponent(pointA: vectorPoints.startPoint!, pointB: vectorPoints.endPoint!, y: true)
                // create Y component.
                createComponent(pointA: vectorPoints.endPoint!, pointB: vectorPoints.startPoint!, y: false)
            }
            
            showingComponents = true
        } else {
            // remove all nodes from the scene that are identified by the 'component' name.
            self.enumerateChildNodes(withName: "component") {
                node, stop in
                node.removeFromParent()
            }
            
            showingComponents = false
        }
    }
    
    // shows in the screen the line of the vector.
    func createVectorBody(pos: CGPoint) {
        path.removeAllPoints()
        shape = SKShapeNode()
        shape.name = "vector"
        path.move(to: initialPos)
        //viewController.magnitudeTextField.text = String(initialPos)
        path.addLine(to: pos)
        //print("Magnitude: " + String(getMagnitude(toPoint: pos)))
        //print("Angle: " + String(getAngle(toPoint: pos)))
        shape.path = path.cgPath
        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.strokeColor = UIColor.blue
        shape.lineWidth = 10
        addChild(shape)
        vectors.append(shape)
    }
    
    // shows in the screen the arrow tip of the vector.
    func createVectorTip(pos: CGPoint) {
        path = createArrowTip(start: initialPos, end: pos)
        shape = SKShapeNode()
        shape.name = "arrow"
        
        shape.path = path.cgPath
        shape.strokeColor = UIColor.blue
        shape.fillColor = UIColor.blue
        shape.lineWidth = 5
        addChild(shape)
        
        arrows.append(shape)
    }
    
    // Returns the magnitude of the new vector
    func getMagnitude(toPoint pos: CGPoint) -> Double {
        let x1 = Double(initialPos.x)
        let y1 = Double(initialPos.y)
        let x2 = Double(pos.x)
        let y2 = Double(pos.y)
        
        return sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2))
    }
    
    // Returns the angle of the new vector, with respect to the horizontal
    func getAngle(toPoint pos: CGPoint) -> Double {
        let x1 = Double(initialPos.x)
        let y1 = Double(initialPos.y)
        let x2 = Double(pos.x)
        let y2 = Double(pos.y)
        var angle = atan2((y2 - y1), (x2 - x1))
        angle = angle * 360 / (3.14 * 2)
        
        if angle < 0{
            let diff = angle + 180
            angle = 180 + diff
        }
        
        return angle
    }
    
    // Creates the arrow of the vector as a simple triangle.
    // This triangle is not added to the scene, it must be
    // inserted into a Node first.
    func createArrowTip(start: CGPoint, end: CGPoint) -> UIBezierPath {
        let pendienteOriginal = (end.y - start.y) / (end.x - start.x) // slope of the vector.
        var pendientePerpendicular = -1 / pendienteOriginal // slope of the line perpendicular to the vector,
                                                            // it intercepts the end point of the same vector.
        let angle = atan2(end.y - start.y, end.x - start.x)
        
        // locate the reference point to create the arrow tip, depending on the angle of the new vector.
        var phasedPoint = CGPoint()
        
        phasedPoint.x = end.x - 40 * cos(angle)
        phasedPoint.y = end.y - 40 * sin(angle)
        
        // Since vertical lines' slope is undefined, at certain points we set the slope to a default value.
        if abs(pendientePerpendicular) > 1.2 {
            pendientePerpendicular = (pendientePerpendicular / abs(pendientePerpendicular)) * 1.2
        }
        
        // create b from y = mx + b line equation
        let bNueva = phasedPoint.y - pendientePerpendicular * phasedPoint.x
        
        // define the three vertices of the triangle (arrow tip)
        let cx = phasedPoint.x - 12
        let cy = pendientePerpendicular * cx + bNueva
        let dx = phasedPoint.x + 12
        let dy = pendientePerpendicular * dx + bNueva
        let ex = phasedPoint.x + 40 * cos(angle)
        let ey = phasedPoint.y + 40 * sin(angle)
        
        // create the path that represents the arrow
        path = UIBezierPath()
        path.move(to: CGPoint(x: cx, y: cy))
        path.addLine(to: CGPoint(x: ex, y: ey))
        path.addLine(to: CGPoint(x: dx, y: dy))
        path.close()
        return path
    }
    
    // MARK: - Default methods of GameKit
    
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
    
    // MARK: - External communication methods
    
    // Sets the flag to add a new vector.
    func addVector() {
        addVectorNow = true
    }
    
    // Removes the last vector added by the user, can be called several times.
    func removeVector() {
        if !vectors.isEmpty {
            let v = vectors.popLast()!
            v.removeFromParent()
            
            let a = arrows.popLast()!
            a.removeFromParent()
            
            _ = points.popLast()
        }
    }
}
