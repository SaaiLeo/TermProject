//
//  ProfilePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 11/9/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

class ProfilePageViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadUserData()
    }
    
    private func loadUserData() {
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userId = user.uid
            
            db.collection("users").document(userId).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let name = data?["name"] as? String
                    let email = data?["email"] as? String
                    let phoneNumber = data?["phoneNumber"] as? String
                    let photoURL = data?["photoURL"] as? String
                    
                    self.usernameLabel.text = name
                    self.profileUsernameLabel.text = name
                    self.emailLabel.text = email
                    self.phoneLabel.text = phoneNumber
                    
                    if let photoURL = photoURL, let url = URL(string: photoURL) {
                        self.loadImage(from: url)
                    } else {
                        self.userImageView.image = UIImage(named: "defaultProfileImage")
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
        let fireAuth = Auth.auth()
        do {
            try fireAuth.signOut()
            GIDSignIn.sharedInstance.signOut()
            
            CART = []
            
            UserDefaults.standard.removeObject(forKey: "savedCart")
            UserDefaults.standard.synchronize()
            
            let loginPage = storyboard?.instantiateViewController(withIdentifier: LoginPageViewController.identifier) as! LoginPageViewController
            loginPage.modalPresentationStyle = .fullScreen
            loginPage.modalTransitionStyle = .crossDissolve
            present(loginPage, animated: true)
            
        } catch let signOutError as NSError {
            print("Error signing out: \(signOutError.localizedDescription)")
        }
    }
    
    @IBAction func editProfileBtnClicked(_ sender: UIBarButtonItem) {
        let editProfilePage = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "editprofilepage") as! EditProfileViewController
        navigationController?.pushViewController(editProfilePage, animated: true)
        editProfilePage.title = "Edit Profile"
    }
    
    private func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.userImageView.image = image
                }
            }
        }
        task.resume()
    }
}
