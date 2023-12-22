//
//  File.swift
//
//
//  Created by Gabi on 18.07.2022.
//

import Foundation

enum IntegratorError: Error {
	case missingConfigFile
	case unexpectedError(error: Error)
}

extension IntegratorError: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .missingConfigFile:
			return NSLocalizedString("Pago json config file is missing. The config file is mandatory", comment: "")
		case .unexpectedError(let error):
			return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
		}
	}
}
