//
//  LoginPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import FirebaseAuth

class LoginPageViewController: UIViewController {
    
    static let identifier = String(describing: LoginPageViewController.self)
    
    
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            navigateToHomeScreen()
        }

    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func logInBtnClicked(_ sender: UIButton) {
        guard let email = emailTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                self.showAlert(message: e.localizedDescription)
            } else {
                self.navigateToHomeScreen()
            }
        }
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        let signupPage = storyboard?.instantiateViewController(withIdentifier: SignUpViewController.identifier) as! SignUpViewController
        
        signupPage.modalPresentationStyle = .fullScreen
        signupPage.modalTransitionStyle = .crossDissolve
        present(signupPage, animated: true)
//        navigationController?.pushViewController( signupPage, animated: true)
    }
    
    
    func navigateToHomeScreen(){
        let homePage = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "tbcontroller") as! UITabBarController
        homePage.modalPresentationStyle = .fullScreen
        homePage.modalTransitionStyle = .coverVertical
        self.present(homePage, animated: true, completion: nil)
    }
    
    
    
}
