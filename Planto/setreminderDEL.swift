//
//  setreminderDEL.swift
//  Planto
//
//  Created by Nora Abdullah Alhumaydani on 29/04/1447 AH.
//

import SwiftUI

struct setreminderDEL: View {
    
    var onSave: (Plant) -> Void
        var onDelete: (() -> Void)?  // ADD THIS - callback for deletion
        var existingPlant: Plant?    // ADD THIS - the plant being edited
        
   
    
    @Environment(\.dismiss) var dismiss
    @State private var plantName: String = ""
    @State private var selectedRoom: String = "Bedroom"
    @State private var selectedLight: String = "Full sun"
    @State private var selectedWateringDays: String = "Every day"
    @State private var selectedWaterAmount: String = "20-50 ml"
    
    init(onSave: @escaping (Plant) -> Void,
             onDelete: (() -> Void)? = nil,
             existingPlant: Plant? = nil) {
            self.onSave = onSave
            self.onDelete = onDelete
            self.existingPlant = existingPlant
            
            // Pre-fill the form if editing existing plant
            if let plant = existingPlant {
                _plantName = State(initialValue: plant.name)
                _selectedRoom = State(initialValue: plant.location)
                _selectedLight = State(initialValue: plant.sunlight)
                _selectedWaterAmount = State(initialValue: plant.waterAmount)
            }
        }
    var body: some View {
    NavigationStack {
        
        ZStack {
          
            Color(red: 0x1C/255, green: 0x1C/255, blue: 0x1E/255)
                .ignoresSafeArea()
            
         
            ScrollView {
                VStack(spacing: 12) {
                    
                    ZStack{
                       //%%%%%%%%%%% PLANT NAME
                        HStack(){
                            Text("  Plant Name")
                                .foregroundColor(.white)
                                .font(.system(size:18))
                            Spacer()
                            TextField("Pothos", text: $plantName)
                                .padding(.vertical, 17)
                                .foregroundColor(.white)
                                
                            
                            
                        }
                            .background(
                            RoundedRectangle(cornerRadius: 30 )
                           .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                                )}
                    Spacer(minLength: 15)
                    
             
                    VStack(spacing: 0) {
                        
                        //%%%%%%%%%%% ROOM AND LIGHT
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.white)
                                .frame(width: 20)
                            
                            Text("Room")
                                .foregroundColor(.white)
                                .font(.system(size:18))
                            
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
                        
                        // Divider
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal, 16)
                        
                       
                        HStack {
                            Image(systemName: "sun.max.fill")
                                .foregroundColor(.white)
                                .frame(width: 20)
                            
                            Text("Light")
                                .foregroundColor(.white)
                                .font(.system(size:18))
                            
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
                    
                    //%%%%%%%%%%% WATER AND WATERING DAYS
                    VStack(spacing: 0) {
                        
                        // Watering Days
                        HStack {
                            Image(systemName: "drop.fill")
                                .foregroundColor(.white)
                                .frame(width: 20)
                            
                            Text("Watering Days")
                                .foregroundColor(.white)
                                .font(.system(size:18))
                            
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
                        
                        // Divider
                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal, 16)
                        
                        // Water Amount
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
                    // Delete Button
                    Spacer(minLength: 35)

                    Button(action: {
                         onDelete?()
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
                } // End main VStack
                .padding(.horizontal, 20)
                .padding(.top, 12)
                
            } // End ScrollView
            
        } // End ZStack
      
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            
            // X Button
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
            
            // Title
            ToolbarItem(placement: .principal) {
                Text("Set Reminder")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            
            // Checkmark Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    let newPlant = Plant(
                        name: plantName,
                        location: selectedRoom,
                        sunlight: selectedLight,
                        waterAmount: selectedWaterAmount,
                        isWatered: false
                    )
                    onSave(newPlant)
                    dismiss()

                   
                } label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .bold))
                        .frame(width: 38, height: 32)
                        .background(Color.green)
                        .clipShape(Circle())
                }
              
            }
        }
        
    }
}
}
    
    #Preview {
        setreminderDEL(onSave: { _ in })
    }

