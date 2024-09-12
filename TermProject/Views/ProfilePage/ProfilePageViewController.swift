//
//  ProfilePageViewController.swift
//  TermProject
//
//  Created by Sei Mouk on 11/9/24.
//

import UIKit

class ProfilePageViewController: UIViewController {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func setup(_ user: User){
        userImageView.image = UIImage(named: user.image)
        usernameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
    }
}
