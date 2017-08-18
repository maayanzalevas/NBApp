//
//  Team.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/2/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import UIKit

class Team: NSObject {
    let name: String
    let imageUrl: String
    
    init(name: String, imageUrl: String) {
        self.name = name
        self.imageUrl = imageUrl
    }
}
