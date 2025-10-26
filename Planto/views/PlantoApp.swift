//
//  PlantoApp.swift
//  Planto
//

import SwiftUI
import SwiftData

@main
struct PlantoApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: Plant.self)
    }
}

struct RootView: View {
    
    @Query(sort: \Plant.name) private var plants: [Plant]
    @Environment(\.modelContext) private var modelContext

    
    @StateObject private var vm = PlantsViewModel()

    var body: some View {
        Group {
           
            if plants.isEmpty {
                ContentView()
                    
            }
           
            else if plants.contains(where: { !$0.isWatered }) {
                TodayReminderView()
                    .environmentObject(vm)
            }
            
            else {
                ContentView()
            }
        }
        .onAppear {
           
            vm.plants = plants
           
            vm.modelContext = modelContext
        }
    }
}
