//
//  StatisticsView.swift
//  Green Food
//
//  Created by Yaser Aljaf on 11/03/2024.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    var body: some View {
        NavigationStack {
            VStack {
//                VStack {
//                    Text("Monthly Goal")
//                }
//                .frame(maxWidth: .infinity, alignment: .top)
//                .background(Color.gray)
//                .padding()
                
                barChart
                    .navigationTitle("Summary")
            }
        }
    }
    
    private var barChart: some View {
        VStack {
            // Use Chart to create a bar chart
            Chart {
                ForEach(timeSpentData) { data in
                    // Create bars using BarMark
                    BarMark(
                        x: .value("Day", data.day),
                        y: .value("Hours", data.hours)
                    )
                    .foregroundStyle(by: .value("Category", data.category))
                }
            }
            .frame(height: 250)
            .chartForegroundStyleScale([
                "Work": .blue,
                "Rest": .green
            ])
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
}

// Example data model
struct TimeSpent: Identifiable {
    let id = UUID()
    let day: String
    let hours: Double
    let category: String
}

// Sample data
let timeSpentData = [
    TimeSpent(day: "Su", hours: 2, category: "Work"),
    TimeSpent(day: "Mo", hours: 3, category: "Work"),
    TimeSpent(day: "Tu", hours: 4, category: "Rest"),
    TimeSpent(day: "We", hours: 5, category: "Work"),
    TimeSpent(day: "Th", hours: 6, category: "Rest"),
    TimeSpent(day: "Fr", hours: 7, category: "Work"),
    TimeSpent(day: "Sa", hours: 8, category: "Rest")
]
// Additional struct definitions for styles and any custom modifiers would go here


#Preview {
    StatisticsView()
}
