//
//  TodayReminder.swift
//  Planto
//
//  Created by Nora Abdullah Alhumaydani on 28/04/1447 AH.
//

import SwiftUI

struct TodayReminder: View {
    @Environment(\.dismiss) var dismiss

    @Binding var plants: [Plant]
    @State private var showAllDone = false   // ✅ For navigation to AllDone

    @State private var editingPlant: Plant? = nil
    @State private var selectedPlant: Plant?
    @State private var showingSetReminder = false

    private var wateredCount: Int {
        plants.filter { $0.isWatered }.count
    }

    private var progressPercentage: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                VStack(spacing: 12) {
                    Text(wateredCount == 0
                         ? "Your plants are waiting for a sip 💦"
                         : "\(wateredCount) of your plants feel loved today ✨")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 8)
                            
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color(hex: 0x28E0A8))
                                .frame(width: geometry.size.width * progressPercentage, height: 8)
                                .animation(.easeOut(duration: 0.5), value: progressPercentage)
                        }
                    }
                    .frame(height: 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                
                List {
                    ForEach(plants.indices, id: \.self) { index in
                        PlantRow(
                            plant: $plants[index],
                            onToggle: {
                                plants[index].isWatered.toggle()
                                
                                // ✅ Navigate to AllDone if all are watered
                                if plants.allSatisfy({ $0.isWatered }) {
                                    showAllDone = true
                                }
                            }
                        )
                        .onTapGesture {
                            editingPlant = plants[index]
                        }
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                plants.remove(at: index)
                                if plants.isEmpty {
                                    dismiss()
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                
                Spacer()
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showingSetReminder = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .frame(width: 56, height: 56)
                            .background(Color(hex: 0x28E0A8))
                            .glassEffect(.clear)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.trailing, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .sheet(isPresented: $showingSetReminder) {
            setreminder { newPlant in
                plants.append(newPlant)
            }
        }
        .sheet(item: $editingPlant) { plant in
            setreminderDEL(
                onSave: { updatedPlant in
                    if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                        plants[index] = updatedPlant
                    }
                },
                onDelete: {
                    if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                        plants.remove(at: index)
                    }
                    editingPlant = nil
                    if plants.isEmpty {
                        dismiss()
                    }

                },
                existingPlant: plant
            )
            
        }

        // ✅ Navigation to AllDone page
        .navigationDestination(isPresented: $showAllDone) {
            AllDone(plants: $plants)
        }


        .preferredColorScheme(.dark)
    }

    struct PlantRow: View {
        @Binding var plant: Plant
        let onToggle: () -> Void
        
        var body: some View {
            HStack(alignment: .top, spacing: 16) {
                Button(action: {
                    onToggle()
                }) {
                    ZStack {
                        Circle()
                            .strokeBorder(
                                plant.isWatered ? Color.cyan : Color.gray.opacity(0.5),
                                lineWidth: 2
                            )
                            .background(
                                Circle().fill(plant.isWatered ? Color(hex: 0x28E0A8) : Color.clear)
                            )
                            .frame(width: 24, height: 24)
                        
                        if plant.isWatered {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.black)
                        }
                    }
                }
                .buttonStyle(PlainButtonStyle())
                .animation(.easeInOut(duration: 0.2), value: plant.isWatered)
                
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 12))
                        Text("in \(plant.location)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Text(plant.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "sun.max.fill")
                                .font(.system(size: 12))
                                .foregroundColor(Color(hex: 0xCCC785))
                            Text(plant.sunlight)
                                .font(.caption)
                                .foregroundColor(Color(hex: 0xCCC785))
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                        .foregroundColor(.white)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "drop.fill")
                                .font(.system(size: 12))
                            Text(plant.waterAmount)
                                .font(.caption)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(4)
                        .foregroundColor(Color(hex: 0xCAF3FB))
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    TodayReminder(plants: .constant([]))
}

private extension Color {
    init(hex rgb: UInt32, alpha: Double = 1.0) {
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        self = Color(red: r, green: g, blue: b).opacity(alpha)
    }
}
