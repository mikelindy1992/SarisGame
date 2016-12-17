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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupView()
        setupScene()
        setupCamera()
        setupItems()
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
        
        // Add the user controls to the screen
        /*let button = UIButton()
        self.view?.addSubview(button)
        button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.setTitle("Shop", for: UIControlState.normal)
        button.addTarget(self, action: #selector(HomeView.shopButtonPressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
         */
        
        let button2 = UIButton()
        self.view?.addSubview(button2)
        button2.backgroundColor = UIColor.gray
        button2.setTitleColor(UIColor.white, for: UIControlState.normal)
        button2.setTitle("Ship Edit", for: UIControlState.normal)
        button2.addTarget(self, action: #selector(HomeView.shipEditButtonPressed), for: UIControlEvents.touchUpInside)
        button2.frame = CGRect(x: 300, y: 100, width: 100, height: 50)
        
        let button3 = UIButton()
        self.view?.addSubview(button3)
        button3.backgroundColor = UIColor.gray
        button3.setTitleColor(UIColor.white, for: UIControlState.normal)
        button3.setTitle("Battle!", for: UIControlState.normal)
        button3.addTarget(self, action: #selector(HomeView.battleButtonPressed), for: UIControlEvents.touchUpInside)
        button3.frame = CGRect(x: 500, y: 200, width: 100, height: 50)
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
        let gemItem = GemItem()
        gemItem.createGem()
        gemItem.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2.0, z: 0.0, duration: 1.0)))
        gemItem.position = SCNVector3Make(-6.0, -0.5, 0.0)
        scnScene.rootNode.addChildNode(gemItem)
        gemItem.setNodeName(nodeName: "SHOP ITEM")
        
        let shopText = SCNText(string: String("Shop"), extrusionDepth:1.0)
        let shopTextNode = SCNNode()
        shopText.font = UIFont (name: "Arial", size: 1.0)
        shopText.firstMaterial!.diffuse.contents = UIColor.white
        shopText.firstMaterial!.specular.contents = UIColor.white
        shopTextNode.geometry = shopText
        scnScene.rootNode.addChildNode(shopTextNode)
        shopTextNode.position = SCNVector3Make(-6.5, -4.0, 0.5)
        
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
        self.present(ShopView(), animated: true, completion: nil)
    }
    
    func shipEditButtonPressed()
    {
        self.present(ShipEditView(), animated: true, completion: nil)
    }
    
    func battleButtonPressed()
    {
        self.present(BattleWorldView(), animated: true, completion: nil)
    }
}
