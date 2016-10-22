//
//  AppDelegate.swift
//  Wake
//
//  Created by Yicheng Zhang on 7/21/16.
//  Copyright © 2016 Yicheng Zhang. All rights reserved.
//

import UIKit
import CoreLocation
import UIColor_Hex_Swift
import XCGLogger

/// Global Logging Instance
let Log = XCGLogger.defaultInstance()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
//    var alarms: Dictionary<String, Alarm> = Dictionary(minimumCapacity: 0)
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // ..
        // ..
        // ..
        // Handle any action if the user opens the application throught the notification. i.e., by clicking on the notification when the application is killed/ removed from background.
        if let aLaunchOptions = launchOptions { // Checking if there are any launch options.
            // Check if there are any local notification objects.
            if ((aLaunchOptions as NSDictionary).object(forKey: "UIApplicationLaunchOptionsLocalNotificationKey") as? UILocalNotification) != nil {
                // Handle the notification action on opening. Like updating a table or showing an alert.
                self.window = UIWindow(frame: UIScreen.main.bounds)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                
                let initialViewController = storyboard.instantiateViewController(withIdentifier: "unlock")
                
                self.window?.rootViewController = initialViewController
                self.window?.makeKeyAndVisible()

            }
        }
        
        
        
        return true
    }
    
    
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "unlock") 
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        

        
        
//        let alertController = UIAlertController(title: "Notification", message: "A notification was received while the app was running", preferredStyle: .Alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//        window?.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
}




/// Color
public struct Color{
    
    
    /// Theme Color
    static let themePrimary: UIColor = UIColor(rgba: "#ffcb2e")
    static let themePrimaryDark: UIColor = UIColor(rgba: "#FFC107")
    static let themePrimaryLight: UIColor = UIColor(rgba: "#ffd555")
    
    
    static let themeAccent: UIColor = UIColor(rgba: "#58b75c")
    static let themeAccentLight: UIColor = UIColor(rgba: "#73c377")
    static let themeRed: UIColor = UIColor(rgba: "#ef5350")
    static let themeRedLight: UIColor = UIColor(rgba: "#f06461")
    static let themeGreen: UIColor = UIColor(rgba: "#26a69a")
    static let themeGreenLight: UIColor = UIColor(rgba: "#66bb6a")
    static let themeAmber: UIColor = UIColor(rgba: "#ffc107")
    static let themeAmberLight: UIColor = UIColor(rgba: "#ffca28")
    
    /// Text Color
    static let textPrimaryDark: UIColor = UIColor(rgba: "#000000dd")
    static let textSecondaryDark: UIColor = UIColor(rgba: "#00000089")
    static let textDisabledDark: UIColor = UIColor(rgba: "#00000042")
    static let textPrimaryLight: UIColor = UIColor(rgba: "#ffffffff")
    static let textSecondaryLight: UIColor = UIColor(rgba: "#ffffffb3")
    static let textDisabledLight: UIColor = UIColor(rgba: "#ffffff4d")
    
}








