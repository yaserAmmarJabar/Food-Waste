//
//  Green_FoodApp.swift
//  Green Food
//
//  Created by Yaser Aljaf on 05/01/2024.
//

import SwiftUI

@main
struct Green_FoodApp: App {
    
    @State private var viewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(viewModel)
                .task {
                    await viewModel.requestDataScannerAccessStatus()
                }
        }
    }
}
