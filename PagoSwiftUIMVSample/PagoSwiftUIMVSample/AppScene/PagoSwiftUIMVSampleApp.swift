//
//  PagoSwiftUIMVSampleApp.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 20.12.2023.
//

import SwiftUI

@main
struct PagoSwiftUIMVSampleApp: App {
    var body: some Scene {
        WindowGroup {
            PagoContentView()
                .environmentObject(PagoModelData())
        }
    }
}
