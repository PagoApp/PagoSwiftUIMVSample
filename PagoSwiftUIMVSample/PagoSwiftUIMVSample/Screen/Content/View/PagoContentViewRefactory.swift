//
//  PagoContentViewRefactory.swift
//  PagoSwiftUIMVSample
//
//  Created by Cosmin Iulian on 21.12.2023.
//


import PagoUISDK

// MARK: - PagoContentViewRefactory (internal)

/// A factory enum creating a ``PagoSUIntroView``
@available(iOS 14.0, *)
enum PagoContentViewRefactory {
    
#if DEBUG
    static func createIntroView() -> PagoSUIntroView {
        let mainAction = { print("Main button was pressed!") }
        let secondaryAction = { print("Secondary button was pressed!") }
        let imageData = BackendImage(url: "https://assets.pago.ro/sdk/bcr/bills/img_scan_bill.png", placeholderImageName: "")
        let title = "Avem nevoie de permisiune pentru utilizarea camerei foto"
        let content = "Pentru a putea scana talonul este necesar accesul la camera foto."
        let mainButtonText = "Oferă acces"
        let secondaryButtonText = "Mai târziu"
        let predicate = PagoSUIntroPredicate(
            image: imageData,
            title: title,
            content: content,
            mainButtonText: mainButtonText,
            secondaryButtonText: secondaryButtonText
        )
        return PagoSUIntroView(
            predicate: predicate,
            mainAction: mainAction,
            secondaryAction: secondaryAction
        )
    }
#endif
}
