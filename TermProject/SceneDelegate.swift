//
//  SceneDelegate.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window = UIWindow(windowScene: windowScene)

        let isNewUser = UserDefaults.standard.bool(forKey: "isNewUser")

        if !isNewUser {
            let onboardingVC = storyboard.instantiateViewController(withIdentifier: "OnBoardingPageViewController") as! OnBoardingPageViewController
            window?.rootViewController = onboardingVC
            window?.makeKeyAndVisible()

            UserDefaults.standard.set(true, forKey: "isNewUser")
        } else {
            if Auth.auth().currentUser != nil {
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "tbcontroller") as! UITabBarController
                window?.rootViewController = tabBarController
                window?.makeKeyAndVisible()
                
                if let shortcutItem = connectionOptions.shortcutItem {
                    handleQuickAction(shortcutItem)
                }
            } else {
                let loginPage = storyboard.instantiateViewController(withIdentifier: "LoginPageViewController") as! LoginPageViewController
                window?.rootViewController = loginPage
                window?.makeKeyAndVisible()
            }
        }
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        handleQuickAction(shortcutItem)
        completionHandler(true)
    }
    
    func handleQuickAction(_ shortcutItem: UIApplicationShortcutItem) {
        if DataManager.shared.menus.isEmpty {
            DataManager.shared.fetchMenus { success in
                if success {
                    self.navigateToMenu(shortcutItem)
                }
            }
        } else {
            navigateToMenu(shortcutItem)
        }
    }

    func navigateToMenu(_ shortcutItem: UIApplicationShortcutItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            return
        }
        
        tabBarController.selectedIndex = 0
        
        if let navController = tabBarController.selectedViewController as? UINavigationController {
            guard let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as? MenuPageViewController else {
                return
            }
            
            switch shortcutItem.type {
            case "OrderCoffeeAction":
                menuPageVC.menus = DataManager.shared.menus.filter { $0.category == "coffee" }
            case "OrderCakeAction":
                menuPageVC.menus = DataManager.shared.menus.filter { $0.category == "cake" }
            case "OrderMealAction":
                menuPageVC.menus = DataManager.shared.menus.filter { $0.category == "meal" }
            default:
                return
            }
            
            navController.pushViewController(menuPageVC, animated: true)
        }
    }

    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

