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
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        //Move the capture point to a random point on the map
        
        super.touchesBegan(touches, with: event)
    }
    
    func setupView()
    {
        // var button   = UIButton.buttonWithType(UIButtonType.System) as UIButton
        self.view?.backgroundColor = UIColor.black
        let button = UIButton()
        self.view?.addSubview(button)
        button.backgroundColor = UIColor.gray
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.setTitle("Back", for: UIControlState.normal)
        button.addTarget(self, action: #selector(ShipEditView.backButtonPressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: 100, y: 200, width: 100, height: 50)
    }
    
    func backButtonPressed()
    {
        self.present(HomeView(), animated: true, completion: nil)
    }
}
