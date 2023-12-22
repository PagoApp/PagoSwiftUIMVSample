//
//  PagoOnboardingViewRefactory.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 21.12.2023.
//

import PagoUISDK

// MARK: - PagoOnboardingViewRefactory (internal)

/// A factory enum creating a ``PagoOnboardingView``
enum PagoOnboardingViewRefactory {
    
#if DEBUG
    static func createPreview() -> PagoOnboardingView {
        let onDimiss: (PagoOnboardingView.Action) -> () = {_ in}
        return PagoOnboardingView(onDimiss: onDimiss)
    }
#endif
}
