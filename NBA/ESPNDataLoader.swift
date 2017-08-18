//
//  ESPNDataLoader.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/2/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import UIKit

class ESPNDataLoader: DataLoader {

    var dataHost = "http://scores.espn.com/nba/playbyplay"
    
    var refreshTimeout: TimeInterval = 60.0
    var delegate: DataLoaderDelegate?
    var gameId: String = ""
    
    var gameURL: URL {
        let urlComp = NSURLComponents(string: dataHost)!
        
        var items = [URLQueryItem]()
        items.append(URLQueryItem(name: "gameId", value: gameId))

        urlComp.queryItems = items
        return urlComp.url!
        
    }
    
    func startGameLoading(completionHandler: @escaping (Game?, Error?) -> Void) {
        guard gameId.characters.count > 0 else {
            return
        }
        
        loadGameData(completionHandler: completionHandler)
    }
    
    func gamesForDate(date: Date) {
        
    }
    
    func stopGameLoading() {
        
    }
    
    fileprivate func loadGameData(completionHandler: @escaping (Game?, Error?) -> Void) {
        
        var request = URLRequest(url: gameURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if(error != nil || (data?.isEmpty)!) {
                completionHandler(nil, NBADataError.parseError)
            }else{
                let dataStr =  String(data: data!, encoding: String.Encoding.utf8)
                if (dataStr?.contains("gamepackage-qtrs-wrap"))! {
                    
                    let parser = ESPNDataParser()
                    parser.parse(string: dataStr!, completionHandler: completionHandler)
                }
            }
        }).resume()
       
    }

}
















