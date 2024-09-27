//
//  SceneDelegate.swift
//  TermProject
//
//  Created by Sei Mouk on 5/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("Scene willConnectTo called")
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(withIdentifier: "tbcontroller") as! UITabBarController
        
        // Set up the window with the TabBarController as the root
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()


        if let shortcutItem = connectionOptions.shortcutItem {
            print("Quick action at Launch")
            handleQuickAction(shortcutItem)
        }

        
    }
    
    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("Quick Action Triggered in Foreground: \(shortcutItem.type)")
        
        handleQuickAction(shortcutItem)
        completionHandler(true)
    }
    
    func handleQuickAction(_ shortcutItem: UIApplicationShortcutItem) {
        print("SceneDelegate: Processing Quick Action: \(shortcutItem.type)")
        
        // Check if DataManager's menus are loaded
        if DataManager.shared.menus.isEmpty {
            // Fetch menus first
            DataManager.shared.fetchMenus { success in
                if success {
                    self.navigateToMenu(shortcutItem)
                } else {
                    print("SceneDelegate: Failed to fetch menus for quick action")
                }
            }
        } else {
            navigateToMenu(shortcutItem)
        }
    }

    func navigateToMenu(_ shortcutItem: UIApplicationShortcutItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let tabBarController = window?.rootViewController as? UITabBarController else {
            print("SceneDelegate: Root view controller is not a TabBarController")
            return
        }
        
        // Select the appropriate tab (assuming index 0 is the homepage)
        tabBarController.selectedIndex = 0
        
        if let navController = tabBarController.selectedViewController as? UINavigationController {
            // Instantiate MenuPageViewController
            guard let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as? MenuPageViewController else {
                print("SceneDelegate: Failed to instantiate MenuPageViewController")
                return
            }
            
            // Filter menus based on the shortcut type
            switch shortcutItem.type {
            case "OrderCoffeeAction":
                menuPageVC.menus = DataManager.shared.menus.filter { $0.category == "coffee" }
                print("SceneDelegate: Navigating to Coffee Menu")
            case "OrderCakeAction":
                menuPageVC.menus = DataManager.shared.menus.filter { $0.category == "cake" }
                print("SceneDelegate: Navigating to Cake Menu")
            case "OrderMealAction":
                menuPageVC.menus = DataManager.shared.menus.filter { $0.category == "meal" }
                print("SceneDelegate: Navigating to Meal Menu")
            default:
                print("SceneDelegate: Unknown Quick Action")
                return
            }
            
            // Push the MenuPageViewController onto the navigation stack
            navController.pushViewController(menuPageVC, animated: true)
        } else {
            print("SceneDelegate: Selected view controller is not a UINavigationController")
        }
    }

    
//    func handleQuickAction(_ shortcutItem: UIApplicationShortcutItem) {
//        print("Processing Quick Action: \(shortcutItem.type)")
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        guard let tabBarController = window?.rootViewController as? UITabBarController else {
//            print("Root view controller is not a TabBarController")
//            return
//        }
//
//        switch shortcutItem.type {
//        case "OrderCoffeeAction":
//            tabBarController.selectedIndex = 0
//            if let selectedNavController = tabBarController.selectedViewController as? UINavigationController {
//                let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as! MenuPageViewController
//                menuPageVC.menus = MENUS.filter { $0.category == "coffee" }
//                selectedNavController.pushViewController(menuPageVC, animated: true)
//            }
//        case "OrderCakeAction":
//            tabBarController.selectedIndex = 0
//            if let selectedNavController = tabBarController.selectedViewController as? UINavigationController {
//                let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as! MenuPageViewController
//                menuPageVC.menus = MENUS.filter { $0.category == "cake" }
//                selectedNavController.pushViewController(menuPageVC, animated: true)
//            }
//        case "OrderMealAction":
//            tabBarController.selectedIndex = 0
//            if let selectedNavController = tabBarController.selectedViewController as? UINavigationController {
//                let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as! MenuPageViewController
//                menuPageVC.menus = MENUS.filter { $0.category == "meal" }
//                selectedNavController.pushViewController(menuPageVC, animated: true)
//            }
//        default:
//            break
//        }
//    }

    
//    func windowScene(_ windowScene: UIWindowScene, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        
//        switch shortcutItem.type {
//        case "OrderCoffeeAction":
//            if let tabBarController = window?.rootViewController as? UITabBarController {
//                tabBarController.selectedIndex = 0
//                
//                if let selectedNavController = tabBarController.selectedViewController as? UINavigationController {
//                    let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as! MenuPageViewController
//                    menuPageVC.menus = MENUS.filter { $0.category == "coffee" }
//                    selectedNavController.pushViewController(menuPageVC, animated: true)
//                }
//            }
//            
//        case "OrderCakeAction":
//            if let tabBarController = window?.rootViewController as? UITabBarController {
//                tabBarController.selectedIndex = 0
//                
//                if let selectedNavController = tabBarController.selectedViewController as? UINavigationController {
//                    let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as! MenuPageViewController
//                    menuPageVC.menus = MENUS.filter { $0.category == "cake" }
//                    selectedNavController.pushViewController(menuPageVC, animated: true)
//                }
//            }
//        case "OrderMealAction":
//            if let tabBarController = window?.rootViewController as? UITabBarController {
//                tabBarController.selectedIndex = 0
//                
//                if let selectedNavController = tabBarController.selectedViewController as? UINavigationController {
//                    let menuPageVC = storyboard.instantiateViewController(withIdentifier: "MenuPageViewController") as! MenuPageViewController
//                    menuPageVC.menus = MENUS.filter { $0.category == "meal" }
//                    selectedNavController.pushViewController(menuPageVC, animated: true)
//                }
//            }
//        default:
//            break
//        }
//        
//        completionHandler(true)
//    }

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

