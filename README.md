# 🌿 Planto — Smart Plant Reminder App

Planto is a simple, elegant iOS app built with **SwiftUI** and **SwiftData**, designed to help plant lovers keep track of their plant care routine. 🌱  
It allows users to **add plants**, **set watering reminders**, and **track daily progress** — all in a clean, dark-themed interface.



## 📱 App Overview

Planto helps you:
- Add your plants and record details like name, location, sunlight level, and water amount.  
- Get gentle reminders to water them.  
- Track progress and see when all your plants are watered for the day.  
- Enjoy a smooth and minimal user experience.



## 🖼️ Screenshots

### 🌱 Start Your Journey
<img width="463" height="939" alt="Screenshot 1447-05-05 at 7 22 48 PM" src="https://github.com/user-attachments/assets/ed767e04-c7d1-4917-a80b-d0fbacf43509" />


### 💧 Today’s Reminders
<img width="454" height="952" alt="Screenshot 1447-05-05 at 7 27 30 PM" src="https://github.com/user-attachments/assets/8e7f2b02-ba1e-4577-8d75-a11bd28402b6" />


### 🎉 All Done Screen
<img width="513" height="939" alt="Screenshot 1447-05-05 at 7 27 41 PM" src="https://github.com/user-attachments/assets/df3bf764-32f7-4959-aea6-e37e6866af99" />




## ⚙️ Features

✅ Add, edit, and delete plants  
✅ Mark plants as watered  
✅ Auto-detect when all plants are completed  
✅ Local push notifications using **UserNotifications**  
✅ Persistent data storage with **SwiftData**  
✅ Clean and responsive SwiftUI design  



## 🧠 Architecture

**MVVM (Model-View-ViewModel)** pattern:
- **Model** → `Plant.swift` (Defines the plant structure and data)  
- **ViewModel** → `PlantsViewModel.swift` (Handles app logic and data management)  
- **Views** → `ContentView`, `TodayReminderView`, `AllDoneView`, etc.  
- **NotificationManager.swift** → Manages all local notification permissions and scheduling.  



## 📂 Main Files

| File | Description |

| `Plant.swift` | Data model for each plant |
| `PlantsViewModel.swift` | Handles adding, toggling, deleting, and saving plant data |
| `NotificationManager.swift` | Manages user notifications |
| `PlantoApp.swift` | Main app entry point |
| `ContentView.swift` | Start view to begin your plant journey |
| `TodayReminderView.swift` | Displays today’s plants and watering progress |
| `AllDoneView.swift` | Shown when all plants are watered |


## 🔔 Notification Flow

1. The app requests permission for notifications when it first launches.  
2. When a new plant is added, a local notification is scheduled.  
3. Users receive a reminder to water their plants after the set interval.  
4. Once all plants are watered, the app celebrates with an “All Done 🎉” screen.



## 🧩 Tech Stack

- **SwiftUI** – UI Framework  
- **SwiftData / UserDefaults** – Persistent Storage  
- **UserNotifications** – Local reminders  
- **MVVM** – App architecture pattern  



## 🚀 How to Run

[1. Clone this repository  ](https://github.com/noraalhumidani-svg/plantoNora/tree/main/Planto.xcodeproj)
  
