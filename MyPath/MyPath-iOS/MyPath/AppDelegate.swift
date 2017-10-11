//
//  AppDelegate.swift
//  MyPath
//
//  Created by James on 14/05/2017.
//  Copyright © 2017 James. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyDfUXqIJEAxgsrvxL2QkKFFb7vugIiw-TA")
        GMSPlacesClient.provideAPIKey("AIzaSyDfUXqIJEAxgsrvxL2QkKFFb7vugIiw-TA")
        
        let nav1 = UINavigationController()
        let first = RecordingMapViewController()
        first.title = "Map"
        first.tabBarItem = UITabBarItem(title: "Record", image: UIImage(named: "pin"), selectedImage: UIImage(named: "pin"))
        nav1.pushViewController(first, animated: false)
        
        let nav2 = UINavigationController()
        let second = SegmentBrowserViewController()
        second.title = "Segment Browser"
        second.tabBarItem = UITabBarItem(title: "Browse", image: UIImage(named: "earth"), selectedImage: UIImage(named: "earth"))
        nav2.pushViewController(second, animated: false)
        
        let tabs = UITabBarController()
        tabs.hidesBottomBarWhenPushed = true
        tabs.viewControllers = [nav1, nav2]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.rootViewController = tabs
        self.window!.makeKeyAndVisible()
        
        return true
    }

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


}

