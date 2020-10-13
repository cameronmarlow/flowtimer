//
//  TimerStore.swift
//  FlowTimer
//
//  Created by Cameron Marlow on 10/11/20.
//

import Foundation
import AudioToolbox

enum FlowScale: Double, CaseIterable {
    case fun = 0.5
    case normal = 1.0
    case boring = 1.5
}

class TimerStore : ObservableObject {
    @Published var timerDuration: TimeInterval
    @Published var flowScale: FlowScale
    @Published var remainingTime: TimeInterval?
    @Published var startTime: Date?
    
    let systemSoundID: SystemSoundID = 1335

    
    init() {
        self.timerDuration = TimeInterval(0.0)
        self.flowScale = FlowScale.normal
        self.startTime = nil
        self.remainingTime = nil
    }
    
    var isRunning: Bool {
        return self.startTime != nil
    }
    
    var remainingDuration: String {
        if let remainder = self.remainingTime {
            let ms = Int(remainder.truncatingRemainder(dividingBy: 1) * 100)
            let formatter = DateComponentsFormatter()
            formatter.allowedUnits = [.minute, .second]
            formatter.zeroFormattingBehavior = .pad
            return formatter.string(from: remainder)! + String(format: ".%02d", ms)
        } else {
            return "00:00.0"
        }
    }
    
    func start() {
        if (self.remainingTime == nil) {
            self.remainingTime = self.timerDuration
        }
        self.startTime = Date()
    }
    
    func updateRunningTime() {
        if self.isRunning {
            let newTime = Date()
            let diff = newTime.timeIntervalSince(self.startTime!)
            let scaledDiff = diff * self.flowScale.rawValue
            self.remainingTime = self.remainingTime! - scaledDiff
            self.startTime = newTime
        }
        if let remainingTime = self.remainingTime {
            if remainingTime <= 0 {
                self.startTime = nil
                self.remainingTime = TimeInterval(0.0)
                AudioServicesPlaySystemSound(self.systemSoundID)
            }
        }
    }
    
    func pause() {
        self.updateRunningTime()
        self.startTime = nil
    }
    
    func stop() {
        self.startTime = nil
        self.remainingTime = nil
    }
}
