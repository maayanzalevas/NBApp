//
//  DataLoader.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/2/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import Foundation

let NBADataErrorDomain = "NBADataErrorDomain"

enum NBADataError: Error {
    case downloadError
    case parseError
}

enum GameDataSourse
{
    case espn
}

protocol DataLoader
{
    var dataHost: String {get}
    
    var refreshTimeout: TimeInterval  {get set}
    var delegate: DataLoaderDelegate? {get set}
    var gameId: String {get set}

    func gamesForDate(date: Date)
    
    func startGameLoading(completionHandler: @escaping (Game?, Error?) -> Swift.Void)
    func stopGameLoading()
}

@objc protocol DataLoaderDelegate {
    func gotGame(game: Any!)
    @objc optional func gotGameError(error: Error)
}

class DataLoaderManager
{
    class func loader(type: GameDataSourse, gameId: String) -> DataLoader? {
        switch type {
        case .espn:
            let loader = ESPNDataLoader()
            loader.gameId = gameId
            return loader
        default:
            return nil
        }
    }
}
