//
//  DataParser.swift
//  NBA
//
//  Created by Kalinin Andrey on 8/17/17.
//  Copyright © 2017 Kalinin Andrey. All rights reserved.
//

import Foundation

protocol DataParserProtocol {
    func parse(string: String, completionHandler: @escaping (Game?, Error?) -> Swift.Void)
}
