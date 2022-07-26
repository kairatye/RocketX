//
//  Launch.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 16.07.2022.
//

import Foundation

struct Launch: Codable {
    let success: Bool?
    let rocket: String
    let name: String
    let dateUnix: TimeInterval
    
    enum CodingKeys: String, CodingKey {
        case success, rocket, name
        case dateUnix = "date_unix"
    }
}
