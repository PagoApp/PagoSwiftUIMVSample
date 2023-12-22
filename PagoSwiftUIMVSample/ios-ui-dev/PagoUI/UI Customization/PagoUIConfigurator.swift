//
//  PagoUICustomization.swift
//  PagoUISDK
//
//  Created by Bogdan Oliniuc on 25.01.2023.
//

import Foundation
import UIKit

public class PagoUIConfigurator {

    public static var hidesBottomBarWhenPushed: Bool?
    
    static var customConfig = PagoUIConfig()
    static var regularFontName: String?
    static var boldFontName: String?

    internal static var datasource: PagoUIExternalDatasourceWrapper?
    
    public static func setup(config jsonConfig: Data) throws {
        
        do {
            customConfig = try JSONDecoder().decode(PagoUIConfig.self, from: jsonConfig)
        } catch {
            throw PagoUIException.invalid("Corrupted PagoStyles.json file. Contact the Pago team.")
        }
    }
    
    public static func setFonts(regularFontName: String, boldFontName: String) {
        self.regularFontName = regularFontName
        self.boldFontName = boldFontName
    }
    
    public static func setup(datasource wrapper: PagoUIExternalDatasourceWrapper) {
        datasource = wrapper
    }

    // TODO: will be refactored with value from BE with PAGO-26611
    public static var integrator: PagoIntegrator {
        let prefix = customConfig.theme.integratorPrefix.trimmingCharacters(in: ["/"])
        return PagoIntegrator(rawValue: prefix) ?? PagoIntegrator.bt
    }
}

public enum PagoIntegrator: String {
    case ap = "ap"
    case bt = "bt"
    case pago = "pago"
    case bcr = "bcr"
}

public class PagoUIExternalDatasourceWrapper {
    
    var lottie: PagoLottieAnimationDataSource
    var sdwebImage: PagoSDWebImageDataSource
    
    public init(lottie: PagoLottieAnimationDataSource, sdwebImage: PagoSDWebImageDataSource) {
        self.lottie = lottie
        self.sdwebImage = sdwebImage
    }
}
