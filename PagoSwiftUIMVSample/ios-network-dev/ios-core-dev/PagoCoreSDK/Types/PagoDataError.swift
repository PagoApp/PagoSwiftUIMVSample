//
//  PagoDataError.swift
//  PagoApiClient
//
//  Created by Gabi on 17.07.2022.
//

import Foundation

public enum PagoDataError: Error {
    case wrongDataFormat(error: Error)
    case missingData(values: [CodingKey])
    case batchDeleteError
    case readError(message: String)
    case insertError(message: String)
    case saveError(message: String)
    case deleteError(message: String)
    case unknown(message: String)
}

extension PagoDataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unknown(let message):
            return NSLocalizedString("Unknown Error. \(message)", comment: "")
        case .insertError(let message):
            return NSLocalizedString("Could not insert the data. \(message)", comment: "")
        case .saveError(let message):
            return NSLocalizedString("Could not save the data. \(message)", comment: "")
        case .deleteError(let message):
            return NSLocalizedString("Could not delete the data. \(message)", comment: "")
        case .wrongDataFormat(let error):
            return NSLocalizedString("Could not digest the fetched data. \(error.localizedDescription)", comment: "")
        case .missingData(let values):
            return NSLocalizedString("Found and will discard a Pago Response missing valid data. \(values.map({$0.stringValue}))", comment: "")
        case .batchDeleteError:
            return NSLocalizedString("Failed to execute a batch delete request.", comment: "")
        case .readError(message: let message):
            return NSLocalizedString("Could not read the data. \(message)", comment: "")
        }
    }
}

extension PagoDataError: Identifiable {
    public var id: String? {
        errorDescription
    }
}
