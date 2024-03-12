//
//  HomeView.swift
//  Green Food
//
//  Created by Yaser Aljaf on 30/01/2024.
//

import SwiftUI

struct HomeView: View {
    @State private var didStartScanning = false
    @State private var date = Date()
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    DatePicker(
                        "Start Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                    
                    Spacer()
                }
            }
            
            .padding()
            .navigationTitle("Home")
            .toolbar {
                Button {
                    startScanning()
                } label: {
                    Image(systemName: "camera")
                }
            }
            .sheet(isPresented: $didStartScanning) {
                CameraView(isPresented: $didStartScanning)
            }
        }
    }
    
    private func startScanning() {
        didStartScanning = true
    }
    
}

#Preview {
    HomeView()
}
