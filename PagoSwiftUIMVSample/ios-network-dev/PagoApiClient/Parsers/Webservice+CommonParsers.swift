//
//  Webservice+CommonParsers.swift
//  PagoApiClient
//
//  Created by Mihai Arosoaie on 10/12/2017.
//  Copyright © 2017 cleversoft. All rights reserved.
//

import Foundation
import UIKit

extension PagoWebservice {
    
    #warning("Must test once we have the car response")
    public func parse<T: Codable>(_ data: Data) -> PagoApiClientResult<T> {
    
        do {
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedResponse)
        } catch(let error) {
//            print(error)
            return .failure(self.getError(data))
        }
    }

    public func parseVoidResult(data: Data) -> PagoApiClientResult<()> {
        return .success(())
    }

    public func parseData(data: Data) -> PagoApiClientResult<Data> {
        if let dict = JSONObjectFromData(data), dict["error"] != nil {
            return .failure(self.getError(data, path: ""))
        }
        return .success(data)
    }

//    func parseDTOArray<T: ImmutableMappable>(_ data: Data) -> Result<[T]> {
//        guard let array = PagoApiClient.shared.webservice.JSONArrayFromData(data) as? [[String: Any]],
//            let dtos = (array.failingFlatMap { (json) -> T? in
//                do {
//                    let map = Map(mappingType: .fromJSON, JSON: json)
//                    return try T(map: map)
//                } catch let error {
//                    LogManager.shared.log(error)
//                    return nil
//                }
//            }) else {
//                return .failure(self.getError(data))
//        }
//        return .success(dtos)
//    }
//
//    public func parseDTOArrayWithoutFailingAllItems<T: ImmutableMappable>(_ data: Data) -> Result<[T]> {
//        guard let array = PagoApiClient.shared.webservice.JSONArrayFromData(data) as? [[String: Any]] else {
//            return .failure(self.getError(data))
//        }
//        var mError : Error?
//        let dtos = array.compactMap { (json) -> T? in
//            do {
//                let map = Map(mappingType: .fromJSON, JSON: json)
//                return try T(map: map)
//            } catch let error {
//                mError = error
//                return nil
//            }
//        }
//        if let mError = mError {
//            LogManager.shared.log(mError)
//        }
//        return .success(dtos)
//    }
//
//    public func parseToDTO<DTO: ImmutableMappable>(data: Data) -> Result<DTO> {
//        do {
//            guard let json = PagoApiClient.shared.webservice.JSONObjectFromData(data) else {
//                return .failure(PagoError.parseError(message: "Could not parse data to json", rawText: String(data: data, encoding: self.encoding)))
//            }
//            let response = try DTO(JSON: json)
//            return .success(response)
//        } catch let error {
//            return .failure(error)
//        }
//    }
//
//    func parseDictionaryResult(data: Data) -> Result<[String: Any]> {
//        guard let json = PagoApiClient.shared.webservice.JSONObjectFromData(data) else {
//            return .failure(PagoError.parseError(message: "Could not parse data to json", rawText: String(data: data, encoding: self.encoding)))
//        }
//
//        return .success(json)
//    }
//
//    func parseVoidResult(data: Data) -> Result<()> {
////        if let s = String(data: data, encoding: .utf8), s.count > 0 {
////            return .failure(PagoError.parseError(message: s, rawText: s))
////        }
//        return .success(())
//    }
//
//    //should only be used when the backend returns bogus text as a result
//    func parseWhateverResult(data: Data) -> Result<()> {
//        return .success(())
//    }
//
//    func parseBool(data: Data) -> Result<Bool> {
//        if let s = String(data: data, encoding: .utf8) {
//            if s == "true" {
//                return .success(true)
//            } else if s == "false" {
//                return .success(false)
//            } else {
//                return .failure(PagoError.parseError(message: s, rawText: s))
//            }
//        } else {
//            return .failure(PagoError.parseError(message: "Cannot decode using .utf8", rawText: nil))
//        }
//    }
//
//    func parseImage(data: Data) -> Result<UIImage> {
//        if let image = UIImage(data: data) {
//                return .success(image)
//        }
//        return .failure(self.getError(data, path: ""))
//    }
//
//    func parseString(data: Data) -> Result<String> {
//        if let s = String(data: data, encoding: .utf8) {
//            return .success(s)
//        } else {
//            return .failure(PagoError.parseError(message: "Cannot decode using .utf8", rawText: nil))
//
//        }
//    }
//
//    func parseInts(data: Data) -> Result<[Int64]> {
//        guard let result = (try? JSONSerialization.jsonObject(with: data, options:[])) as? [Int64] else {
//            return .failure(PagoError.parseError(message: "Cannot decode int array", rawText: nil))
//        }
//        return .success(result)
//    }


}
