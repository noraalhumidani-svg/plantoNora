//
//  PlantsViewModel.swift
//  Planto
//
//  Created by Nora Abdullah Alhumaydani on 30/04/1447 AH.
//


//
//  PlantsViewModel.swift
//  Planto
//
//  MVVM - ViewModel Layer (Business Logic)
//

import Foundation
import SwiftUI
import Combine
import UserNotifications
import SwiftData

class PlantsViewModel: ObservableObject {
    
    var modelContext: ModelContext?
    
    @Published var plants: [Plant] = []
    
    @Published var shouldShowTodayReminder: Bool = false
    @Published var shouldShowAllDone: Bool = false
    
    // At least one plant is not watered
    var hasUncheckedPlants: Bool {
        plants.contains { !$0.isWatered }
    }
    
    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }
    
    var progressPercentage: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }
    
    var allPlantsWatered: Bool {
        !plants.isEmpty && plants.allSatisfy { $0.isWatered }
    }
    
    var statusMessage: String {
        if wateredCount == 0 {
            return "Your plants are waiting for a sip 💦"
        } else {
            return "\(wateredCount) of your plants feel loved today ✨"
        }
    }
    
    func addPlant(_ plant: Plant) {
        plants.append(plant)
        shouldShowTodayReminder = true
    }
    
    func updatePlant(_ updatedPlant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == updatedPlant.id }) {
            plants[index] = updatedPlant
        }
    }
    
    func deletePlant(withId id: UUID) {
        plants.removeAll { $0.id == id }
    }
    
    func deletePlant(at index: Int) {
        guard index >= 0 && index < plants.count else { return }
        plants.remove(at: index)
    }
    
    /// Toggle watered status for a plant
    func toggleWatered(for plant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == plant.id }) {
            plants[index].isWatered.toggle()
            
            // Check if all plants are now watered
            if allPlantsWatered {
                shouldShowAllDone = true
            }
        }
    }
    
    func toggleWatered(at index: Int) {
        guard index >= 0 && index < plants.count else { return }
        plants[index].isWatered.toggle()
        
        if allPlantsWatered {
            shouldShowAllDone = true
        }
    }
    
    func resetWateredStatus() {
        for index in plants.indices {
            plants[index].isWatered = false
        }
        shouldShowAllDone = false
    }
     
    func clearAllPlants() {
        plants.removeAll()
        shouldShowTodayReminder = false
        shouldShowAllDone = false
    }
    
    func fetchPlants() {
        guard let modelContext else {
            // modelContext is nil — nothing to fetch from
            print("PlantsViewModel.fetchPlants(): modelContext is nil")
            return
        }
        let descriptor = FetchDescriptor<Plant>()
        do {
            plants = try modelContext.fetch(descriptor)
        } catch {
            print("Error fetching plants: \(error)")
        }
    }
}

