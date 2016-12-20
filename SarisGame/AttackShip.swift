//
//  AttackShip.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 12/11/16.
//  Copyright © 2016 Hadjilogics. All rights reserved.
//

import Foundation
import SceneKit

public class AttackShip : SCNNode{
    
    var theSpeed = Float(5.0)
    var shipNode = SCNNode()
    
    func createShip() {
        var geometry:SCNGeometry
        //geometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        geometry = SCNPyramid(width: 1.0, height: 1.0, length: 1.0)
        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIColor.red
        geometry.firstMaterial = redMaterial
        shipNode.geometry = geometry
        self.addChildNode(shipNode)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.physicsBody?.isAffectedByGravity = false
        self.position = SCNVector3Make(0.0, 0.0, 0.0)
    }
    
    func moveShip(target: SCNVector3) {
        // Internal run timer for the game!
        let difY = Float(target.y) - Float(self.presentation.position.y)
        let difX = Float(target.x) - Float(self.presentation.position.x)
        let angle = atan(difY / difX)
        var velocityY = Float(0.0);
        var velocityX = Float(0.0);
        if(difY >= 0)
        {
            if(difX >= 0)
            {
                velocityY = sin(angle) * theSpeed
                velocityX = cos(angle) * theSpeed
            }
            else
            {
                velocityY = sin(angle) * theSpeed * -1
                velocityX = cos(angle) * theSpeed * -1
            }
        }
        else
        {
            if(difX >= 0)
            {
                velocityY = sin(angle) * theSpeed
                velocityX = cos(angle) * theSpeed
            }
            else
            {
                velocityY = sin(angle) * theSpeed * -1
                velocityX = cos(angle) * theSpeed * -1
            }
        }
        let velocity = SCNVector3Make(velocityX, velocityY, 0)
        shipNode.rotation = SCNVector4Make(0.0, 0.0, 1.0, angle)
        self.physicsBody?.velocity = velocity
    }
    
    func setNodeName(nodeName: String)
    {
        for node:SCNNode in self.childNodes
        {
            node.name = nodeName;
        }
    }
}


