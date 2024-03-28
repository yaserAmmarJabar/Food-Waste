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
        TabView {
            bodyContent
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            StatisticsView()
                .tabItem {
                    Label("Summary", systemImage: "list.bullet")
                }
        }
    }
    
    private var bodyContent: some View {
        NavigationStack {
            ZStack {
                VStack {
                    // TODO: - Need to create 'The Dashboard'
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
            .fullScreenCover(isPresented: $didStartScanning) {
                CameraView(isPresented: $didStartScanning)
            }
        }
        
    }
    // add some code
    private func startScanning() {
        didStartScanning = true
    }
    
}

#Preview {
    HomeView()
}
