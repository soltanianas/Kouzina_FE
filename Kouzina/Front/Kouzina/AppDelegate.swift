//
//  AppDelegate.swift
//  Kouzina
//
//  Created by Anil Dhameliya on 21/11/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import CoreLocation
import GoogleSignIn
//import FBSDKCoreKit
import UserNotifications
@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate,UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    let locationManager = CLLocationManager()
    var latitude: Double = -33.860478
    var longitude: Double = 151.202669

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                print("User gave permissions for local notifications")
            }
        }
        return true
        func applicationWillResignActive(_ application: UIApplication) {
            // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
            // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        }

        func applicationDidEnterBackground(_ application: UIApplication) {
            // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
            // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        }

        func applicationWillEnterForeground(_ application: UIApplication) {
            // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        }

        func applicationDidBecomeActive(_ application: UIApplication) {
            // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        }

        func applicationWillTerminate(_ application: UIApplication) {
            // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        }
        // Facebook
        /*let facebook = ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        if (facebook){
            return true
        }*/
        
        
        // Google
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
            } else {
                // Show the app's signed-in state.
            }
        }
        
        GMSServices.provideAPIKey("AIzaSyDHf2CYWobrKnIDPk-2NVeDJVpOxiia9e0")

        self.moveToWelcome()
//        self.moveToTabbar()
        self.locationManager.requestAlwaysAuthorization()

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()

        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
        
//        GIDSignIn.sharedInstance().clientID = "448739780482-flneu6kn6vteuuobqs67p5pa8afbughb.apps.googleusercontent.com"
        
        return true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude = locValue.latitude
        self.longitude = locValue.longitude
    }
    
    func moveToWelcome() {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
        let navController = UINavigationController(rootViewController: obj)
        navController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func moveToText() {
        let obj = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "SuccessVC") as! SuccessVC
        let navController = UINavigationController(rootViewController: obj)
        navController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func moveToTabbar() {
        let accueil = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        let nav1 = UINavigationController(rootViewController: accueil)
        nav1.setNavigationBarHidden(true, animated: false)
        nav1.tabBarItem = UITabBarItem(title: "Accueil", image: #imageLiteral(resourceName: "ic_home"), tag: 0)

        let profile = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "OrdersVC") as! OrdersVC
        let nav2 = UINavigationController(rootViewController: profile)
        nav2.setNavigationBarHidden(true, animated: false)
        nav2.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "ic_profile2"), tag: 0)
        
        let cart = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "OrderDetailsVC") as! OrderDetailsVC
        let nav3 = UINavigationController(rootViewController: cart)
        nav3.setNavigationBarHidden(true, animated: false)
        nav3.tabBarItem = UITabBarItem(title: "Cart", image: #imageLiteral(resourceName: "ic_cart"), tag: 0)
        
        let chat = AppStoryboard.Main.instance.instantiateViewController(withIdentifier: "MessageVC") as! MessageVC
        let nav4 = UINavigationController(rootViewController: chat)
        nav4.setNavigationBarHidden(true, animated: false)
        nav4.tabBarItem = UITabBarItem(title: "Chat", image: #imageLiteral(resourceName: "ic_chat"), tag: 0)
//        settingsVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "clock")
//        settingsVC.inverseColor()

        let tabBarController = BubbleTabBarController()
        tabBarController.viewControllers = [nav1, nav2, nav3, nav4]
        tabBarController.tabBar.tintColor = UIColor(hexString: "53E88B")

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
//    func application(_ app: UIApplication,
//                     open url: URL,
//                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//
//        return GIDSignIn.sharedInstance().handle(url)
//    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Usrinfo associated with notification == \(response.notification.request.content.userInfo)")

        completionHandler()
    }
}
