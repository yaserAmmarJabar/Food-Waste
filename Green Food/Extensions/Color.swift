//
//  Color.swift
//  Green Food
//
//  Created by Yaser Aljaf on 18/03/2024.
//

import SwiftUI

extension Color {
    func makeLighter() -> Color {
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        // MARK: - Useless! ------ Increase brightness by 10%
        brightness += 0.1
        brightness = min(brightness, 1.0) // Ensure it doesn't exceed the maximum
        
        return Color(UIColor(hue: hue, saturation: saturation, brightness: 0.15, alpha: alpha))
    }
    
    func makeDarker() -> Color {
        let uiColor = UIColor(self)
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        uiColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        // MARK: - Useless! ------ Decrease brightness by 10%
        brightness -= 0.1
        brightness = max(brightness, 0.0) // Ensure it doesn't go below the minimum
        
        return Color(UIColor(hue: hue, saturation: saturation, brightness: 0.9, alpha: alpha))
    }
}
