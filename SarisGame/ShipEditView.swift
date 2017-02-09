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
    var theCurrentShip: ShipObject!
    var theItemOne: ItemObject!
    var theItemTwo: ItemObject!
    var theItemThree: ItemObject!
    var theEquipItemCount: Int = 0
    var theShipStatsView: UIView!
    
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
        
        // Add the ship stats view!
        let backgroundImage = UIImageView(image: UIImage(named: "ShipEditStatView.png"))
        self.view?.addSubview(backgroundImage)
        backgroundImage.frame = CGRect(x: self.view.bounds.width - 225, y: 25, width: 200, height: self.view.bounds.height-150)
        theShipStatsView = UIView(frame: CGRect(x: self.view.bounds.width - 225, y: 25, width: 200, height: self.view.bounds.height-150))
        print("h:",self.view.bounds.height-150)
        self.view?.addSubview(theShipStatsView)
        theShipStatsView.backgroundColor = UIColor.clear
        
        // This would be loaded from the DB, hard coded for now!
        // Use the ship information object from JSON
        let json:String = "{\"user_id\":1,\"crystals\":100,\"tokens\":20,\"ship_parts\":100,\"item_parts\":100,\"ships\":[{\"ship_id\":1,\"ship_type\":1,\"ship_level\":1},{\"ship_id\":2,\"ship_type\":1,\"ship_level\":6}],\"items\":[{\"item_id\":1,\"item_type\":1,\"item_stat\":50,\"item_ship_id\":1,\"item_ability\":1}]}"
        
        if(!theUserObject.BuildObjectFromJSON(jsonString: json))
        {
            // There was an in the JSON! Leave the page and send a notification
            //backButtonPressed()
            
            //send an alert
            print("JSON for User Object was invalid!")
        }
        else
        {
            theCurrentShip = theUserObject.GetShips().first
            setupShipScrollView()
            setupShipStatView()
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
        shipItem.position = SCNVector3Make(-0.5, 2.0, 0.0)
        scnScene.rootNode.addChildNode(shipItem)
        shipItem.setNodeName(nodeName: "SHIP EDIT")
    }
    
    func setupShipScrollView()
    {
        //***
        // This block of code setus up the scroll view to see your ships
        //***
        let sv = UIScrollView(frame: CGRect(x: 25, y: self.view.bounds.height-100, width: self.view.bounds.width - 50, height: 75))
        self.view?.addSubview(sv)
        sv.backgroundColor = UIColor.clear
        sv.showsHorizontalScrollIndicator = false
        
        //***
        // This block of code dynamically adds buttons to the scroll view
        // based on the number and type of your ships
        //***
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
        if(imageWidth >= sv.bounds.size.width)
        {
            scrollImageView.frame = CGRect(x: 0, y: 0, width: imageWidth, height: sv.bounds.size.height)
        }
        else
        {
            scrollImageView.frame = CGRect(x: 0, y: 0, width: sv.bounds.size.width, height: sv.bounds.size.height)
        }
        
        sv.addSubview(scrollImageView)
        
        for ship in theUserObject.GetShips()
        {
            let shipButton = UIButton()
            let x = startX + (index * itemWidth) + (index * itemSpace)
            sv.addSubview(shipButton)
            shipButton.backgroundColor = UIColor.clear
            let imageName = ship.GetShipIconForCategory(cat: ship.GetShipCategory())
            shipButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
            shipButton.frame = CGRect(x: x, y: startY, width: itemWidth, height: itemHeight)
            shipButton.accessibilityLabel = String(index)
            shipButton.addTarget(self, action: #selector(ShipEditView.shipButtonPressed(button:)), for: UIControlEvents.touchUpInside)
            index += 1
        }
        
        var sz = sv.bounds.size
        let scrollViewWidth = CGFloat(startX + 5 + (index * itemWidth) + (index * itemSpace))
        if(scrollViewWidth >= sv.bounds.size.width)
        {
            sz.width = scrollViewWidth
        }
        sv.contentSize = sz
    }
    
    func setupShipStatView()
    {
        let font = UIFont(name: "Courier", size: 16)
        let boldFontDesc = font?.fontDescriptor.withSymbolicTraits(.traitBold)
        let boldFont = UIFont(descriptor: boldFontDesc!, size: 16)
        // Add the Ship Name Label
        let shipNameLabel = UILabel(frame: CGRect(x: 15, y: 20, width: 80, height: 20))
        theShipStatsView.addSubview(shipNameLabel)
        shipNameLabel.text = theCurrentShip.GetShipName()
        shipNameLabel.textColor = UIColor.white
        shipNameLabel.font = boldFont
        
        // Add the Ship Level Label
        let shipLevelLabel = UILabel(frame: CGRect(x: 105, y: 20, width: 80, height: 20))
        theShipStatsView.addSubview(shipLevelLabel)
        shipLevelLabel.text = "Lv ".appending(String(theCurrentShip.GetShipLevel()))
        shipLevelLabel.textColor = UIColor.white
        shipLevelLabel.font = boldFont
        
        // Add the Ship Shield Labels
        let shieldLabel = UILabel(frame: CGRect(x: 15, y: 45, width: 80, height: 15))
        theShipStatsView.addSubview(shieldLabel)
        shieldLabel.text = "SHLD"
        shieldLabel.textColor = UIColor.white
        shieldLabel.textAlignment = .right
        let shieldStatLabel = UILabel(frame: CGRect(x: 105, y: 45, width: 80, height: 15))
        theShipStatsView.addSubview(shieldStatLabel)
        shieldStatLabel.text = String(theCurrentShip.GetShipShield())
        shieldStatLabel.textColor = UIColor.yellow
        shieldLabel.font = font
        shieldStatLabel.font = font
        
        // Add the Ship Attack Labels
        let attackLabel = UILabel(frame: CGRect(x: 15, y: 60, width: 80, height: 15))
        theShipStatsView.addSubview(attackLabel)
        attackLabel.text = "ATK"
        attackLabel.textColor = UIColor.white
        attackLabel.textAlignment = .right
        let attackStatLabel = UILabel(frame: CGRect(x: 105, y: 60, width: 80, height: 15))
        theShipStatsView.addSubview(attackStatLabel)
        attackStatLabel.text = String(theCurrentShip.GetShipAtk())
        attackStatLabel.textColor = UIColor.yellow
        attackLabel.font = font
        attackStatLabel.font = font
        
        // Add the Ship Attack Speed Labels
        let attackSpdLabel = UILabel(frame: CGRect(x: 15, y: 75, width: 80, height: 15))
        theShipStatsView.addSubview(attackSpdLabel)
        attackSpdLabel.text = "ATK SPD"
        attackSpdLabel.textColor = UIColor.white
        attackSpdLabel.textAlignment = .right
        let attackSpdStatLabel = UILabel(frame: CGRect(x: 105, y: 75, width: 80, height: 15))
        theShipStatsView.addSubview(attackSpdStatLabel)
        attackSpdStatLabel.text = String(theCurrentShip.GetShipAtkSpeed())
        attackSpdStatLabel.textColor = UIColor.yellow
        attackSpdLabel.font = font
        attackSpdStatLabel.font = font
        
        // Add the Ship Speed Labels
        let spdLabel = UILabel(frame: CGRect(x: 15, y: 90, width: 80, height: 15))
        theShipStatsView.addSubview(spdLabel)
        spdLabel.text = "SPD"
        spdLabel.textColor = UIColor.white
        spdLabel.textAlignment = .right
        let spdStatLabel = UILabel(frame: CGRect(x: 105, y: 90, width: 80, height: 15))
        theShipStatsView.addSubview(spdStatLabel)
        spdStatLabel.text = String(theCurrentShip.GetShipSpeed())
        spdStatLabel.textColor = UIColor.yellow
        spdLabel.font = font
        spdStatLabel.font = font
        
        // Add the Ship Range Labels
        let rangeLabel = UILabel(frame: CGRect(x: 15, y: 105, width: 80, height: 15))
        theShipStatsView.addSubview(rangeLabel)
        rangeLabel.text = "RANGE"
        rangeLabel.textColor = UIColor.white
        rangeLabel.textAlignment = .right
        let rangeStatLabel = UILabel(frame: CGRect(x: 105, y: 105, width: 80, height: 15))
        theShipStatsView.addSubview(rangeStatLabel)
        rangeStatLabel.text = String(theCurrentShip.GetShipRange())
        rangeStatLabel.textColor = UIColor.yellow
        rangeLabel.font = font
        rangeStatLabel.font = font
        
        // Add the Ship Respawn Labels
        let respawnLabel = UILabel(frame: CGRect(x: 15, y: 120, width: 80, height: 15))
        theShipStatsView.addSubview(respawnLabel)
        respawnLabel.text = "RSPWN"
        respawnLabel.textColor = UIColor.white
        respawnLabel.textAlignment = .right
        let respawnStatLabel = UILabel(frame: CGRect(x: 105, y: 120, width: 80, height: 15))
        theShipStatsView.addSubview(respawnStatLabel)
        respawnStatLabel.text = String(theCurrentShip.GetShipRespawn())
        respawnStatLabel.textColor = UIColor.yellow
        respawnLabel.font = font
        respawnStatLabel.font = font
        
        // Loop through the items and get the items for the current ship id
        var imageOneName = "MissingItemIcon.png"
        var imageTwoName = "MissingItemIcon.png"
        var imageThreeName = "MissingItemIcon.png"
        theEquipItemCount = 0
        
        // Assign the items for the current ship
        for item in theUserObject.GetItems()
        {
            if(item.GetItemShipId() == theCurrentShip.GetShipId())
            {
                theEquipItemCount += 1
                if(theEquipItemCount == 1)
                {
                    theItemOne = item
                }
                if(theEquipItemCount == 2)
                {
                    theItemTwo = item
                }
                if(theEquipItemCount == 3)
                {
                    theItemThree = item
                }
            }
        }
        
        if(theEquipItemCount >= 1)
        {
            imageOneName = theItemOne.GetItemImageName()
        }
        
        let itemOneButton = UIButton()
        theShipStatsView.addSubview(itemOneButton)
        itemOneButton.backgroundColor = UIColor.clear
        itemOneButton.setBackgroundImage(UIImage(named: imageOneName), for: .normal)
        itemOneButton.frame = CGRect(x: 15, y: 160, width: 50, height: 50)
        
        if(theEquipItemCount >= 2)
        {
            imageTwoName = theItemTwo.GetItemImageName()
        }
        
        let itemTwoButton = UIButton()
        theShipStatsView.addSubview(itemTwoButton)
        itemTwoButton.backgroundColor = UIColor.clear
        itemTwoButton.setBackgroundImage(UIImage(named: imageTwoName), for: .normal)
        itemTwoButton.frame = CGRect(x: 75, y: 160, width: 50, height: 50)
        
        if(theEquipItemCount >= 3)
        {
            imageThreeName = theItemThree.GetItemImageName()
        }
        
        let itemThreeButton = UIButton()
        theShipStatsView.addSubview(itemThreeButton)
        itemThreeButton.backgroundColor = UIColor.clear
        itemThreeButton.setBackgroundImage(UIImage(named: imageThreeName), for: .normal)
        itemThreeButton.frame = CGRect(x: 135, y: 160, width: 50, height: 50)
    }
    
    func shipButtonPressed(button: UIButton)
    {
        let indexString: String = button.accessibilityLabel ?? "-1"
        let shipIndex: Int = Int(indexString)!
        theCurrentShip = theUserObject.GetShips()[shipIndex]
        
        for view in theShipStatsView.subviews
        {
            view.removeFromSuperview()
        }
        
        setupShipStatView()
    }
    
    func backButtonPressed()
    {
        self.present(HomeView(), animated: true, completion: nil)
    }
}
