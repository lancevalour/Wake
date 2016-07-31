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
    
    @IBOutlet weak var wakeLabel: UILabel!
    
    @IBOutlet weak var wakeSwitch: UISwitch!
    
    @IBOutlet weak var setWakeButton: UIButton!
    
    private let dateFormatter = NSDateFormatter()
    
    let permission: Permission = .Notifications
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initiateComponents()
        setComponentControl()
    }
    
  
    
    
    private func initiateComponents(){
        dateFormatter.dateFormat = "'Next Wake Time:' hh:mm a, EE, MM/dd"
        
        if let wakeTime = NSUserDefaults.standardUserDefaults().stringForKey("wakeTime")
        {
            wakeLabel.text = wakeTime
        }
        else{
            wakeLabel.text = "No Wake Time Set"
        }
        
        
        
        
    }
    
    private func setComponentControl(){
        setSetWakeButtonControl()
    }
    
    
    private func setSetWakeButtonControl(){
        setWakeButton.addTarget(self, action: #selector(setWakeTime), forControlEvents: .TouchUpInside)
    }
    
    func setWakeTime(){
        
        permission.request { status in
            switch status {
            case .Authorized:
                self.showTimeSelector()
            case .Denied:
                print("permission denied")
            case .Disabled:
                print("permission disabled")
            case .NotDetermined:
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
        timeSelector.optionCurrentDate = NSDate()
        timeSelector.delegate = self
        self.presentViewController(timeSelector, animated: true, completion: nil)
        
    }
    
    
    func WWCalendarTimeSelectorDone(selector: WWCalendarTimeSelector, date: NSDate) {
        
        setAlarm(date)
        
    }
    
    func setAlarm(date: NSDate){
        
        
        NSUserDefaults.standardUserDefaults().setObject(
            self.dateFormatter.stringFromDate(date),
            forKey: "wakeTime")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        Log.info(dateFormatter.stringFromDate(date))
        
        wakeLabel.text = dateFormatter.stringFromDate(date)
        
        
        let notification = UILocalNotification()
        notification.alertBody = "Wake Up" // text that will be displayed in the notification
        notification.alertAction = "View" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = date
        // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["title": "Wake Up", "UUID": 1] // assign a unique identifier to the notification so that we can retrieve it later
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    
}

