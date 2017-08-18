  //
//  ESPNDataParser.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/3/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//
import UIKit
import Fuzi

class ESPNDataParser: DataParserProtocol {

    func parse(string: String, completionHandler: @escaping (Game?, Error?) -> Swift.Void) {
        do {

            let doc = try HTMLDocument(string: string, encoding: String.Encoding.utf8)
            
            guard let gameXML = gameDoc(from: doc) else {
                completionHandler(nil, NBADataError.parseError)
                return
            }
            
            let quaters = quatersXMLs(from: gameXML)
            guard quaters.count > 0  else {
                completionHandler(nil, NBADataError.parseError)
                return
            }
            
            let game = Game()
            for quaterXML in quaters {
                let eventsList = events(from: quaterXML)
                game.addQuater(with: eventsList)
            }

            completionHandler(game, nil)
            
        } catch _ {
            completionHandler(nil, NBADataError.parseError)
        }
    }

    
    fileprivate func gameDoc(from document: HTMLDocument) -> XMLElement? {
        for item in document.css("div") {
            if let idStr = item["id"] {
                if idStr == "gamepackage-qtrs-wrap" {
                    return item
                }
            }
        }
        return nil
    }
    
    
    fileprivate func quatersXMLs(from gameXML: XMLElement) -> [XMLElement] {
        var quaters = [XMLElement]()
        for item in gameXML.css("div") {
            if let idStr = item["id"] {
                if idStr.hasPrefix("gp-quarter") {
                    quaters.append(item)
                }
            }
        }
        return quaters
    }
    
    
    fileprivate func events(from eventsXML: XMLElement) -> [Event] {
        
        var eventsArray = [Event]()
        for item in eventsXML.css("tr") {
            if let event = event(from: item) {
                eventsArray.append(event)
            }
        }
        return eventsArray
    }
    
    fileprivate func event(from eventXML: XMLElement) -> Event? {
        
        var time: String?
        var teamImage: String?
        var eventDescription: String?
        var score: String?

        for item in eventXML.css("td") {
            guard let name = item["class"] else {
                continue
            }
            
            switch name {
            case "game-details":
                eventDescription = item.stringValue
            case "time-stamp":
                time = item.stringValue
            case "combined-score ", "combined-score no-change":
                score = item.stringValue
            case "logo":
                teamImage = imageUrl(from: item)
            
            default:
                break
            }
        }
        if time == nil || teamImage == nil || eventDescription == nil || score == nil {
            return nil
        }
        else {
            let event = Event(time: time!, teamImage: teamImage!, eventDescription: eventDescription!, score: score!)
            return event
        }
    }
    
    fileprivate func imageUrl(from logoXML: XMLElement) -> String? {
        guard let item = logoXML.css("img").first else {
            return nil
        }
        let imgSrc = item["src"]
        return imgSrc
    }
   
  
}
  
  
  
  
  
  
