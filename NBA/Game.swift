//
//  Game.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/2/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import UIKit

class Game {
    var events = [Event]()
    
    func addQuater(with quaterEvents: [Event]) {
        events.append(contentsOf: quaterEvents)
    }
}
