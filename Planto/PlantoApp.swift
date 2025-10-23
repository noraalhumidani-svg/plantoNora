//
//  PlantoApp.swift
//  Planto
//
//  Created by Nora Abdullah Alhumaydani on 26/04/1447 AH.
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
