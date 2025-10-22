import SwiftUI

struct ContentView: View {
    @State private var showSetReminderSheet = false
    @State private var navigateToTodayReminder = false  // ADD THIS
    @State private var plants: [Plant] = []  // ADD THIS to store plants
    
    var body: some View {
        NavigationStack {  // WRAP everything in NavigationStack
            ZStack {
                // Your existing content
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
                    .padding(.bottom, 16)
                    
                    Spacer(minLength: 24)
                    
                    Divider()
                        .background(Color.gray.opacity(0.9))
                        .padding(.top, -100)
                   
                    // Image
                    Image("plantoIMG")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 164 ,maxHeight: 200)
                        .padding(.top, 8)
                    
                    Spacer(minLength: 24)
                    
                    // Title and subtitle
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
                    
                    // Button
                    Button(action: {
                        showSetReminderSheet = true
                    }) {
                        Text("Set Plant Reminder")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: 280 , maxHeight: 8)
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
                        setreminder { newPlant in
                            plants.append(newPlant)  // Save the plant
                            navigateToTodayReminder = true  // Trigger navigation
                        }
                    }
                    
                }
            }
            .navigationDestination(isPresented: $navigateToTodayReminder) {
                TodayReminder(plants: $plants)
                    .navigationBarBackButtonHidden(true)
            }
            

            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
}
