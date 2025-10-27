//
//  NotificationManager.swift
//  Planto
//
//  Created by Nora Abdullah Alhumaydani on 01/05/1447 AH.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
     
    func requestAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("❌ Notification permission error:", error.localizedDescription)
            } else {
                print("✅ Notification permission granted:", granted)
            }
        }
    }
    
   
    func scheduleNotification(for plantName: String, after seconds: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Hey! Let's water your plant"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("❌ Scheduling error:", error.localizedDescription)
            } else {
                print("✅ Notification scheduled for \(plantName)")
            }
        }
    }
}
