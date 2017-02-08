//
//  RegisterView.swift
//  SarisGame
//
//  Created by Casey Santilli on 2/6/17.
//  Copyright © 2017 Hadjilogics. All rights reserved.
//

import Foundation
import UIKit
import SceneKit
import Firebase

class RegisterView : UIViewController
{
    
    var emailInput: UITextField!
    var passwordInput : UITextField!
    var firstNameInput: UITextField!
    
    
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
        let screen = UIScreen.main.bounds
        
        let frame = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
        let image = UIImage(named: "SpaceBackground.jpg")
        let imageView = UIImageView(image: image)
        imageView.frame = frame
        self.view?.addSubview(imageView)
        
        
        //self.view?.backgroundColor = UIColor(patternImage: image!)
        
        firstNameInput = UITextField()
        self.view?.addSubview(firstNameInput)
        firstNameInput.backgroundColor = UIColor.white
        firstNameInput.frame = CGRect(x: (screen.width/2) - 150, y: 50, width: 300, height: 30)
        firstNameInput.autocorrectionType = UITextAutocorrectionType.no
        firstNameInput.textAlignment = .center
        firstNameInput.placeholder = "Name"
        
        emailInput = UITextField()
        self.view?.addSubview(emailInput)
        emailInput.backgroundColor = UIColor.white
        emailInput.frame = CGRect(x: (screen.width/2) - 150, y: 100, width: 300, height: 30)
        emailInput.autocorrectionType = UITextAutocorrectionType.no
        emailInput.textAlignment = .center
        emailInput.placeholder = "Email"
        
        passwordInput = UITextField()
        self.view?.addSubview(passwordInput)
        passwordInput.backgroundColor = UIColor.white
        passwordInput.frame = CGRect(x: (screen.width/2) - 150, y: 150, width: 300, height: 30)
        passwordInput.isSecureTextEntry = true;
        passwordInput.textAlignment = .center
        passwordInput.placeholder = "Pasword"
        
        
        let button = UIButton()
        self.view?.addSubview(button)
        let buttonImage = UIImage(named: "ButtonBackground.png")
        button.backgroundColor = UIColor.clear
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(buttonImage, for: .normal)
        button.setTitle("Register", for: UIControlState.normal)
        button.addTarget(self, action: #selector(LoginView.registerButtonPressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: (screen.width / 2) - 125, y: 250, width: 100, height: 50)
        
        let button2 = UIButton()
        self.view?.addSubview(button2)
        button2.backgroundColor = UIColor.clear
        button2.setTitleColor(.black, for: .normal)
        button2.setBackgroundImage(buttonImage, for: .normal)
        button2.setTitle("Cancel", for: UIControlState.normal)
        button2.addTarget(self, action: #selector(RegisterView.cancelButtonPressed), for: UIControlEvents.touchUpInside)
        button2.frame = CGRect(x: (screen.width / 2) + 25, y: 250, width: 100, height: 50)
        
    }
    
    func invalidEmail(){
        let alert = UIAlertController(title: "Invalid Email", message: "The email you provided is in an invalid format!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    func registerButtonPressed()
    {
        
        let email :String? = emailInput.text
        let password :String? = passwordInput.text
        let name :String? = firstNameInput.text
        if isValidEmail(testStr: email!) && password != nil && name != nil{
            FIRAuth.auth()?.createUser(withEmail: email!, password: password!) { (user, error) in
                if error != nil{
                    self.registerFailed(error : "Email already in use!")
                }else{
                    //once user account is created, append first name
                    let changeRequest = FIRAuth.auth()?.currentUser?.profileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges() { (error) in
                        if error == nil {
                            self.registerSuccess()
                        }else{
                            self.registerFailed(error : "Registration unavailable at this time!")
                        }
                        
                    }
                    
                }
                
                
            }
        }else{
            self.invalidEmail()
        }
    }
    
    func cancelButtonPressed()
    {
        //move back to login screen
        self.present(LoginView(), animated: true, completion: nil)
        
    }
    
    func registerSuccess()
    {
        self.present(LoginView(), animated: true, completion: nil)
    }
    
    func registerFailed(error :String)
    {
        let alert = UIAlertController(title: "Registration Failed", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
