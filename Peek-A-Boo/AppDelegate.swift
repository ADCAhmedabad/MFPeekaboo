//
//  AppDelegate.swift
//  Peek-A-Boo
//
//  Created by Varad Pathak on 14/10/16.
//  Copyright © 2016 Varad Pathak. All rights reserved.
//  Copyright © 2016 MobileFirst Applications - http://mobilefirst.in
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
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
    
    
    // Perform Action for ShortCuts
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void)
    {
        self.handleShortcutItem(shortcutItem)
        completionHandler(true)
    }

    
    func handleShortcutItem(_ shortcutItem: UIApplicationShortcutItem)
    {
        switch shortcutItem.type {
        case "varad.pathak.UITableViewDemo.new":
            self.presentComposeViewController()
            
        case "varad.pathak.UITableViewDemo.share":
            self.shareLatestPhoto()
            
        default: break
        }
    }
    
    
    func presentComposeViewController()
    {
        guard let navigationController = window?.rootViewController as? UINavigationController else { return }
        
        let identifier = "DetailViewController"
        let composeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
        
        navigationController.pushViewController(composeViewController, animated: false)
    }

    func shareLatestPhoto()
    {
        guard let latestPhoto = Photo.downloadAllPhotos().first, let navigationController = window?.rootViewController as? UINavigationController else { return }
        
        let identifier = "DetailViewController"
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier) as! DetailViewController
        
        detailVC.photo = latestPhoto
        detailVC.sharing = true
        
        navigationController.pushViewController(detailVC, animated: false)
    }
}

