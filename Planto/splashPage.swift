//
//  ContentView.swift
//  Planto
//
//  Created by Nora Abdullah Alhumaydani on 26/04/1447 AH.
//

import SwiftUI

struct ContentView: View {
    @State private var showSetReminderSheet = false
    
    var body: some View {
        ZStack {
            // Full-screen black background
            Color.black.ignoresSafeArea()
            
            // Single main layout stack
            VStack(spacing: 0) {
                // Header
                HStack {
                    Text("My Plants 🌱")
                        .font(.title)
                        .foregroundStyle(.white)
                        .bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                .padding(.top, 16)
                
                Spacer(minLength: 24)
                
                // Image
                Image("plantoIMG")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 164 ,maxHeight: 200) // adjust as needed
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
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.green) // change color here if desired
                        )
                        .padding(.horizontal, 24)
                }
                .padding(.bottom, 110)
                .sheet(isPresented: $showSetReminderSheet) {
                    // Placeholder sheet content
                    VStack(spacing: 16) {
                        Text("Set Plant Reminder")
                            .font(.title2)
                            .bold()
                        
                        Text("Put your reminder setup view here.")
                            .foregroundColor(.secondary)
                        Button("Close") {
                            // Dismiss sheet
                            showSetReminderSheet = false
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
