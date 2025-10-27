//
//  SetReminderEditView.swift
//  Planto
//
//  MVVM - View Layer (Edit Existing Plant)
//

import SwiftUI

struct SetReminderEditView: View {
    
    @ObservedObject var viewModel: PlantsViewModel
    
   
    @Environment(\.dismiss) var dismiss
    
    
    var existingPlant: Plant
    var onDelete: () -> Void
    
  
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"
    
    init(viewModel: PlantsViewModel, existingPlant: Plant, onDelete: @escaping () -> Void) {
        self.viewModel = viewModel
        self.existingPlant = existingPlant
        self.onDelete = onDelete
        
        // Pre-fill form with existing plant data
        _plantName = State(initialValue: existingPlant.name)
        _selectedRoom = State(initialValue: existingPlant.location)
        _selectedLight = State(initialValue: existingPlant.sunlight)
        _selectedWaterAmount = State(initialValue: existingPlant.waterAmount)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
              
                Color(red: 0x1C/255, green: 0x1C/255, blue: 0x1E/255)
                    .ignoresSafeArea()
                
               
                ScrollView {
                    VStack(spacing: 12) {
                        
                        
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
                                
                                Picker("", selection: $selectedRoom) {Text("Bedroom").tag("Bedroom")
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
                        
                     
                        Spacer(minLength: 35)
                        
                        Button(action: {
                            onDelete()
                            dismiss()
                        }) {
                            Text("Delete Reminder")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .frame(height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                                        .glassEffect(.clear)
                                )
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 12)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
             
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
                
               
                ToolbarItem(placement: .principal) {
                    Text("Set Reminder")
                        .foregroundColor(.white)
                        .font(.headline)
                }
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Create updated plant with form data
                        let updatedPlant = Plant(
                            id: existingPlant.id,
                            name: plantName,
                            location: selectedRoom,
                            sunlight: selectedLight,
                            waterAmount: selectedWaterAmount,
                            isWatered: existingPlant.isWatered
                        )
                        
                        // Update plant in ViewModel
                        viewModel.updatePlant(updatedPlant)
                        
                        // Dismiss sheet
                        dismiss()
                    } label: {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                            .frame(width: 32, height: 32)
                    }.buttonStyle(.borderedProminent)
                        .tint(.mint)
                }
            }
        }
    }
}

#Preview {
    SetReminderEditView(
        viewModel: PlantsViewModel(),
        existingPlant: Plant(name: "Pothos", location: "Bedroom", sunlight: "Full sun", waterAmount: "20-50 ml"),
        onDelete: {}
    )
}
