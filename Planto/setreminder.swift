//
//  SetReminderView.swift
//  Planto
//
//  MVVM - View Layer (Add New Plant)
//

import SwiftUI

struct SetReminderView: View {
    // MARK: - ViewModel
    @ObservedObject var viewModel: PlantsViewModel
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    // MARK: - State Properties
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"
    
    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background
                Color(red: 0x1C/255, green: 0x1C/255, blue: 0x1E/255)
                    .ignoresSafeArea()
                
                // MARK: - Form Content
                ScrollView {
                    VStack(spacing: 12) {
                        
                        // MARK: - Plant Name Field
                        ZStack {
                            HStack {
                                Text("  Plant Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                Spacer()
                                TextField("Pothos", text: $plantName)
                                    .padding(.vertical, 17)
                                    .foregroundColor(.white)
                            }
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                            )
                        }
                        Spacer(minLength: 15)
                        
                        // MARK: - Room and Light Section
                        VStack(spacing: 0) {
                            // Room Picker
                            HStack {
                                Image(systemName: "location.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 20)
                                
                                Text("Room")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                
                                Spacer()
                                
                                Picker("", selection: $selectedRoom) {
                                    Text("Bedroom").tag("Bedroom")
                                    Text("Living Room").tag("Living Room")
                                    Text("Kitchen").tag("Kitchen")
                                    Text("Bathroom").tag("Bathroom")
                                    Text("Balcony").tag("Balcony")
                                }
                                .pickerStyle(.menu)
                                .accentColor(.gray)
                            }
                            .padding(.vertical, 4.5)
                            .padding(.horizontal)
                            
                            Divider()
                                .background(Color.gray.opacity(0.3))
                                .padding(.horizontal, 16)
                            
                            // Light Picker
                            HStack {
                                Image(systemName: "sun.max.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 20)
                                
                                Text("Light")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                
                                Spacer()
                                
                                Picker("", selection: $selectedLight) {
                                    Text("Full sun").tag("Full sun")
                                    Text("Partial sun").tag("Partial sun")
                                    Text("Shade").tag("Shade")
                                }
                                .pickerStyle(.menu)
                                .accentColor(.gray)
                            }
                            .padding(.vertical, 4.5)
                            .padding(.horizontal)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                        )
                        Spacer(minLength: 15)
                        
                        // MARK: - Watering Section
                        VStack(spacing: 0) {
                            // Watering Days Picker
                            HStack {
                                Image(systemName: "drop.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 20)
                                
                                Text("Watering Days")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18))
                                
                                Spacer()
                                
                                Picker("", selection: $selectedWateringDays) {
                                    Text("Every day").tag("Every day")
                                    Text("Every 2 days").tag("Every 2 days")
                                    Text("Every 3 days").tag("Every 3 days")
                                    Text("Once a week").tag("Once a week")
                                }
                                .pickerStyle(.menu)
                                .accentColor(.gray)
                            }
                            .padding(.vertical, 4.5)
                            .padding(.horizontal)
                            
                            Divider()
                                .background(Color.gray.opacity(0.3))
                                .padding(.horizontal, 16)
                            
                            // Water Amount Picker
                            HStack {
                                Image(systemName: "drop.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 20)
                                
                                Text("Water")
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                
                                Spacer()
                                
                                Picker("", selection: $selectedWaterAmount) {
                                    Text("20-50 ml").tag("20-50 ml")
                                    Text("50-100 ml").tag("50-100 ml")
                                    Text("100-200 ml").tag("100-200 ml")
                                    Text("200-300 ml").tag("200-300 ml")
                                }
                                .pickerStyle(.menu)
                                .accentColor(.gray)
                            }
                            .padding(.vertical, 4.5)
                            .padding(.horizontal)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                        )
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // MARK: - Close Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(width: 32, height: 32)
                            .clipShape(Circle())
                    }
                }
                
                // MARK: - Title
                ToolbarItem(placement: .principal) {
                    Text("Set Reminder")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                // MARK: - Save Button (Checkmark)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Create new plant with form data
                        let newPlant = Plant(
                            name: plantName,
                            location: selectedRoom,
                            sunlight: selectedLight,
                            waterAmount: selectedWaterAmount,
                            isWatered: false
                        )
                        
                        // Add plant to ViewModel
                        viewModel.addPlant(newPlant)
                        
                        // Dismiss sheet
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                           
                            .frame(width: 32, height: 32)
                           
                            
                    }.buttonStyle(.borderedProminent)
                        .tint(.green)
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    SetReminderView(viewModel: PlantsViewModel())
}
