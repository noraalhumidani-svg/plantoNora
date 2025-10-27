
import SwiftUI

struct AllDoneView: View {
   
    @EnvironmentObject var viewModel: PlantsViewModel
    
    @Environment(\.dismiss) var dismiss
    
    @State private var showSetReminderSheet = false
    @State private var navigateToTodayReminder = false
    @State private var editingPlant: Plant? = nil
    
    var body: some View {
        ZStack {
          
            Color.black.ignoresSafeArea()
            
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
                .padding(.bottom, 8)
                
               
                Divider()
                    .background(Color.gray.opacity(0.9))
                    .padding(.top, -1)
                
                Spacer(minLength: 20)
                
                
                Image("plantoIMGwink")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 164, maxHeight: 200)
                    .padding(.top, -50)
                
              
                VStack(spacing: 20) {
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
                            .tint(.mint)
                            .clipShape(Circle())
                           
                    }
                    
                    .glassEffect(.clear)
                    .padding(.trailing, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .preferredColorScheme(.dark)
        
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
                   
                }
        }
       
        .sheet(item: $editingPlant) { plant in
            //show set reminder sheet
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



#Preview {
    AllDoneView()
        .environmentObject(PlantsViewModel())
}


