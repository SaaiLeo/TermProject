//
//  AppDelegate.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()

//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//
//        checkUserSignInStatus()
        
        return true
    }

//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
//    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
    
//    func checkUserSignInStatus(){
//        print("Checking user sign-in status...")
//        if let user = Auth.auth().currentUser {
//            print("User is already signed in: \(user.uid)")
//            showHomeScreen()
//        } else {
//            print("No user is signed in.")
//            showLoginScreen()
//        }
//    }
//    
//    func showHomeScreen() {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let homePage = storyboard.instantiateViewController(withIdentifier: "tbcontroller") as! UITabBarController
//        window?.rootViewController = homePage
//        window?.makeKeyAndVisible()
//        
//    }
//
//    
//    func showLoginScreen() {
//        let storyboard = UIStoryboard(name: "Main", bundle: .main)
//        let loginPage = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
//        self.window?.rootViewController = loginPage
//        window?.makeKeyAndVisible()
//    }

}

