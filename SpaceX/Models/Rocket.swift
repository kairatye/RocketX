//
//  Rocket.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 12.07.2022.
//

import Foundation

// MARK: - Rocket
struct Rocket: Codable {
    let height, diameter: Diameter
    let mass: Mass
    let firstStage: FirstStage
    let secondStage: SecondStage
    let payloadWeights: [PayloadWeight]
    let flickrImages: [String]
    let name: String
    let costPerLaunch: Int
    let firstFlight, country: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case height, diameter, mass
        case firstStage = "first_stage"
        case secondStage = "second_stage"
        case payloadWeights = "payload_weights"
        case flickrImages = "flickr_images"
        case name
        case costPerLaunch = "cost_per_launch"
        case firstFlight = "first_flight"
        case country
        case id
    }
}

// MARK: - Diameter
struct Diameter: Codable {
    let meters, feet: Double?
}

// MARK: - FirstStage
struct FirstStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}

// MARK: - Mass
struct Mass: Codable {
    let kg, lb: Int
}

// MARK: - PayloadWeight
struct PayloadWeight: Codable {
    let id, name: String
    let kg, lb: Int
}

// MARK: - SecondStage
struct SecondStage: Codable {
    let engines: Int
    let fuelAmountTons: Double
    let burnTimeSEC: Int?

    enum CodingKeys: String, CodingKey {
        case engines
        case fuelAmountTons = "fuel_amount_tons"
        case burnTimeSEC = "burn_time_sec"
    }
}
