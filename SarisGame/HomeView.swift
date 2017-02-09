//
//  LoginScene.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 12/12/16.
//  Copyright © 2016 Hadjilogics. All rights reserved.
//

import UIKit
import SceneKit

class HomeView : UIViewController
{
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var allowChange: Bool = false;
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupCamera()
        setupItems()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        allowChange = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        // Detect when an item is clicked
        let touch = touches.first!
        // 2
        let location = touch.location(in: scnView)
        // 3
        let hitResults = scnView.hitTest(location, options: nil)
        // 4
        if hitResults.count > 0 {
            // 5
            let result = hitResults.first!
            // 6
            handleTouchFor(node: result.node)
        }
        
        super.touchesBegan(touches, with: event)
    }
    
    func setupView()
    {
        // Setup the background for the scene
        self.view?.backgroundColor = UIColor.black
        let screen = UIScreen.main.bounds
        
        let frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
        let image = UIImage(named: "SpaceBackground.jpg")
        let imageView = UIImageView(image: image)
        imageView.frame = frame
        self.view?.addSubview(imageView)
        
        
        // Setup the SCN Scene
        scnView = SCNView()
        scnView = SCNView(frame: UIScreen.main.bounds)
        self.view.addSubview(scnView)
        
        scnView?.backgroundColor = UIColor.clear
        
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
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func setupItems()
    {
        // Setup the Shop Item
        let gemItem = GemItem()
        gemItem.createGem()
        gemItem.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2.0, z: 0.0, duration: 1.0)))
        gemItem.position = SCNVector3Make(-6.0, -0.5, 0.0)
        scnScene.rootNode.addChildNode(gemItem)
        gemItem.setNodeName(nodeName: "SHOP ITEM")
        
        let shopText = SCNText(string: String("Shop"), extrusionDepth:0.5)
        let shopTextNode = SCNNode()
        shopText.font = UIFont (name: "Arial", size: 1.0)
        shopText.firstMaterial!.diffuse.contents = UIColor.white
        shopText.firstMaterial!.specular.contents = UIColor.white
        shopTextNode.geometry = shopText
        scnScene.rootNode.addChildNode(shopTextNode)
        shopTextNode.position = SCNVector3Make(-6.5, -4.0, 0.5)
        
        // Add Ship Item
        let shipItem = AttackShip()
        shipItem.createShip()
        shipItem.runAction(SCNAction.rotateBy(x: 0.0, y: 0.5, z: CGFloat(M_PI/2.0*(-1)), duration: 0.01))
        shipItem.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: -2.0, y: 0.0, z: 0.0, duration: 1.25)))
        shipItem.position = SCNVector3Make(0.0, 3.5, 0.0)
        scnScene.rootNode.addChildNode(shipItem)
        shipItem.setNodeName(nodeName: "SHIP EDIT")
        
        let shipText = SCNText(string: String("Ships"), extrusionDepth:0.5)
        let shipTextNode = SCNNode()
        shipText.font = UIFont (name: "Arial", size: 1.0)
        shipText.firstMaterial!.diffuse.contents = UIColor.white
        shipText.firstMaterial!.specular.contents = UIColor.white
        shipTextNode.geometry = shipText
        scnScene.rootNode.addChildNode(shipTextNode)
        shipTextNode.position = SCNVector3Make(-1.5, 0.0, 0.5)
        
        // Setup the Battle Item
        let tokenItem = TokenItem()
        tokenItem.createToken()
        tokenItem.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 1.5, z: 0.0, duration: 1.0)))
        tokenItem.position = SCNVector3Make(5.5, -1.0, 0.0)
        scnScene.rootNode.addChildNode(tokenItem)
        tokenItem.setNodeName(nodeName: "BATTLE WORLD")
        
        let battleText = SCNText(string: String("Battle"), extrusionDepth:0.5)
        let battleTextNode = SCNNode()
        battleText.font = UIFont (name: "Arial", size: 1.0)
        battleText.firstMaterial!.diffuse.contents = UIColor.white
        battleText.firstMaterial!.specular.contents = UIColor.white
        battleTextNode.geometry = battleText
        scnScene.rootNode.addChildNode(battleTextNode)
        battleTextNode.position = SCNVector3Make(4.0, -4.0, 0.5)
    }
    
    func handleTouchFor(node: SCNNode)
    {
        // We have pressed the shop item
        if(node.name == "SHOP ITEM")
        {
            shopButtonPressed()
        }
        else if(node.name == "SHIP EDIT")
        {
            shipEditButtonPressed()
        }
        else if(node.name == "BATTLE WORLD")
        {
            battleButtonPressed()
        }
    }
    
    func shopButtonPressed()
    {
        if(allowChange)
        {
            self.present(ShopView(), animated: true, completion: nil)
        }
        allowChange = false;
    }
    
    func shipEditButtonPressed()
    {
        if(allowChange)
        {
            self.present(ShipEditView(), animated: true, completion: nil)
        }
        allowChange = false
    }
    
    func battleButtonPressed()
    {
        if(allowChange)
        {
            self.present(BattleWorldView(), animated: true, completion: nil)
        }
        allowChange = false
    }
}
