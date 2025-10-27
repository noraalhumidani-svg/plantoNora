//
//  PlantsViewModel.swift
//  Planto
//
//  MVVM - ViewModel Layer (Business Logic)
//

import Foundation
import SwiftUI
import Combine

class PlantsViewModel: ObservableObject {
    
   
    private let plantsKey = "SavedPlants"
    
   
    @Published var plants: [Plant] = [] {
        didSet {
            savePlants() // Auto-save whenever plants array changes
        }
    }
    
    @Published var shouldShowTodayReminder: Bool = false
    @Published var shouldShowAllDone: Bool = false
    
   
    
    /// At least one plant is not watered
    var hasUncheckedPlants: Bool {
        plants.contains { !$0.isWatered }
    }
    
    /// Count of plants that have been watered
    var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }
    
    /// Progress percentage (0.0 to 1.0) of watered plants
    var progressPercentage: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }
    
    /// Check if all plants are watered
    var allPlantsWatered: Bool {
        !plants.isEmpty && plants.allSatisfy { $0.isWatered }
    }
    
    /// Message to display based on watered count
    var statusMessage: String {
        if wateredCount == 0 {
            return "Your plants are waiting for a sip 💦"
        } else {
            return "\(wateredCount) of your plants feel loved today ✨"
        }
    }
    
    
    init() {
        loadPlants()
    }
    
    
    
    /// Load plants from UserDefaults
    func loadPlants() {
        guard let data = UserDefaults.standard.data(forKey: plantsKey) else {
            print("📭 No saved plants found")
            return
        }
        
        do {
            plants = try JSONDecoder().decode([Plant].self, from: data)
            print("✅ Loaded \(plants.count) plants from UserDefaults")
        } catch {
            print("❌ Error loading plants: \(error)")
        }
    }
    
    /// Save plants to UserDefaults
    private func savePlants() {
        do {
            let data = try JSONEncoder().encode(plants)
            UserDefaults.standard.set(data, forKey: plantsKey)
            print("💾 Saved \(plants.count) plants to UserDefaults")
        } catch {
            print("❌ Error saving plants: \(error)")
        }
    }
    
    
    
    /// Add a new plant to the collection
    func addPlant(_ plant: Plant) {
        plants.append(plant)
        shouldShowTodayReminder = true
    }
    
    /// Update an existing plant
    func updatePlant(_ updatedPlant: Plant) {
        if let index = plants.firstIndex(where: { $0.id == updatedPlant.id }) {
            plants[index] = updatedPlant
        }
    }
    
    /// Delete a plant by its ID
    func deletePlant(withId id: UUID) {
        plants.removeAll { $0.id == id }
    }
    
    /// Delete a plant at specific index
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
    
    /// Toggle watered status at specific index
    func toggleWatered(at index: Int) {
        guard index >= 0 && index < plants.count else { return }
        plants[index].isWatered.toggle()
        
        // Check if all plants are now watered
        if allPlantsWatered {
            shouldShowAllDone = true
        }
    }
    
    /// Reset all plants' watered status
    func resetWateredStatus() {
        for index in plants.indices {
            plants[index].isWatered = false
        }
        shouldShowAllDone = false
    }
    
    /// Clear all plants
    func clearAllPlants() {
        plants.removeAll()
        shouldShowTodayReminder = false
        shouldShowAllDone = false
    }
}
