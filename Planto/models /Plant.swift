//
//  Plant.swift
//  Planto
//
//  Created by Nora Abdullah Alhumaydani on 28/04/1447 AH.
//
//MODEL
import Foundation
import SwiftData

struct Plant: Identifiable, Codable, Equatable{
  
    var id: UUID
    var name: String
    var location: String
    var sunlight: String
    var waterAmount: String
    var isWatered: Bool = false

    init(id: UUID = UUID(),
         name: String,
         location: String,
         sunlight: String,
         waterAmount: String,
         isWatered: Bool = false) {
        self.id = id
        self.name = name
        self.location = location
        self.sunlight = sunlight
        self.waterAmount = waterAmount
        self.isWatered = isWatered
    }
}
