//
//  AppDelegate.swift
//  MyMovieDB
//
//  Created by Fabiola Ramirez on 7/18/19.
//  Copyright © 2019 com.fabiolaramirez. All rights reserved.
//

import UIKit
import Firebase
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //firebase
        FirebaseApp.configure()
        //realm
        let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        Realm.Configuration.defaultConfiguration = config
        //Navigation root
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        let navigationController = UINavigationController(rootViewController: initialViewController())
        window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        self.window?.tintColor = .orangePrimary
        //crashlytics
        Fabric.sharedSDK().debug = true
        
        return true
    }
    
    private func initialViewController() -> UIViewController {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                return UIStoryboard(name: "User", bundle: nil).instantiateViewController(withIdentifier: "loginViewController")
            }
        } else if RDatabase.fetchMovies().count > 0 {
            return UIStoryboard(name: "Movie", bundle: nil).instantiateViewController(withIdentifier: "moviesSavedTableViewController")
        }
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeTableViewController")
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

