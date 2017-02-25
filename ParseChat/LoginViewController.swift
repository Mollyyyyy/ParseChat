
//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Apple on 2/23/17.
//  Copyright © 2017 Xinmeng Li. All rights reserved.
//

import UIKit
import Parse
class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func alert(){
        let alertController = UIAlertController(title: "Try again", message: "Wrong Password", preferredStyle: .alert)
        // create a cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            // handle cancel response here. Doing nothing will dismiss the view.
        }
        // add the cancel action to the alertController
        alertController.addAction(cancelAction)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
        
    }
    @IBAction func signup(_ sender: Any) {
        let user = PFUser()
        if let password = passwordTextField.text{
            user.password = password
        }else{
            self.alert()
            return
        }
        if let username = emailTextField.text{
            user.username = username
        }else{
            self.alert()
            return
        }
        
        user.signUpInBackground { (success: Bool, error:
            Error?) -> Void in
            if let error = error {
                self.alert()
                print("Error in signing up \(error.localizedDescription)")
                // Show the errorString somewhere and let the user try again.
            } else {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let chatVC = mainStoryboard.instantiateViewController(withIdentifier: "chatVC") as! ChatViewController
                self.navigationController?.pushViewController(chatVC, animated: true)
                // Hooray! Let them use the app now.
            }
        }
    }
    @IBAction func login(_ sender: Any) {
        guard let email = emailTextField.text else{
            alert()
            return
        }
        
        guard let password = passwordTextField.text else{
            alert()
            return
        }
        PFUser.logInWithUsername(inBackground: email, password: password) { (user, error) in
            if let error = error{
                self.alert()
                print("Error in logging in \(error.localizedDescription)")
            }else{
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let chatVC = mainStoryboard.instantiateViewController(withIdentifier: "chatVC") as! ChatViewController
                self.navigationController?.pushViewController(chatVC, animated: true)
                //suceessfully log in
            }
            
        }
        
        //        PFUser.logInWithUsernameInBackground(emailTextField.text!, password:passwordTextField.text!) {
        //            (user: PFUser?, error: NSError?) -> Void in
        //            if user != nil {
        //                // Do stuff after successful login.
        //            } else {
        //                // The login failed. Check error to see why.
        //
        //            }
        //        }
        
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
