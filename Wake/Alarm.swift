//
//  Alarm.swift
//  Wake
//
//  Created by Yicheng Zhang on 7/27/16.
//  Copyright © 2016 Yicheng Zhang. All rights reserved.
//

import UIKit
import MediaPlayer

class Alarm: NSObject {
    
    var title:String
    var media:MPMediaItem
    var time:Date
    
    init( title:String, time:Date, media:MPMediaItem ) {
        self.title = title
        self.time = time
        self.media = media
        
    }
    
}
