//
//  PrimaryButtonStyle.swift
//  FlowTimer
//
//  Created by Cameron Marlow on 10/11/20.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
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
            .background(Color.blue
                .opacity(
                configuration.isPressed ? 0.5 : 1
            ))
            .cornerRadius(10)
    }
}

