//
//  ContentView.swift
//  Planto
//
//  MVVM - View Layer (Splash Screen)
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @StateObject private var viewModel = PlantsViewModel()
    @Environment(\.modelContext) private var context
    
    @State private var showSetReminderSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color.black.ignoresSafeArea()
                
                // Main content
                VStack(spacing: 0) {
                   
                    HStack {
                        Text("My Plants 🌱")
                            .font(.largeTitle)
                            .foregroundStyle(.white)
                            .bold()
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    
                    Spacer(minLength: 24)
                    
                   
                    Divider()
                        .background(Color.gray.opacity(0.9))
                        .padding(.top, -100)
                   
                   
                    Image("plantoIMG")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 164, maxHeight: 200)
                        .padding(.top, 8)
                    
                    Spacer(minLength: 24)
                    
                   
                    VStack(spacing: 10) {
                        Text("Start your plant journey!")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 16)
                        
                        Text("Now all your plants will be in one place and\nwe will help you take care of them :)🪴")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.top, 25)
                    }
                    .padding(.top, -80)
                    
                    Spacer()
                    
                  
                    Button(action: {
                        showSetReminderSheet = true
                    }) {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 280, maxHeight: 8)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 25)
                                
                                    .fill(.ultraThinMaterial)
                                    
                                    .fill(Color.mint)
                                    .glassEffect(.clear)
                            )
                            .padding(.horizontal, 67)
                    }
                    .padding(.bottom, 110)
                    .sheet(isPresented: $showSetReminderSheet) {
                        SetReminderView(viewModel: viewModel)
                    }
                }
               
            }
            .navigationDestination(isPresented: $viewModel.shouldShowTodayReminder) {
                TodayReminderView()
                    .environmentObject(viewModel)
                    .navigationBarBackButtonHidden(true)
            }
            .preferredColorScheme(.dark)
        }
        Button("Test Notification") {
                   NotificationManager.shared.scheduleNotification(for: "Pothos", after: 5)
               }
        
    }
}

#Preview {
    ContentView()
}


