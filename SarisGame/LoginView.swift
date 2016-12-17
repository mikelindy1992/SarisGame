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

class LoginView : UIViewController
{
    
    var usernameInput: UITextField!
    var passwordInput: UITextField!
    var hasPassword: Bool!
    
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
        usernameInput.placeholder = "Username"
        
        passwordInput = UITextField()
        self.view?.addSubview(passwordInput)
        passwordInput.backgroundColor = UIColor.white
        passwordInput.frame = CGRect(x: (screen.width/2) - 150, y: 150, width: 300, height: 30)
        passwordInput.isSecureTextEntry = true;
        passwordInput.placeholder = "Pasword"
        
        let button = UIButton()
        self.view?.addSubview(button)
        let buttonImage = UIImage(named: "ButtonBackground.png")
        button.backgroundColor = UIColor.clear
        button.setTitleColor(.black, for: .normal)
        button.setBackgroundImage(buttonImage, for: .normal)
        button.setTitle("Login", for: UIControlState.normal)
        button.addTarget(self, action: #selector(LoginView.loginButtonPressed), for: UIControlEvents.touchUpInside)
        button.frame = CGRect(x: (screen.width / 2) - 125, y: 200, width: 100, height: 50)
        
        let button2 = UIButton()
        self.view?.addSubview(button2)
        button2.backgroundColor = UIColor.clear
        button2.setTitleColor(.black, for: .normal)
        button2.setBackgroundImage(buttonImage, for: .normal)
        button2.setTitle("Register", for: UIControlState.normal)
        button2.addTarget(self, action: #selector(LoginView.registerButtonPressed), for: UIControlEvents.touchUpInside)
        button2.frame = CGRect(x: (screen.width / 2) + 25, y: 200, width: 100, height: 50)
    }
    
    func registerButtonPressed()
    {
        var request = URLRequest(url: URL(string: "http://www.millslindy.com/game_login.php")!)
        request.httpMethod = "POST"
        let username = usernameInput.text ?? "uname"
        let password = passwordInput.text ?? "password"
        let postString = "action=REGISTER&uname=" + username + "&pass=" + password
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do
            {
                //let responseString = String(data: data, encoding: .utf8)
                let parsedData = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! Dictionary<String, AnyObject>
                let resultStr = parsedData["success"] as! String
                print("responseString = \(parsedData["success"] as! String )")
                if(resultStr == "true")
                {
                    DispatchQueue.main.async {
                        self.registerSuccess()
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        self.registerFailed()
                    }
                }
            }
            catch
            {
                print(error)
            }
            
            
        }
        task.resume()
    }
    
    func loginButtonPressed()
    {
        var request = URLRequest(url: URL(string: "http://www.millslindy.com/game_login.php")!)
        request.httpMethod = "POST"
        let username = usernameInput.text ?? "uname"
        let password = passwordInput.text ?? "password"
        let postString = "action=LOGIN&uname=" + username + "&pass=" + password
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            do
            {
                //let responseString = String(data: data, encoding: .utf8)
                let parsedData = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! Dictionary<String, AnyObject>
                let resultStr = parsedData["success"] as! String
                print("responseString = \(parsedData["success"] as! String )")
                if(resultStr == "true")
                {
                    DispatchQueue.main.async {
                        self.loginSuccess()
                    }
                }
                else
                {
                    DispatchQueue.main.async {
                        self.loginFailed()
                    }
                }
            }
            catch
            {
                print(error)
            }
            
            
        }
        task.resume()
    }
    
    func registerSuccess()
    {
        self.present(HomeView(), animated: true, completion: nil)
    }
    
    func registerFailed()
    {
        let alert = UIAlertController(title: "Registration Failed", message: "Username is already in use, please use another name!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func loginSuccess()
    {
        // Save login info to user defaults
        let defaults = UserDefaults.standard
        
        let uname = usernameInput.text ?? "uname"
        let pass = passwordInput.text ?? "password"
        
        defaults.set(uname, forKey: "username")
        defaults.set(pass, forKey: "password")
        
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
}
