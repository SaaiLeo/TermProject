//
//  ProfilePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 11/9/24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ProfilePageViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var profileUsernameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userId = user.uid
            
            db.collection("users").document(userId).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let name = data?["name"] as? String
                    let email = data?["email"] as? String
                    self.usernameLabel.text = name
                    self.profileUsernameLabel.text = name
                    self.emailLabel.text = email
                } else {
                    print("Document does not exist")
                }
            }
        }
    }
    
    @IBAction func logoutBtnClicked(_ sender: UIButton) {
    }
    
    
    
    
    
}
