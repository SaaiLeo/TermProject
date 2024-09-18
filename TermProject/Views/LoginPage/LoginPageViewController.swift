//
//  LoginPageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class LoginPageViewController: UIViewController {
    
    static let identifier = String(describing: LoginPageViewController.self)
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureGoogleSignIn()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        if Auth.auth().currentUser != nil {
            navigateToHomeScreen()
        }
    }
    
    
    @IBAction func logInBtnClicked(_ sender: UIButton) {
        guard let email = emailTF.text, !email.isEmpty,
              let password = passwordTF.text, !password.isEmpty else {
            showAlert(message: "Please enter email and password.")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let e = error {
                self.showAlert(message: e.localizedDescription)
            } else {
                self.navigateToHomeScreen()
            }
        }
    }
    
    
    @IBAction func googleSignInBtnClicked(_ sender: UIButton) {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                self.showAlert(message: error.localizedDescription)
                return
            }
            
            guard let user = signInResult?.user, let idToken = user.idToken?.tokenString else{
                print("no user or id token")
                return
            }
                        
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    self.showAlert(message: error.localizedDescription)
                    return
                }
                if let authResult = authResult {
                    let db = Firestore.firestore()
                    db.collection("users").document(authResult.user.uid).setData([
                        "name": user.profile?.name ?? "",
                        "email": user.profile?.email ?? ""
                    ]) { err in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            self.navigateToHomeScreen()
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func signUpBtnClicked(_ sender: Any) {
        let signupPage = storyboard?.instantiateViewController(withIdentifier: SignUpViewController.identifier) as! SignUpViewController
        
        signupPage.modalPresentationStyle = .fullScreen
        signupPage.modalTransitionStyle = .crossDissolve
        present(signupPage, animated: true)
    }
    
    
    func navigateToHomeScreen(){
        let homePage = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "tbcontroller") as! UITabBarController
        homePage.modalPresentationStyle = .fullScreen
        homePage.modalTransitionStyle = .coverVertical
        self.present(homePage, animated: true, completion: nil)
    }
    
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func configureGoogleSignIn(){
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("Missing client ID in GoogleService-Info.plist")
        }
                
        GIDSignIn.sharedInstance.configuration = GIDConfiguration(clientID: clientID)
    }
    
}
