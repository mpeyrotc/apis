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
    var showingSum = false // flag the application that the sum of the vectors is being shown
    var viewController: GameViewController!
    var magnitude: Double! // magnitude of the new vector being created.
    var angulo: Double! // angle of the new vector being created, with respect to the horizontal.
    var sumMag: Double! // magnitude of the resulting vector.
    var sumAng: Double! // angle of the resulting vector.
    var movingVector = false // flag the application that the user wants to move the last vector that was added.
    var lastVector = SKShapeNode() // holds the vector on which an action is being made (create or move)
    var lastArrow = SKShapeNode() // holds the vector tip on which an action is being made (create or move)
    var lastVectorPoints = VectorEndPoints()
    
    // helper data structures
    var points = [VectorEndPoints]() // holds the points that conform each vector drawn by the user.
    var arrows = [SKShapeNode]() // holds each triangle made by the vector to emulate their arrow tip.
    var vectors = [SKShapeNode]() // holds each line that represents a vector visually to the user.
    var controller: GameViewController!
    
    override func sceneDidLoad() {
        //Checar grid para diferentes modelos
        let w = ceil(UIScreen.main.bounds.width / 20.0)
        let h = ceil(UIScreen.main.bounds.height / 20.0)
        if let grid = Grid(blockSize: 40.0, rows: Int(h), cols: Int(w)){
            grid.position = CGPoint (x:frame.midX, y:frame.midY)
            addChild(grid)
        }
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
        
        if movingVector {
            // reset control variables
            shape = SKShapeNode()
            shape.name = "vector"
            initialPos = pos
            
            // get the last vector added and remove it from the control stacks
            lastVector = vectors.popLast()!
            lastArrow = arrows.popLast()!
            lastVectorPoints = points.popLast()!
        }
    }
    
    // Callback function that is called each time the user moves 
    // his finger without separating it from the screen.
    func touchMoved(toPoint pos : CGPoint) {
        if addVectorNow {
            // remove the previous vector added to avoid seeing the path made by the user.
            lastVector.removeFromParent()
            lastArrow.removeFromParent()
            createVectorBody(pos: pos, color: UIColor.blue)
            createVectorTip(pos: pos, color: UIColor.blue)
        }
        
        if movingVector {
            // erase the vector being moved from the canvas
            lastVector.removeFromParent()
            lastArrow.removeFromParent()
            
            // calculate displacement vectors
            let componentX = pos.x - initialPos.x
            let componentY = pos.y - initialPos.y
            
            // move the start point of the vector to its new position
            var initialPoint = CGPoint()
            initialPoint.x = (lastVectorPoints.startPoint?.x)! + componentX
            initialPoint.y = (lastVectorPoints.startPoint?.y)! + componentY
            // move the end point of the vector to its new position
            var endPoint = CGPoint()
            endPoint.x = (lastVectorPoints.endPoint?.x)! + componentX
            endPoint.y = (lastVectorPoints.endPoint?.y)! + componentY
            // set the vector initial position to its updated start point
            initialPos = initialPoint
            
            let newPoints = VectorEndPoints()
            newPoints.startPoint = initialPoint
            newPoints.endPoint = endPoint
            // save the new vector coordinates
            lastVectorPoints = newPoints
            
            // draw the vector body and save a copy
            path.removeAllPoints()
            shape = SKShapeNode()
            shape.name = "vector"
            path.move(to: initialPos)
            path.addLine(to: endPoint)
            shape.path = path.cgPath
            shape.position = CGPoint(x: frame.midX, y: frame.midY)
            shape.strokeColor = UIColor.blue
            shape.lineWidth = 10
            addChild(shape)
            lastVector = shape
            
            // draw the vector tip and save a copy
            path = createArrowTip(start: initialPos, end: endPoint)
            shape = SKShapeNode()
            shape.name = "arrow"
            shape.path = path.cgPath
            shape.strokeColor = UIColor.blue
            shape.fillColor = UIColor.blue
            shape.lineWidth = 5
            addChild(shape)
            lastArrow = shape
            
            // reset the initial position to the point where the user currently has his finger
            initialPos = pos
        }
    }
    
    // Callback function that is called each time the user removes his finger from the screen.
    func touchUp(atPoint pos : CGPoint) {
        if addVectorNow {
            // save the points of the newly created vector.
            let newPoint = VectorEndPoints()
            newPoint.startPoint = initialPos
            newPoint.endPoint = pos
            points.append(contentsOf: [newPoint])
            vectors.append(lastVector)
            arrows.append(lastArrow)
            
            // set the new vector flag to off, since the vector has been created by the user.
            addVectorNow = false
            
            // reset temporal variables to avoid affecting the last vector added while doing a new operation.
            lastVector = SKShapeNode()
            lastArrow = SKShapeNode()
            lastVectorPoints = VectorEndPoints()
        }
        
        if movingVector {
            // add the vector coordinates to the control stack
            let newPoints = lastVectorPoints
            initialPos = (newPoints.startPoint)!
            points.append(newPoints)
            // add the vector body and tip to the control stacks
            vectors.append(lastVector)
            arrows.append(lastArrow)
            // reset temporal variables to avoid affecting the last vector added while doing a new operation.
            lastVector = SKShapeNode()
            lastArrow = SKShapeNode()
            lastVectorPoints = VectorEndPoints()
            // set the move vector flag to off, since the vector has been located successfully to a new position.
            movingVector = false
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
    func createVectorBody(pos: CGPoint, color: UIColor) {
        path.removeAllPoints()
        shape = SKShapeNode()
        shape.name = "vector"
        path.move(to: initialPos)
        //viewController.magnitudeTextField.text = String(initialPos)
        path.addLine(to: pos)
        angulo = getAngle(toPoint: pos)
        magnitude = getMagnitude(toPoint: pos)
        self.controller.magnitudeTextField.text = String(format: "%.2f", magnitude)
        self.controller.directionTextField.text = String(format: "%.2f", angulo)
        //print("Magnitude: " + String(getMagnitude(toPoint: pos)))
        //print("Angle: " + String(getAngle(toPoint: pos)))
        shape.path = path.cgPath
        shape.position = CGPoint(x: frame.midX, y: frame.midY)
        shape.strokeColor = color
        shape.lineWidth = 10
        addChild(shape)
        lastVector = shape
    }
    
    // shows in the screen the arrow tip of the vector.
    func createVectorTip(pos: CGPoint, color: UIColor) {
        path = createArrowTip(start: initialPos, end: pos)
        shape = SKShapeNode()
        shape.name = "arrow"
        
        shape.path = path.cgPath
        shape.strokeColor = color
        shape.fillColor = color
        shape.lineWidth = 5
        
        addChild(shape)
        lastArrow = shape
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
    
    func moveVector() {
        movingVector = true
    }
    
    // Removes the last vector added by the user, can be called several times.
    func removeVector() {
        if !vectors.isEmpty {
            let v = vectors.popLast()!
            v.removeFromParent()
            
            let a = arrows.popLast()!
            a.removeFromParent()
            
            _ = points.popLast()
            
            if (points.count > 0){
                initialPos = (points.last?.startPoint)!
                magnitude = getMagnitude(toPoint: (points.last?.endPoint)!)
                angulo = getAngle(toPoint: (points.last?.endPoint)!)
                self.controller.magnitudeTextField.text = String(format: "%.2f", magnitude)
                self.controller.directionTextField.text = String(format: "%.2f", angulo)
            } else {
                self.controller.magnitudeTextField.text = "0.0"
                self.controller.directionTextField.text = "0.0"
            }
        }
    }
    
    // calculates the sum of the vectors and puts a green vector on screen
    // which represents the sum.
    func sumVectors() {
        if !showingSum && points.count > 0 {
            var componentX = CGFloat(0)
            var componentY = CGFloat(0)
            // the first vector start position is the one at which the sum vector starts.
            initialPos = points[0].startPoint!
            
            // add the components x and y for all vectors present in the canvas.
            points.forEach { p in
                componentX += p.endPoint!.x - p.startPoint!.x
                componentY += p.endPoint!.y - p.startPoint!.y
            }
            
            // create the sum vector (body and tip) but don't add them to the control stacks.
            shape = SKShapeNode()
            shape.name = "sum_vector"
            var point = CGPoint()
            point.x = initialPos.x + componentX
            point.y = initialPos.y + componentY
            
            path = UIBezierPath()
            path.move(to: initialPos)
            path.addLine(to: point)
            shape.path = path.cgPath
            shape.position = CGPoint(x: frame.midX, y: frame.midY)
            shape.strokeColor = UIColor.green
            shape.lineWidth = 10
            addChild(shape)

            path = createArrowTip(start: initialPos, end: point)
            shape = SKShapeNode()
            shape.name = "sum_vector"
            
            shape.path = path.cgPath
            shape.strokeColor = UIColor.green
            shape.fillColor = UIColor.green
            shape.lineWidth = 5
            addChild(shape)
            
            showingSum = true
            
            sumMag = getMagnitude(toPoint: point)
            sumAng = getAngle(toPoint: point)
            
            self.controller.SumLb.text = "Magnitud: " + String(format: "%.2f", sumMag)
            self.controller.SumLb2.text = "Angulo: " + String(format: "%.2f", sumAng)
        } else {
            // if the sum vector is currently being shown, remove it.
            self.enumerateChildNodes(withName: "sum_vector") {
                node, stop in
                node.removeFromParent()
            }
            self.controller.SumLb.text = "Magnitud:"
            self.controller.SumLb2.text = "Angulo:"
            showingSum = false
        }
    }
}
