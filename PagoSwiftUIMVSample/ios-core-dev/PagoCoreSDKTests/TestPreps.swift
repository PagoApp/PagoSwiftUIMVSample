//
//  TestPreps.swift
//  PagoCoreSDKTests
//
//  Created by Gabi on 30.05.2022.
//

import Foundation
@testable import PagoCoreSDK

struct IntegratorPagoConfig: PagoJSONConfig {
    var config: Data
}

class IntegratorDataSource: PagoTokenDataSource {
    func getNewToken(completion: (PagoOperationStatus<PagoToken>) -> ()) {
    }
}
