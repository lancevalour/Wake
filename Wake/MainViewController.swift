//
//  ViewController.swift
//  Wake
//
//  Created by Yicheng Zhang on 7/21/16.
//  Copyright © 2016 Yicheng Zhang. All rights reserved.
//

import UIKit
import XLActionController
import WWCalendarTimeSelector
import Permission
import Async

class MainViewController: UIViewController, WWCalendarTimeSelectorProtocol {
    
    enum SpotifyCredential{
        static let clientID = "29fdcd762db44eddb0e86e5e7b928d80"
        static let callbackUrl = "wake-login://callback"
    }
    
//    let tokenSwapURL = "http://localhost:1234/swap"
//    let kTokenRefreshServiceURL = "http://localhost:1234/refresh"
    
    @IBOutlet weak var wakeLabel: UILabel!
    
    @IBOutlet weak var wakeSwitch: UISwitch!
    
    @IBOutlet weak var setWakeButton: UIButton!
    
    @IBOutlet weak var setWakeSongButton: UIButton!
    
    fileprivate let dateFormatter = DateFormatter()
    
    let permission: Permission = .Notifications
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initiateComponents()
        setComponentControl()
    }
    
  
    
    
    fileprivate func initiateComponents(){
        dateFormatter.dateFormat = "'Next Wake Time:' hh:mm a, EE, MM/dd"
        
        if let wakeTime = UserDefaults.standard.string(forKey: "wakeTime")
        {
            wakeLabel.text = wakeTime
        }
        else{
            wakeLabel.text = "No Wake Time Set"
        }
        
    }
    
    fileprivate func setComponentControl(){
        setSetWakeButtonControl()
        setSetWakeSongButtonControl()
    }
    
    fileprivate func setSetWakeSongButtonControl(){
        setWakeSongButton.addTarget(self, action: #selector(setWakeSong), for: .touchUpInside)
    }
    
    
    fileprivate func setSetWakeButtonControl(){
        setWakeButton.addTarget(self, action: #selector(setWakeTime), for: .touchUpInside)
    }
    
    func setWakeSong(){
        connectToSpotify()
    }
    
    func connectToSpotify(){
        let spotifyAuth = SPTAuth.defaultInstance()
        spotifyAuth.clientID = clientID
        spotifyAuth.redirectURL = callbackUrl
        spotifyAuth?.requestedScopes = SPTAuthStreamingScope
        
        
        
        
    }
    
    
    
    
    func setWakeTime(){
        
        permission.request { status in
            switch status {
            case .authorized:
                self.showTimeSelector()
            case .denied:
                print("permission denied")
            case .disabled:
                print("permission disabled")
            case .notDetermined:
                print("permission not determined")
            }
        }
        
    }
    
    
    func showTimeSelector() {
        
        let timeSelector = WWCalendarTimeSelector.instantiate()
        timeSelector.optionTopPanelBackgroundColor = Color.themePrimaryDark
        timeSelector.optionTopPanelFontColor = Color.textPrimaryLight
        timeSelector.optionButtonFontColorCancel = Color.textPrimaryDark
        timeSelector.optionButtonFontColorCancelHighlight = Color.textSecondaryDark
        timeSelector.optionButtonFontColorDone = Color.themeAccent
        timeSelector.optionButtonFontColorDoneHighlight = Color.themeAccentLight
        timeSelector.optionSelectorPanelBackgroundColor = Color.themePrimary
        timeSelector.optionClockFontColorAMPMHighlight = Color.themeAccent
        timeSelector.optionClockBackgroundColorAMPMHighlight = Color.themeAccent
        timeSelector.optionClockBackgroundColorHourHighlightNeedle = Color.themeAccent
        timeSelector.optionClockBackgroundColorMinuteHighlightNeedle = Color.themeAccent
        timeSelector.optionClockBackgroundColorMinuteHighlight = Color.themeAccent
        timeSelector.optionClockBackgroundColorHourHighlight = Color.themeAccent
        timeSelector.optionClockFontColorAMPMHighlight = Color.textPrimaryLight
        
        
        
        timeSelector.optionStyles.showDateMonth(false)
        timeSelector.optionStyles.showMonth(false)
        timeSelector.optionStyles.showYear(false)
        timeSelector.optionStyles.showTime(true)
        timeSelector.optionCurrentDate = Date()
        timeSelector.delegate = self
        self.present(timeSelector, animated: true, completion: nil)
        
    }
    
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
        setAlarm(date)
        
    }
    
    func setAlarm(_ date: Date){
        
        
        UserDefaults.standard.set(
            self.dateFormatter.string(from: date),
            forKey: "wakeTime")
        UserDefaults.standard.synchronize()
        
        
        Log.info(dateFormatter.string(from: date))
        
        wakeLabel.text = dateFormatter.string(from: date)
        
        
        let notification = UILocalNotification()
        notification.alertBody = "Wake Up" // text that will be displayed in the notification
        notification.alertAction = "View" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = date
        // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": "Wake Up", "UUID": 1] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.shared.scheduleLocalNotification(notification)
    }
    
    
    
}

