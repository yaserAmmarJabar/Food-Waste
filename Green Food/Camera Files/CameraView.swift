//
//  CameraView.swift
//  Green Food
//
//  Created by Yaser Aljaf on 05/01/2024.
//

import SwiftUI
import VisionKit

struct CameraView: View {
    @Environment(ViewModel.self) private var viewModel
    
    @State private var date = Date()
    @State private var didScanningStart = false
    
    @Binding var isPresented: Bool
    
    private let textContentTypes: [(title: String, textContentType: DataScannerViewController.TextContentType?)] = [
        ("ALL", .none),
        ("URL", .URL),
        ("Phone", .telephoneNumber),
        ("Email", .emailAddress),
        ("Address", .fullStreetAddress)
    ]
    
    var body: some View {
        // homeView
        if viewModel.dataScannerAccessStatus == .scannerAvailable {
            scannerView
        }
    }
    
    private var scannerView: some View {
        @Bindable var viewModel = viewModel
        return NavigationStack {
            VStack {
                DataScannerView(
                    recognizedItems: $viewModel.recognizedItems,
                    recognizedDataType: viewModel.recognizedDataTyoe,
                    doesRecognizeMultipleItems: viewModel.recognizesMultipleItems)
                .background { Color.gray.opacity(0.3) }
                .ignoresSafeArea()
                .id(viewModel.dataScannerViewId)
                .onChange(of: viewModel.scanType) { _, _ in viewModel.recognizedItems = [] }
                .onChange(of: viewModel.textContentType) { _, _ in viewModel.recognizedItems = [] }
                .onChange(of: viewModel.recognizesMultipleItems) { _, _ in viewModel.recognizedItems = [] }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isPresented = false
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
            }
            .sheet(isPresented: .constant(true)) {
                bottomContainerView
                    .background(.ultraThinMaterial)
                    .presentationDetents([.medium, .fraction(0.25)])
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled()
                    .onAppear {
                        // MARK: - UIKit 'Cheat' to achieve translucent background
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let controller = windowScene.windows.first?.rootViewController?.presentedViewController else { return }
                        controller.view.backgroundColor = .clear
                    }
            }
        }
    }
    
    private var headerView: some View {
        @Bindable var viewModel = viewModel
        return VStack {
            HStack {
                Button {
                    isPresented = false
                } label: {
                    Text("Cancel")
                }
                
                Picker("Scan Type", selection: $viewModel.scanType) {
                    Text("Barcode").tag(ViewModel.ScanType.barcode)
                    Text("Text").tag(ViewModel.ScanType.text)
                }.pickerStyle(.segmented)
                
                Toggle("Multiple Scan", isOn: $viewModel.recognizesMultipleItems)
            }
            .padding(.top)
            
            if viewModel.scanType == .text {
                Picker("Text Content Type", selection: $viewModel.textContentType) {
                    ForEach(textContentTypes, id: \.self.textContentType) { option in
                        Text(option.title).tag(option.1)
                    }
                }
                .pickerStyle(.segmented)
            }
            
            Text(viewModel.headerText)
                .padding(.top)
        }
        .padding(.horizontal)
    }
    
    private var bottomContainerView: some View {
        VStack {
            headerView
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.recognizedItems) { item in
                        switch item {
                        case .barcode(let barcode):
                            Text(barcode.payloadStringValue ?? "Unkown barcode")
                        case .text(let text):
                            Text(text.transcript)
                        default:
                            Text("Unknown")
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    private func startScanning() {
        // TODO: - Start the camera and scan
        didScanningStart = true
        print("Starting Scan...")
    }
    
    
    private func showErrorMessage(_ message: String) {
        
    }
}

//#Preview {
//    CameraView(isPresented: $isPresented)
//        .environment(ViewModel())
//}
