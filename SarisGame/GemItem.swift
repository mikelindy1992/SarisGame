//
//  GemItem.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 12/16/16.
//  Copyright © 2016 Hadjilogics. All rights reserved.
//
import Foundation
import SceneKit


public class GemItem : SCNNode{
    
    var theSpeed = Float(5.0)
    
    func createGem() {
        // Make the top of the gem
        let gemTop:SCNNode = SCNNode()
        let geometryTop:SCNGeometry = SCNPyramid(width: 1.0, height: 1.0, length: 1.0)
        let topMaterial = SCNMaterial()
        topMaterial.diffuse.contents = UIColor.red
        geometryTop.firstMaterial = topMaterial
        gemTop.geometry = geometryTop;
        
        // Make the top of the gem
        let gemBottom:SCNNode = SCNNode()
        let geometryBottom:SCNGeometry = SCNPyramid(width: 1.0, height: 2.0, length: 1.0)
        let bottomMaterial = SCNMaterial()
        bottomMaterial.diffuse.contents = UIColor.red
        geometryBottom.firstMaterial = bottomMaterial
        gemBottom.geometry = geometryBottom;
        gemBottom.runAction(SCNAction.rotateBy(x: CGFloat(M_PI), y: 0.0, z: 0.0, duration: 0.01))
        
        self.addChildNode(gemTop)
        self.addChildNode(gemBottom)
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
