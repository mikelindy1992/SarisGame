//
//  GemItem.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 12/16/16.
//  Copyright © 2016 Hadjilogics. All rights reserved.
//
import Foundation
import SceneKit


public class TokenItem : SCNNode{
    
    func createToken() {
        // Make the top of the gem
        let node:SCNNode = SCNNode()
        let geometry:SCNGeometry = SCNCylinder(radius: 1.0, height: 0.25)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.yellow
        geometry.firstMaterial = material
        node.geometry = geometry
        node.runAction(SCNAction.rotateBy(x: 0.0, y: 0.0, z: CGFloat(Float(M_PI/2)), duration: 0.01))
        self.addChildNode(node)
        self.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        self.physicsBody?.isAffectedByGravity = false
        self.position = SCNVector3Make(0.0, 0.0, 0.0)
    }
    
    func setNodeName(nodeName: String)
    {
        for node:SCNNode in self.childNodes
        {
            node.name = nodeName;
        }
    }
}
