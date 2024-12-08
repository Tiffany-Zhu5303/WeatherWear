//
//  WeatherChartView.swift
//  WeatherWear
//
//  Created by Tiffany Zhu on 12/7/24.
//

import SwiftUI
import Charts

struct WeatherChartView: View {
  @State private var selectedDate: String?
  @Binding var weatherData: [String: [String:Int]]
  
  func sortTimes(times: [String]) -> [String] {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "HH:mm"
      
      return times.sorted { time1, time2 in
          guard let date1 = dateFormatter.date(from: time1),
                let date2 = dateFormatter.date(from: time2) else {
              return false
          }
          return date1 < date2
      }
  }
  
  var body: some View {
    VStack {
      Picker("Select a Date", selection: $selectedDate) {
        Text("Choose a Date").tag(nil as String?)
        ForEach(Array(weatherData.keys).sorted(), id: \.self) { date in
          Text(date).tag(date as String?)
        }
      }
      .pickerStyle(MenuPickerStyle())
      .onChange(of: weatherData) {
        selectedDate = nil
      }
      
      if let selectedDate, let times = weatherData[selectedDate] {
        let sortedTimes = sortTimes(times: Array(times.keys))
        let temperatures = times.values
        let minTemperature = temperatures.min() ?? 0
        let maxTemperature = temperatures.max() ?? 100

        Chart {
          ForEach(Array(sortedTimes), id: \.self) { time in
            if let temperature = times[time]{
              LineMark(
                x: .value("Time", time),
                y: .value("Temperature", temperature)
              )
              .foregroundStyle(Color("Moonstone"))
              .symbol(.circle)
              .interpolationMethod(.catmullRom)
            }
          }
        }
        .chartXAxis {
          AxisMarks { value in
              if let stringValue = value.as(String.self) {
                AxisValueLabel(stringValue, orientation: .verticalReversed)
              }
          }
        }
        .chartYScale(domain: minTemperature-10...maxTemperature+10)
        .padding(.all, 20)
      } else{
        Text("Please select a date to view the weather.")
          .foregroundStyle(Color.gray)
      }
    }
  }
}

#Preview {
  WeatherChartView(weatherData: .constant([:]))
}
