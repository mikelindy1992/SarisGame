//
//  LoginScene.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 12/12/16.
//  Copyright © 2016 Hadjilogics. All rights reserved.
//

import UIKit
import SceneKit

class ShipEditView : UIViewController
{
    
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var theUserObject: UserInfo = UserInfo()
    
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
        //Move the capture point to a random point on the map
        
        super.touchesBegan(touches, with: event)
    }
    
    func setupView()
    {
        
        
        // Set the background color for the view
        self.view?.backgroundColor = UIColor.black
        let screen = UIScreen.main.bounds
        
        // Add the background image!
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
        
        // var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        let button = UIButton()
        self.view?.addSubview(button)
        button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.setTitle("Back", for: UIControlState.normal)
        button.addTarget(self, action: #selector(ShipEditView.backButtonPressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        // Add a scroll view to see the ships
        let sv = UIScrollView(frame: CGRect(x: 25, y: self.view.bounds.height-100, width: self.view.bounds.width - 50, height: 75))
        print("x:",self.view.bounds.width - 50, "y:", 75)
        self.view?.addSubview(sv)
        sv.backgroundColor = UIColor.clear
        sv.showsHorizontalScrollIndicator = false
        
        // This would be loaded from the DB, hard coded for now!
        // Use the ship information object from JSON
        let json:String = "{\"user_id\":1,\"crystals\":100,\"tokens\":20,\"ship_parts\":100,\"item_parts\":100,\"ships\":[{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1}]}"
        
        if(!theUserObject.BuildObjectFromJSON(jsonString: json))
        {
            // There was an in the JSON! Leave the page and send a notification
            //backButtonPressed()
            
            //send an alert
            print("JSON for User Object was invalid!")
        }
        else
        {
            let startX = 15
            let startY = 12
            let itemWidth = 50
            let itemHeight = 50
            let itemSpace = 10
            var index = 0;
            
            // Add the background view to the scroll object
            let scrollImage = UIImage(named: "ShipScrollView.png")
            let scrollImageView = UIImageView(image: scrollImage)
            let numberOfShips = theUserObject.GetShips().count
            let imageWidth = CGFloat(startX + 5 + (numberOfShips * itemWidth) + (numberOfShips * itemSpace))
            scrollImageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: sv.bounds.size.height)
            sv.addSubview(scrollImageView)
            
            for ship in theUserObject.GetShips()
            {
                let shipButton = UIButton()
                let x = startX + (index * itemWidth) + (index * itemSpace)
                sv.addSubview(shipButton)
                shipButton.backgroundColor = UIColor.clear
                let buttonBackground = UIImage(named: "ShipButtonBackground.png")
                shipButton.setBackgroundImage(buttonBackground, for: .normal)
                shipButton.frame = CGRect(x: x, y: startY, width: itemWidth, height: itemHeight)
                shipButton.accessibilityLabel = String(index)
                shipButton.addTarget(self, action: #selector(ShipEditView.shipButtonPressed(button:)), for: UIControlEvents.touchUpInside)
                index += 1
            }
            
            var sz = sv.bounds.size
            sz.width = CGFloat(startX + 5 + (index * itemWidth) + (index * itemSpace))
            sv.contentSize = sz
        }
        
        
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
        // Add Ship Item
        let shipItem = AttackShip()
        shipItem.createShip()
        shipItem.scale = SCNVector3Make(2.0, 2.0, 2.0)
        shipItem.runAction(SCNAction.rotateBy(x: 0.0, y: 0.5, z: CGFloat(M_PI/2.0*(-1)), duration: 0.01))
        shipItem.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: -2.0, y: 0.0, z: 0.0, duration: 1.25)))
        shipItem.position = SCNVector3Make(0.0, 2.0, 0.0)
        scnScene.rootNode.addChildNode(shipItem)
        shipItem.setNodeName(nodeName: "SHIP EDIT")
    }
    
    func shipButtonPressed(button: UIButton)
    {
        let indexString: String = button.accessibilityLabel ?? "-1"
        let shipIndex: Int = Int(indexString)!
        
        print("Ship Type :",theUserObject.GetShips()[shipIndex].GetShipType())
    }
    
    func backButtonPressed()
    {
        self.present(HomeView(), animated: true, completion: nil)
    }
}
