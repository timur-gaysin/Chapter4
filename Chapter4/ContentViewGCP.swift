//
//  ContentView.swift
//  Chapter4
//
//  Created by Timur on 05.03.2023.
//

import SwiftUI

struct ContentViewGCP: View {
    @State var message = ""
    @State var results = ""
    @State var sliderValue = 0.0
    var body: some View {
        VStack {
            Button("Click me"){
                let startTime = NSDate()
                let queue = DispatchQueue.global(qos: .default)
                queue.async {
                    let fetchedData = fetchSomethingFromServer()
                    let processedData = processData(fetchedData)
                    let firstResult =  calculateFirstResult(processedData)
                    let secondResult = calculateSecondResult(processedData)
                    let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
                    results = resultsSummary
                    let endTime = NSDate()
                    message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds"
                }
                
            }
            TextEditor(text: $results)
            Slider(value: $sliderValue)
            Text("Message = \(message)")
        }
    }
}

private func fetchSomethingFromServer() -> String {
    Thread.sleep(forTimeInterval: 1)
    return "Hi there"
}

private func processData(_ data: String) -> String {
    Thread.sleep(forTimeInterval: 2)
    return data.uppercased()
}

private func calculateFirstResult(_ data: String) -> String {
    Thread.sleep(forTimeInterval: 3)
    let message = "Number of chars: \(String(data).count)"
    return message
}

func calculateSecondResult(_ data: String) -> String {
    Thread.sleep(forTimeInterval: 4)
    return data.replacingOccurrences(of: "E", with: "e")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewGCP()
    }
}
