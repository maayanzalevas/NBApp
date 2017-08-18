//
//  Event.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/2/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import UIKit

struct Event {

    let time: String
    let teamImage: String
    let eventDescription: String
    let score: String
    
    
    init(time: String, teamImage: String, eventDescription: String, score: String) {
        self.time = time
        self.teamImage = teamImage
        self.eventDescription = eventDescription
        self.score = score        
    }
    
}
