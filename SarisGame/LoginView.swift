//
//  LoginScene.swift
//  SarisGame
//
//  Created by Michael Lindenmayer on 12/12/16.
//  Copyright © 2016 Hadjilogics. All rights reserved.
//
import Foundation
import UIKit
import SceneKit
import Firebase

class LoginView : UIViewController
{
    
    var usernameInput: UITextField!
    var passwordInput: UITextField!

    
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
        
        usernameInput = UITextField()
        self.view?.addSubview(usernameInput)
        usernameInput.backgroundColor = UIColor.white
        usernameInput.frame = CGRect(x: (screen.width/2) - 150, y: 100, width: 300, height: 30)
        usernameInput.autocorrectionType = UITextAutocorrectionType.no
        usernameInput.textAlignment = .center
        usernameInput.placeholder = "Username"
        
        passwordInput = UITextField()
        self.view?.addSubview(passwordInput)
        passwordInput.backgroundColor = UIColor.white
        passwordInput.frame = CGRect(x: (screen.width/2) - 150, y: 150, width: 300, height: 30)
        passwordInput.isSecureTextEntry = true;
        passwordInput.textAlignment = .center
        passwordInput.placeholder = "Pasword"
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
        label.center = CGPoint(x: (screen.width/2), y: 212.5)
        label.textAlignment = .center
        label.text = "I Forgot My Password"
        label.isUserInteractionEnabled = true
        label.textColor = UIColor.white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.passwordReset(_ : )))
        label.addGestureRecognizer(tap)
        
        self.view.addSubview(label)
        
        let button = UIButton()
        self.view?.addSubview(button)
        let buttonImage = UIImage(named: "ButtonBackground.png")
        button.backgroundColor = UIColor.clear
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(buttonImage, for: .normal)
        button.setTitle("Login", for: UIControlState.normal)
        button.addTarget(self, action: #selector(LoginView.loginButtonPressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: (screen.width / 2) - 125, y: 250, width: 100, height: 50)
        
        let button2 = UIButton()
        self.view?.addSubview(button2)
        button2.backgroundColor = UIColor.clear
        button2.setTitleColor(.black, for: .normal)
        button2.setBackgroundImage(buttonImage, for: .normal)
        button2.setTitle("Register", for: UIControlState.normal)
        button2.addTarget(self, action: #selector(LoginView.registerButtonPressed), for: UIControlEvents.touchUpInside)
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

        self.present(RegisterView(), animated: true, completion: nil)
    }
    
    func loginButtonPressed()
    {
        
        let username :String? = usernameInput.text
        let password :String? = passwordInput.text
        if isValidEmail(testStr: username!) && password != nil{
            FIRAuth.auth()?.signIn(withEmail: username!, password: password!) { (user, error) in
                if error == nil {
                    self.loginSuccess(uid : user!)
                }else{
                    self.loginFailed()
                }
    
            }
        }else{
            self.invalidEmail()
        }
    }
    
    func loginSuccess(uid : FIRUser?)
    {
        
        
        // Since login was successful we can go to the home view
        self.present(HomeView(), animated: true, completion: nil)
    }
    
    func loginFailed()
    {
        // The login failed post an alert describing the failure
        let alert = UIAlertController(title: "Login Failed", message: "Unable to log in, please check login info or signup!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func passwordReset(_ sender: UITapGestureRecognizer)
    {
        let email = usernameInput.text ?? "uname"

        
        FIRAuth.auth()?.sendPasswordReset(withEmail: email) { (error) in
            var message : String?
            if error == nil {
                message = "A password reset email has been sent to the specified email"
                
            }else{
                if let errCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
                    switch errCode {
                    case .errorCodeInvalidEmail:
                        //this case only handles emails that are not in the correct format
                        message = "There is no account associated with the email provided"
                    default:
                        message = "Your password reset request could not be processed at this time"
                    }
                }
            }
            let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }


    }
}
