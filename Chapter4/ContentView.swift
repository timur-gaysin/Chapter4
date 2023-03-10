//
//  ContentView.swift
//  Chapter4
//
//  Created by Timur on 05.03.2023.
//

import SwiftUI

struct ContentView: View {
    @State var message = ""
    @State var results = ""
    @State var sliderValue = 0.0
    var body: some View {
        VStack {
            HStack{
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
                Spacer()
                Button("Dispatch Groups"){
                    let startTime = NSDate()
                    let queue = DispatchQueue.global(qos: .default)
                    queue.async {
                        let fetchedData = fetchSomethingFromServer()
                        let processedData = processData(fetchedData)
                        var firstResult : String!
                        var secondResult: String!
                        let group = DispatchGroup()
                        queue.async (group: group) {
                            firstResult =  calculateFirstResult(processedData)
                        }
                        queue.async (group: group) {
                            secondResult = calculateSecondResult(processedData)
                        }
                        group.notify(queue: queue){
                            let resultsSummary = "First: [\(firstResult)]\nSecond: [\(secondResult)]"
                            results = resultsSummary
                            let endTime = NSDate()
                            message = "Completed in \(endTime.timeIntervalSince(startTime as Date)) seconds"
                        }
                    }
                }
            }
            TextEditor(text: $results)
            Slider(value: $sliderValue)
            Text("Message = \(message)")
        }
    }
}

func fetchSomethingFromServer() -> String {
    Thread.sleep(forTimeInterval: 1)
    return "Hi there"
}

func processData(_ data: String) -> String {
    Thread.sleep(forTimeInterval: 2)
    return data.uppercased()
}

func calculateFirstResult(_ data: String) -> String {
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
        ContentView()
    }
}
