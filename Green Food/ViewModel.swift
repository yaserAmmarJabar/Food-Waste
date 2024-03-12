//
//  ViewModel.swift
//  Green Food
//
//  Created by Yaser Aljaf on 11/01/2024.
//

import AVKit
import Foundation
import Observation
import VisionKit

@Observable
class ViewModel {
    var dataScannerAccessStatus = DataScannerAccessStatus.notDetermined
    var recognizedItems: [RecognizedItem] = []
    var scanType:ScanType = .barcode
    var textContentType: DataScannerViewController.TextContentType? /* UITextContentType */
    var recognizesMultipleItems = true
    
    var recognizedDataTyoe: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    var headerText: String {
        if recognizedItems.isEmpty {
            return "Scanning \(scanType.rawValue)"
        } else {
            return "Recognized \(recognizedItems.count) item(s)"
        }
    }
    
    var dataScannerViewId: Int {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognizesMultipleItems)
        if let textContentType {
            hasher.combine(textContentType)
        }
        return hasher.finalize()
    }
    
    @MainActor
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    @MainActor
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .camreaUnavailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerUnvailable
        case .restricted, .denied: dataScannerAccessStatus = .cameraAccessNotGranted
        case .notDetermined:
            // request access
            let isGranted = await AVCaptureDevice.requestAccess(for: .video)
            if isGranted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerUnvailable
            } else {
                dataScannerAccessStatus = .cameraAccessNotGranted
            }
        default: break

        }
        
    }
    
    // MARK: - Data Scanner State Machine
    enum DataScannerAccessStatus {
        case notDetermined
        case cameraAccessNotGranted
        case camreaUnavailable
        case scannerAvailable
        case scannerUnvailable
    }

    // MARK: - Supported Scan Types
    enum ScanType: String {
        case text, barcode
    }
}
