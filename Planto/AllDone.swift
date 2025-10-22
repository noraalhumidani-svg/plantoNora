import SwiftUI

struct AllDone: View {
    @State private var showSetReminderSheet = false
    @State private var navigateToTodayReminder = false
    @Environment(\.dismiss) var dismiss

    @Binding var plants: [Plant]

    @State private var editingPlant: Plant? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    // Title
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

                        Divider()
                            .background(Color.gray.opacity(0.9))
                            .padding(.top, -1)
                            
                        Spacer(minLength: 20)

                        Image("plantoIMGwink")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 164 ,maxHeight: 200)
                            .padding(.top, 10)
                    // Title and subtitle
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
                            .padding(.top,1)
                    }
                    .padding(.top, 28)
                    
                    Spacer()
                }
                
                // Floating add button
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
                                
                            //.background(Color(hex: 0x28E0A8))
                              
                              
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.3), radius: 8, x: 0, y: 4)
                                .tint(.green)
                            

                        }
                        .glassEffect(.clear)
                        
                        .padding(.trailing, 24)
                        .padding(.bottom, 24)
                    }
                }
            } // Close ZStack
            
            .sheet(isPresented: $showSetReminderSheet) {
                setreminder { newPlant in
                    // Clear all old plants and only keep the new one
                    plants = [newPlant]
                    
                    showSetReminderSheet = false
                    DispatchQueue.main.async {
                        navigateToTodayReminder = true
                    }
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
                    },
                    existingPlant: plant
                )
            }
            .navigationDestination(isPresented: $navigateToTodayReminder) {
                TodayReminder(plants: $plants)  // Navigate to TodayReminder
                    .navigationBarBackButtonHidden(true)
            }
            .preferredColorScheme(.dark)
        } // Close NavigationStack
    }
}

#Preview {
    AllDone(plants: .constant([]))
}

// MARK: - Color hex convenience
private extension Color {
    init(hex rgb: UInt32, alpha: Double = 1.0) {
        let r = Double((rgb & 0xFF0000) >> 16) / 255.0
        let g = Double((rgb & 0x00FF00) >> 8) / 255.0
        let b = Double(rgb & 0x0000FF) / 255.0
        self = Color(red: r, green: g, blue: b).opacity(alpha)
    }
}
