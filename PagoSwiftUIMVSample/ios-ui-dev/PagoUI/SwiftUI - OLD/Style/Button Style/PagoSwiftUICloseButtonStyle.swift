//
//  CloseButtonStyle.swift
//  PagoUI
//
//  Created by Cosmin Iulian on 23.06.2023.
//

import SwiftUI

@available(iOS 15.0, *)
internal struct PagoSwiftUICloseButtonStyle: ButtonStyle {
    
    internal func makeBody(configuration: Configuration) -> some View {
        
        configuration.label
        Image(systemName: "xmark")
            .resizable()
            .foregroundStyle(.gray)
            .frame(width: 18, height: 18)
            .padding(.horizontal, 20)
    }
}
