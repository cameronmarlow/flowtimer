//
//  ContentView.swift
//  FlowTimer
//
//  Created by Cameron Marlow on 10/10/20.
//

import SwiftUI

struct ContentView: View {
    
    var timer = TimerStore()
    @State private var minutes = 5
    @State private var seconds = 0

    @State private var selectedFlowScale = FlowScale.normal
    @State private var timerLength = 0
    
    private let maxTimerLength = 60
    
    func startTimer() {
        print("Updating Timer")
        timer.timerDuration = TimeInterval(self.minutes * 60 + self.seconds)
        timer.flowScale = self.selectedFlowScale
        timer.start()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Time")) {
                    Picker("Minutes", selection: $minutes) {
                        ForEach(0..<60) {
                            Text("\($0)").tag(Int($0))
                        }
                    }
                    Picker("Seconds", selection: $seconds) {
                        ForEach(0..<60) {
                            Text("\($0)").tag(Int($0))
                        }
                    }
                }
                Section(header: Text("Flow Level")) {
                    Picker("Activity", selection: $selectedFlowScale) {
                        ForEach(FlowScale.allCases, id: \.self) { level in
                            Text(String(describing: level).capitalized(with: .current))
                                .tag(level)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                NavigationLink(destination: TimerView().onAppear(perform: self.startTimer)) {
                    Text("Start Timer")
                }
            }
            .navigationBarTitle("Flow Timer")
        }
        .environmentObject(timer)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
