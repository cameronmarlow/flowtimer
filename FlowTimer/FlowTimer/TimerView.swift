//
//  TimerView.swift
//  FlowTimer
//
//  Created by Cameron Marlow on 10/12/20.
//

import SwiftUI
import AVFoundation

struct TimerButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .frame(
                minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                idealWidth: 400,
                maxWidth: .infinity,
                minHeight: 40
            )
            .font(Font.body.bold())
            .padding(10)
            .padding(.horizontal, 20)
            .background(self.color
                .opacity(
                    configuration.isPressed ? 0.5 : 0.75
            ))
            .cornerRadius(10)
    }
}


struct TimerView: View {
    @EnvironmentObject var timer: TimerStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    let uiTimer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    var timerFont = Font.largeTitle
        
    var body: some View {
        VStack {
            
            Spacer()
            
            Text(timer.remainingDuration)
                .font(timerFont.monospacedDigit())

            Spacer()
            
            if (timer.isRunning) {
                Button("Pause") {
                    timer.pause()
                }
                .buttonStyle(TimerButtonStyle(color: Color.orange))
            } else {
                HStack {
                    if (timer.remainingTime ?? 0 > 0) {
                        Button("Resume") {
                            timer.start()
                        }
                        .buttonStyle(TimerButtonStyle(color: Color.green))
                    }
                    Button("Cancel") {
                        timer.stop()
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    .buttonStyle(TimerButtonStyle(color: Color.gray))
                }
            }
        }
        .padding()
        .onReceive(uiTimer) { input in
            if timer.isRunning {
                timer.updateRunningTime()
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
