
//  PlantoApp.swift
//  Planto
//

import SwiftUI

@main
struct PlantoApp: App {
    init() {
        NotificationManager.shared.requestAuthorization()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

