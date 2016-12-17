//
//  GameScene.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 12/12/16.
//  Copyright © 2016 Hadjilogics. All rights reserved.
//

import Foundation
import SceneKit

class BattleView : UIViewController
{
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var timer: Timer!
    var playerOne: AttackShip!
    var capturePoint: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupCamera()
        spawnShape()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //Move the capture point to a random point on the map
        let randomX:UInt32 = arc4random_uniform(60)
        let randomY:UInt32 = arc4random_uniform(40)
        capturePoint.position = SCNVector3Make(Float(randomX) - 30.0, Float(randomY) - 20.0, 0.0)
        playerOne.position = SCNVector3Make(0.0, 0.0, 0.0)
        
        super.touchesBegan(touches, with: event)
    }
    
    func setupView()
    {
        scnView = SCNView()
        scnView = SCNView(frame: UIScreen.main.bounds)
        self.view.insertSubview(scnView, at: 0)
        
        scnView?.backgroundColor = UIColor.black
        
        scnView.showsStatistics = false
        scnView.allowsCameraControl = false
        scnView.autoenablesDefaultLighting = true
    }
    
    func setupScene()
    {
        scnScene = SCNScene()
        scnView.scene = scnScene
    }
    
    func setupCamera()
    {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 50)
        scnScene.rootNode.addChildNode(cameraNode)
        
        // setup an interal game timer
        timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(BattleView.runEvent), userInfo: nil, repeats: true)
    }
    
    func spawnShape()
    {
        // Create a Square for the player
        playerOne = AttackShip()
        playerOne.createShip()
        scnScene.rootNode.addChildNode(playerOne)
        
        // Create a Circle for the spawn point!
        var geometry2:SCNGeometry
        geometry2 = SCNSphere(radius: 2.0 )
        capturePoint = SCNNode(geometry: geometry2)
        capturePoint.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        capturePoint.physicsBody?.isAffectedByGravity = false
        let randomX:UInt32 = arc4random_uniform(30)
        let randomY:UInt32 = arc4random_uniform(20)
        capturePoint.position = SCNVector3Make(Float(randomX), Float(randomY), 0.0)
        scnScene.rootNode.addChildNode(capturePoint)
    }
    
    func runEvent()
    {
        playerOne.moveShip(target: capturePoint.position)
    }
}
