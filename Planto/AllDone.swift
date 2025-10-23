//
//  AllDoneView.swift
//  Planto
//
//  MVVM - View Layer (Completion Screen)
//

import SwiftUI

struct AllDoneView: View {
    // MARK: - ViewModel
    @EnvironmentObject var viewModel: PlantsViewModel
    
    // MARK: - Environment
    @Environment(\.dismiss) var dismiss
    
    // MARK: - State Properties
    @State private var showSetReminderSheet = false
    @State private var navigateToTodayReminder = false
    @State private var editingPlant: Plant? = nil
    
    var body: some View {
        ZStack {
            // MARK: - Background
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // MARK: - Title
                HStack {
                    Text("My Plants 🌱")
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                .padding(.bottom, 8)
                
                // MARK: - Divider
                Divider()
                    .background(Color.gray.opacity(0.9))
                    .padding(.top, -1)
                
                Spacer(minLength: 20)
                
                // MARK: - Celebration Image
                Image("plantoIMGwink")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 164, maxHeight: 200)
                    .padding(.top, 10)
                
                // MARK: - Celebration Text
                VStack(spacing: 10) {
                    Text("All Done! 🎉")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 16)
                    
                    Text("All Reminders Completed")
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                        .padding(.top, 1)
                }
                .padding(.top, 28)
                
                Spacer()
            }
            
            // MARK: - Floating Action Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        showSetReminderSheet = true
                    }) {
                        Image(systemName: "plus")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 56, height: 56)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                            .tint(.green)
                    }
                    .glassEffect(.clear)
                    .padding(.trailing, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
        // MARK: - Add New Plant Sheet
        .sheet(isPresented: $showSetReminderSheet) {
            SetReminderView(viewModel: viewModel)
                .onDisappear {
                    // When user adds a new plant from AllDone page
                    guard let newPlant = viewModel.plants.last else { return }
                    
                    // Keep only the newly added plant WITHOUT resetting navigation flags
                    viewModel.plants = [newPlant]
                    
                    // Ensure we are not stuck on AllDone and that TodayReminder stays visible
                    viewModel.shouldShowAllDone = false
                    viewModel.shouldShowTodayReminder = true
                    
                    // Close the sheet (not the navigation)
                    // (dismiss here dismisses the sheet scope automatically after onDisappear)
                }
        }
        // MARK: - Edit Plant Sheet
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
    }
}

// MARK: - Color Extension
private extension Color {
    init(hex rgb: UInt32, alpha: Double = 1.0) {
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        self = Color(red: r, green: g, blue: b).opacity(alpha)
    }
}

#Preview {
    AllDoneView()
        .environmentObject(PlantsViewModel())
}
