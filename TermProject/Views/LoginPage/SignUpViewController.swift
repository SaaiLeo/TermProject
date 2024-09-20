//
//  SignUpViewController.swift
//  TermProject
//
//  Created by SaiThaw- on 6/9/2567 BE.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    static let identifier = String(describing: SignUpViewController.self)
    
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        let loginPage = storyboard?.instantiateViewController(withIdentifier: LoginPageViewController.identifier) as! LoginPageViewController
        
        loginPage.modalPresentationStyle = .fullScreen
        loginPage.modalTransitionStyle = .crossDissolve
        present(loginPage, animated: true)
    }
    

    @IBAction func createAccountBtnClicked(_ sender: UIButton) {
        guard let name = usernameTF.text, !name.isEmpty else {
            showAlert(message: "Please enter your name.")
            return
        }
        guard let email = emailTF.text, !email.isEmpty else {
            showAlert(message: "Please enter your email.")
            return
        }
        guard let password = passwordTF.text, !password.isEmpty else {
            showAlert(message: "Please enter your password.")
            return
        }
        guard isValidPassword(password) else {
            showAlert(message: "Password must be at least 8 characters long, contain at least one uppercase letter, one lowercase letter, and one number.")
            return
        }
        
        
        let alert = UIAlertController(title: "Create Account", message: "Would you like to create an account?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { _ in
            
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    self.showAlert(message: e.localizedDescription)
                } else if let authResult = authResult {
                    let db = Firestore.firestore()
                    db.collection("users").document(authResult.user.uid).setData([
                        "name": name,
                        "email": email
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            let homePage = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "tbcontroller") as! UITabBarController
                            homePage.modalPresentationStyle = .fullScreen
                            homePage.modalTransitionStyle = .coverVertical
                            self.present(homePage, animated: true, completion: nil)
                        }
                    }
                }
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let lengthRequirement = password.count >= 8
        let uppercaseRequirement = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let lowercaseRequirement = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let numberRequirement = password.rangeOfCharacter(from: .decimalDigits) != nil
        
        return lengthRequirement && uppercaseRequirement && lowercaseRequirement && numberRequirement
    }

    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
   
}
