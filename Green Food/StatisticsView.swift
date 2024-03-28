//
//  StatisticsView.swift
//  Green Food
//
//  Created by Yaser Aljaf on 11/03/2024.
//

import SwiftUI
import Charts

struct StatisticsView: View {
    @Environment(\.colorScheme) var colorScheme // Get the current color scheme
    
    @State var timeSpentData = [
        TimeSpent(day: "Su", hours: 18, category: "Ahmed"),
        TimeSpent(day: "Mo", hours: 4, category: "Ahmed"),
        TimeSpent(day: "Tu", hours: 9, category: "Waleed"),
        TimeSpent(day: "We", hours: 8, category: "Ahmed"),
        TimeSpent(day: "Th", hours: 5, category: "Waleed"),
        TimeSpent(day: "Fr", hours: 8, category: "Ahmed"),
        TimeSpent(day: "Sa", hours: 13, category: "Waleed")
    ]
    
    @State var tasksCompleted = 4
    @State var totalTasks = 20
    
    var body: some View {
        NavigationStack {
            VStack {
                weeklyGoal
                // update
                barChart
                    .navigationTitle("Summary")
            }
        }
    }
    
    private var weeklyGoal: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Weekly Goal")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("Monday")
                    .font(.subheadline)
            }
            .padding(.bottom)
            
            VStack(alignment: .leading) {
                Text("Goal Progress")
                    .font(.headline)
                
                ProgressView(value: Float(tasksCompleted), total: Float(totalTasks))
                    .progressViewStyle(LinearProgressViewStyle(tint: UIConstants.accentColor))
                
                Text("\(tasksCompleted)/\(totalTasks) tasks completed")
                    .font(.subheadline)

            }
            .padding(.vertical)
            
            
            HStack {
                Button(action: {
                    // Action for Show Completed
                }) {
                    Text("Show Status")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(UIConstants.accentColor)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // Action for Edit Goal
                }) {
                    Text("Edit Goal")
                        .fontWeight(.semibold)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .cornerRadius(10)
                }
            }
        }
        .padding()
        .background(adaptiveBackgroundColor)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(15)

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
                "Ahmed": .blue,
                "Waleed": .green
            ])
            .chartYAxis {
                AxisMarks(position: .leading)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .padding()
    }
    
    private var adaptiveBackgroundColor: Color {
        let baseColor = Color(UIColor.systemBackground)
        
        return (colorScheme == .dark)
                    ? baseColor.makeLighter() // Slightly brighter for dark mode
                    : baseColor.makeDarker() // Slightly darker for light mode
    }
    
    struct UIConstants {
        static let accentColor = Color.green
    }
}


// Example data model
struct TimeSpent: Identifiable {
    let id = UUID()
    let day: String
    let hours: Double
    let category: String
}

// Additional struct definitions for styles and any custom modifiers would go here


#Preview {
    StatisticsView()
}
