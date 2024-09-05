//
//  LoginPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import FirebaseAuth

class LoginPageViewController: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = UIColor.white
        
//        if FirebaseAuth.Auth.auth().currentUser != nil {
//            navigateToHomeScreen()
//        }       uncommand this after implementing homescreen
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        guard let email = emailTF.text else {return}
        guard let password = passwordTF.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                self.showAlert(message: e.localizedDescription)
            } else {
//                self.navigateToHomeScreen()
                print("signIn complete")
            }
        }
    }
    
    @IBAction func signupBtnClicked(_ sender: UIButton) {
        let signupPage = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "signuppage") as! SignUpViewController
        navigationController?.pushViewController(signupPage, animated: true)
    }
    
//    func navigateToHomeScreen(){
//        .........
//    }
    
    
}
