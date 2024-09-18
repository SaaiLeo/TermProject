//
//  EditProfileViewController.swift
//  TermProject
//
//  Created by SaiThaw- on 14/9/2567 BE.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var phoneNumTF: UITextField!
    
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        if let user = Auth.auth().currentUser {
            let db = Firestore.firestore()
            let userId = user.uid
            
            db.collection("users").document(userId).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    let name = data?["name"] as? String
                    let phoneNumber = data?["phoneNumber"] as? String
                    let photoURL = data?["photoURL"] as? String

                    self.usernameTF.text = name
                    self.phoneNumTF.text = phoneNumber
                    
                    if let photoURL = photoURL, let url = URL(string: photoURL) {
                        self.loadImage(from: url)
                    }
                } else {
                    print("Document does not exist")
                }
            }
        }
    
        
    }

    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        let userId = user.uid
        
        let name = usernameTF.text ?? ""
        let phoneNumber = phoneNumTF.text ?? ""
        
        var updatedData: [String: Any] = [
            "name": name,
            "phoneNumber": phoneNumber
        ]
        
        if let image = profileImageView.image, let imageData = image.jpegData(compressionQuality: 0.8) {
            let storageRef = Storage.storage().reference().child("profile_images/\(userId).jpg")
            storageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error.localizedDescription)")
                        return
                    }
                    if let url = url {
                        updatedData["photoURL"] = url.absoluteString
                        db.collection("users").document(userId).updateData(updatedData) { error in
                            if let error = error {
                                print("Error updating profile: \(error.localizedDescription)")
                            } else {
                                print("Profile updated successfully")
                                self.navigationController?.popViewController(animated: true)  // Return to profile page
                            }
                        }
                    }
                }
            }
        } else {
            db.collection("users").document(userId).updateData(updatedData) { error in
                if let error = error {
                    print("Error updating profile: \(error.localizedDescription)")
                } else {
                    print("Profile updated successfully")
                    self.navigationController?.popViewController(animated: true)  // Return to profile page
                }
            }
        }
    }

    @IBAction func chooseImageBtnClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: "Select Profile Picture", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }
    
    func openPhotoLibrary() {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate Methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error loading image: \(error.localizedDescription)")
                return
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
        task.resume()
    }
}
