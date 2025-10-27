//
//  TodayReminderView.swift
//  Planto
//
//  MVVM - View Layer (Today's Plants List)
//

import SwiftUI

struct TodayReminderView: View {
    
    @EnvironmentObject var viewModel: PlantsViewModel
   
    @Environment(\.dismiss) var dismiss
    
    @State private var editingPlant: Plant? = nil
    @State private var showingSetReminder = false
    
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
                    Text(viewModel.statusMessage)
                        .font(.body)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                  
              
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            // Background bar
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.3))
                                .frame(height: 8)
                            
                            // Filled progress bar
                            RoundedRectangle(cornerRadius: 4)
                                .foregroundColor(Color(hex: 0x28E0A8))
                                .frame(width: geometry.size.width * viewModel.progressPercentage, height: 8)
                                .animation(.easeOut(duration: 0.5), value: viewModel.progressPercentage)
                        }
                    }
                    .frame(height: 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 24)
                
              
                List {
                    ForEach(viewModel.plants.indices, id: \.self) { index in
                        PlantRow(
                            plant: viewModel.plants[index],
                            onToggle: {
                                viewModel.toggleWatered(at: index)
                            }
                        )
                        //click to edit plant
                    .onTapGesture {
                            editingPlant = viewModel.plants[index]
                       }
                        
                        //swipe to delete
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.deletePlant(at: index)
                               
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        .listRowSeparator(.hidden)
                    }
                   //if plants are empty
                                        if viewModel.plants.isEmpty {
                                            VStack(spacing: 8) {
                                                Text("No plants yet")
                                                    .font(.headline)
                                                    .foregroundColor(.white.opacity(0.9))
                                                Text("Tap + to add a plant reminder")
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(maxWidth: .infinity)
                                            .listRowBackground(Color.clear)
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
                    //show sheet on button click
                    Button(action: {
                        showingSetReminder = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
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
            SetReminderView(viewModel: viewModel)
        }
        .sheet(item: $editingPlant) { plant in
            SetReminderEditView(
                viewModel: viewModel,
                existingPlant: plant,
                onDelete: {
                    viewModel.deletePlant(withId: plant.id)
                    editingPlant = nil
                    
                }
            )
        }
        .navigationDestination(isPresented: $viewModel.shouldShowAllDone) {
            AllDoneView()
                .environmentObject(viewModel)
                .navigationBarBackButtonHidden(true)
        }
        .preferredColorScheme(.dark)
    }
}


struct PlantRow: View {
    let plant: Plant
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


private extension Color {
    init(hex rgb: UInt32, alpha: Double = 1.0) {
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        self = Color(red: r, green: g, blue: b).opacity(alpha)
    }
}

#Preview {
    TodayReminderView()
        .environmentObject(PlantsViewModel())
}
