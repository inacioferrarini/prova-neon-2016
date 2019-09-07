//
//  AppDelegate.swift
//  NeonPlus
//
//  Created by José Inácio Athayde Ferrarini on 02/09/16.
//  Copyright © 2016 com.inacioferrarini. All rights reserved.
//

import UIKit
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appContext: AppContext?
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        SVProgressHUD.setDefaultStyle(.Dark)

        let appContext = AppContext()
        appContext.contacts = self.loadContactsFromDisk()
        appContext.userData = self.loadUserData()
        self.appContext = appContext

        if let navigationController = window!.rootViewController as? UINavigationController,
            var firstViewController = navigationController.viewControllers.first as? AppContextAware {
            firstViewController.appContext = appContext
        }

        return true
    }

    func loadContactsFromDisk() -> [Contact] {
        return UserDataManager().load()
    }

    func loadUserData() -> UserData {
        let userData = UserData()
        userData.imagePath = "https://media.licdn.com/mpr/mpr/shrink_100_100/AAEAAQAAAAAAAAYMAAAAJGYxZWM1ODk4LTAyYWQtNDI2Ny1iYjJmLWI1ZWUwYjhkMWQ2Yg.jpg"
        userData.userName = "Inacio Ferrarini"
        userData.userEmail = "inacio.ferrarini@gmail.com"
        return userData
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

