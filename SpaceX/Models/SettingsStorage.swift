//
//  SettingsStorage.swift
//  SpaceX
//
//  Created by Kairat Yelubay on 29.07.2022.
//

import Foundation

final class SettingsStorage {
    static let shared = SettingsStorage()
    private let storage = UserDefaults.standard
    
    private init() {}
    
    func setHeightUnit(_ unit: String) {
        storage.set(unit, forKey: "HeightUnit")
    }
    
    func getHeightUnit() -> String {
        guard let unit = storage.string(forKey: "HeightUnit") else {
            return "ft"
        }
        
        return unit
    }
    
    func setDiameterUnit(_ unit: String) {
        storage.set(unit, forKey: "DiameterUnit")
    }
    
    func getDiameterUnit() -> String {
        guard let unit = storage.string(forKey: "DiameterUnit") else {
            return "ft"
        }
        
        return unit
    }
    
    func setMassUnit(_ unit: String) {
        storage.set(unit, forKey: "MassUnit")
    }
    
    func getMassUnit() -> String {
        guard let unit = storage.string(forKey: "MassUnit") else {
            return "lb"
        }
        
        return unit
    }
    
    func setPayloadUnit(_ unit: String) {
        storage.set(unit, forKey: "PayloadUnit")
    }
    
    func getPayloadUnit() -> String {
        guard let unit = storage.string(forKey: "PayloadUnit") else {
            return "lb"
        }
        
        return unit
    }
}
