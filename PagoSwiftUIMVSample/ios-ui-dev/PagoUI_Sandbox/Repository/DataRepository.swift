//
//  DataRepository.swift
//  PagoUI_Sandbox
//
//  Created by LoredanaBenedic on 05.01.2023.
//

import Foundation
import PagoUISDK

public class DataRepository {
	
	static let shared: DataRepository = DataRepository()
	
	lazy var stylesConfigFileUrl: URL? = {
		let bundle = Bundle(for: type(of: self))
		if let path = bundle.path(forResource: "PagoStyles", ofType: "json") {
			let fileUrl = URL(fileURLWithPath: path)
			return fileUrl
		}
		return nil
	}()
	
	public static func setupUI() throws {
		
		guard let fileUrl = shared.stylesConfigFileUrl else {
			print("Missing Pago styles config file")
			throw IntegratorError.missingConfigFile
		}
		
		do {
			let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
			let config = IntegratorConfig(config: data) as PagoJSONConfig
			try PagoUIConfigurator.setup(config: config.config)
		} catch(let exception) {
			print(exception)
			throw IntegratorError.unexpectedError(error: exception)
		}
	}


}
