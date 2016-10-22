//
//  UnlockViewController.swift
//  Wake
//
//  Created by Yicheng Zhang on 7/30/16.
//  Copyright © 2016 Yicheng Zhang. All rights reserved.
//

import UIKit
import AVFoundation

class UnlockViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
            print("AVAudioSession Category Playback OK")
            do {
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession is Active")
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        initiateComponents()
        setComponentControl()
    }
    
    
    fileprivate func initiateComponents(){
        
    }
    
    fileprivate func setComponentControl(){

    }
}
