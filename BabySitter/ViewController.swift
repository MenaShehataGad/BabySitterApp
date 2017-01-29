//
//  ViewController.swift
//  BabySitter
//
//  Created by Mina Shehata Gad on 1/28/17.
//  Copyright © 2017 Mina Shehata Gad. All rights reserved.
//

import UIKit




class ViewController: UIViewController {

    @IBOutlet var txtUserName: UITextField!
    @IBOutlet var loginBtnCheck: UIButton!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var failErorrLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.txtUserName.text?.isEmpty == true || self.txtPassword.text?.isEmpty == true {
            self.loginBtnCheck.isUserInteractionEnabled = false
        }
        else{
            self.loginBtnCheck.isUserInteractionEnabled = true
        }
        
        
        
    
    }

    
    @IBAction func loginBTN(_ sender: UIButton) {
        
        testInfo(userName: self.txtUserName.text!, userPassword: self.txtPassword.text!)
        
        if txtUserName.text == "userName" || txtPassword.text == "userPassword" {
           
            let moveToApp = self.storyboard?.instantiateViewController(withIdentifier: "GridTab") as! UITabBarController
            
            self.navigationController?.pushViewController(moveToApp, animated: true)
            
            
        }
        
        
        
    }
    
    
    
    
    func testInfo(userName: String , userPassword : String ){
        
        if userName != "userName" || userPassword != "userPassword" {
            self.failErorrLabel.text = "the username or password doesnot match"
            
        }
        
        let parameters = ["un":"userName","up":"userPassword"]
        
        
        let url = URL(string: "http://qtech-system.com/interview/index.php/apis/testApi")!
        
        
        let session = URLSession.shared
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            DispatchQueue.global().async {
            
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data) as! [String: Any]
                
                
                print(json)
                
                
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        })
        task.resume()
        
    }

    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.txtUserName.text?.isEmpty == true || self.txtPassword.text?.isEmpty == true {
            self.loginBtnCheck.isUserInteractionEnabled = false
        }
        else{
            self.loginBtnCheck.isUserInteractionEnabled = true
        }
        self.view.endEditing(true)
    }
    

}

