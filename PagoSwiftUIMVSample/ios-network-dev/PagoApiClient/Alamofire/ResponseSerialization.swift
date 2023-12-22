//
//  ResponseSerialization.swift
//
//  Copyright (c) 2014-2018 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

/// The type in which all data response serializers must conform to in order to serialize a response.
public protocol PagoDataResponseSerializerProtocol {
    /// The type of serialized object to be created by this `DataResponseSerializerType`.
    associatedtype SerializedObject

    /// A closure used by response handlers that takes a request, response, data and error and returns a result.
    var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> PagoApiClientResult<SerializedObject> { get }
}

// MARK: -

/// A generic `DataResponseSerializerType` used to serialize a request, response, and data into a serialized object.
public struct PagoDataResponseSerializer<Value>: PagoDataResponseSerializerProtocol {
    /// The type of serialized object to be created by this `DataResponseSerializer`.
    public typealias SerializedObject = Value

    /// A closure used by response handlers that takes a request, response, data and error and returns a result.
    public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> PagoApiClientResult<Value>

    /// Initializes the `ResponseSerializer` instance with the given serialize response closure.
    ///
    /// - parameter serializeResponse: The closure used to serialize the response.
    ///
    /// - returns: The new generic response serializer instance.
    public init(serializeResponse: @escaping (URLRequest?, HTTPURLResponse?, Data?, Error?) -> PagoApiClientResult<Value>) {
        self.serializeResponse = serializeResponse
    }
}

// MARK: -

/// The type in which all download response serializers must conform to in order to serialize a response.
public protocol PagoDownloadResponseSerializerProtocol {
    /// The type of serialized object to be created by this `DownloadResponseSerializerType`.
    associatedtype SerializedObject

    /// A closure used by response handlers that takes a request, response, url and error and returns a result.
    var serializeResponse: (URLRequest?, HTTPURLResponse?, URL?, Error?) -> PagoApiClientResult<SerializedObject> { get }
}

// MARK: -

/// A generic `DownloadResponseSerializerType` used to serialize a request, response, and data into a serialized object.
public struct PagoDownloadResponseSerializer<Value>: PagoDownloadResponseSerializerProtocol {
    /// The type of serialized object to be created by this `DownloadResponseSerializer`.
    public typealias SerializedObject = Value

    /// A closure used by response handlers that takes a request, response, url and error and returns a result.
    public var serializeResponse: (URLRequest?, HTTPURLResponse?, URL?, Error?) -> PagoApiClientResult<Value>

    /// Initializes the `ResponseSerializer` instance with the given serialize response closure.
    ///
    /// - parameter serializeResponse: The closure used to serialize the response.
    ///
    /// - returns: The new generic response serializer instance.
    public init(serializeResponse: @escaping (URLRequest?, HTTPURLResponse?, URL?, Error?) -> PagoApiClientResult<Value>) {
        self.serializeResponse = serializeResponse
    }
}

// MARK: - Timeline

extension PagoRequest {
    var timeline: PagoTimeline {
        let requestStartTime = self.startTime ?? CFAbsoluteTimeGetCurrent()
        let requestCompletedTime = self.endTime ?? CFAbsoluteTimeGetCurrent()
        let initialResponseTime = self.delegate.initialResponseTime ?? requestCompletedTime

        return PagoTimeline(
            requestStartTime: requestStartTime,
            initialResponseTime: initialResponseTime,
            requestCompletedTime: requestCompletedTime,
            serializationCompletedTime: CFAbsoluteTimeGetCurrent()
        )
    }
}

// MARK: - Default

extension PagoDataRequest {
    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter queue:             The queue on which the completion handler is dispatched.
    /// - parameter completionHandler: The code to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func response(queue: DispatchQueue? = nil, completionHandler: @escaping (PagoDefaultDataResponse) -> Void) -> Self {
        delegate.queue.addOperation {
            (queue ?? DispatchQueue.main).async {
                var dataResponse = PagoDefaultDataResponse(
                    request: self.request,
                    response: self.response,
                    data: self.delegate.data,
                    error: self.delegate.error,
                    timeline: self.timeline
                )

                dataResponse.add(self.delegate.metrics)

                completionHandler(dataResponse)
            }
        }

        return self
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter queue:              The queue on which the completion handler is dispatched.
    /// - parameter responseSerializer: The response serializer responsible for serializing the request, response,
    ///                                 and data.
    /// - parameter completionHandler:  The code to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func response<T: PagoDataResponseSerializerProtocol>(
        queue: DispatchQueue? = nil,
        responseSerializer: T,
        completionHandler: @escaping (PagoDataResponse<T.SerializedObject>) -> Void)
        -> Self
    {
        delegate.queue.addOperation {
            let result = responseSerializer.serializeResponse(
                self.request,
                self.response,
                self.delegate.data,
                self.delegate.error
            )

            var dataResponse = PagoDataResponse<T.SerializedObject>(
                request: self.request,
                response: self.response,
                data: self.delegate.data,
                result: result,
                timeline: self.timeline
            )

            dataResponse.add(self.delegate.metrics)

            (queue ?? DispatchQueue.main).async { completionHandler(dataResponse) }
        }

        return self
    }
}

extension PagoDownloadRequest {
    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter queue:             The queue on which the completion handler is dispatched.
    /// - parameter completionHandler: The code to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func response(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (PagoDefaultDownloadResponse) -> Void)
        -> Self
    {
        delegate.queue.addOperation {
            (queue ?? DispatchQueue.main).async {
                var downloadResponse = PagoDefaultDownloadResponse(
                    request: self.request,
                    response: self.response,
                    temporaryURL: self.downloadDelegate.temporaryURL,
                    destinationURL: self.downloadDelegate.destinationURL,
                    resumeData: self.downloadDelegate.resumeData,
                    error: self.downloadDelegate.error,
                    timeline: self.timeline
                )

                downloadResponse.add(self.delegate.metrics)

                completionHandler(downloadResponse)
            }
        }

        return self
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter queue:              The queue on which the completion handler is dispatched.
    /// - parameter responseSerializer: The response serializer responsible for serializing the request, response,
    ///                                 and data contained in the destination url.
    /// - parameter completionHandler:  The code to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func response<T: PagoDownloadResponseSerializerProtocol>(
        queue: DispatchQueue? = nil,
        responseSerializer: T,
        completionHandler: @escaping (PagoDownloadResponse<T.SerializedObject>) -> Void)
        -> Self
    {
        delegate.queue.addOperation {
            let result = responseSerializer.serializeResponse(
                self.request,
                self.response,
                self.downloadDelegate.fileURL,
                self.downloadDelegate.error
            )

            var downloadResponse = PagoDownloadResponse<T.SerializedObject>(
                request: self.request,
                response: self.response,
                temporaryURL: self.downloadDelegate.temporaryURL,
                destinationURL: self.downloadDelegate.destinationURL,
                resumeData: self.downloadDelegate.resumeData,
                result: result,
                timeline: self.timeline
            )

            downloadResponse.add(self.delegate.metrics)

            (queue ?? DispatchQueue.main).async { completionHandler(downloadResponse) }
        }

        return self
    }
}

// MARK: - Data

extension PagoRequest {
    /// Returns a result data type that contains the response data as-is.
    ///
    /// - parameter response: The response from the server.
    /// - parameter data:     The data returned from the server.
    /// - parameter error:    The error already encountered if it exists.
    ///
    /// - returns: The result data type.
    public static func serializeResponseData(response: HTTPURLResponse?, data: Data?, error: Error?) -> PagoApiClientResult<Data> {
        guard error == nil else { return .failure(error!) }

        if let response = response, emptyDataStatusCodes.contains(response.statusCode) { return .success(Data()) }

        guard let validData = data else {
            return .failure(PagoAFError.responseSerializationFailed(reason: .inputDataNil))
        }

        return .success(validData)
    }
}

extension PagoDataRequest {
    /// Creates a response serializer that returns the associated data as-is.
    ///
    /// - returns: A data response serializer.
    public static func dataResponseSerializer() -> PagoDataResponseSerializer<Data> {
        return PagoDataResponseSerializer { _, response, data, error in
            return PagoRequest.serializeResponseData(response: response, data: data, error: error)
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter completionHandler: The code to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseData(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (PagoDataResponse<Data>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDataRequest.dataResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}

extension PagoDownloadRequest {
    /// Creates a response serializer that returns the associated data as-is.
    ///
    /// - returns: A data response serializer.
    public static func dataResponseSerializer() -> PagoDownloadResponseSerializer<Data> {
        return PagoDownloadResponseSerializer { _, response, fileURL, error in
            guard error == nil else { return .failure(error!) }

            guard let fileURL = fileURL else {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileNil))
            }

            do {
                let data = try Data(contentsOf: fileURL)
                return PagoRequest.serializeResponseData(response: response, data: data, error: error)
            } catch {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileReadFailed(at: fileURL)))
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter completionHandler: The code to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseData(
        queue: DispatchQueue? = nil,
        completionHandler: @escaping (PagoDownloadResponse<Data>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDownloadRequest.dataResponseSerializer(),
            completionHandler: completionHandler
        )
    }
}

// MARK: - String

extension PagoRequest {
    /// Returns a result string type initialized from the response data with the specified string encoding.
    ///
    /// - parameter encoding: The string encoding. If `nil`, the string encoding will be determined from the server
    ///                       response, falling back to the default HTTP default character set, ISO-8859-1.
    /// - parameter response: The response from the server.
    /// - parameter data:     The data returned from the server.
    /// - parameter error:    The error already encountered if it exists.
    ///
    /// - returns: The result data type.
    public static func serializeResponseString(
        encoding: String.Encoding?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
        -> PagoApiClientResult<String>
    {
        guard error == nil else { return .failure(error!) }

        if let response = response, emptyDataStatusCodes.contains(response.statusCode) { return .success("") }

        guard let validData = data else {
            return .failure(PagoAFError.responseSerializationFailed(reason: .inputDataNil))
        }

        var convertedEncoding = encoding

        if let encodingName = response?.textEncodingName as CFString?, convertedEncoding == nil {
            convertedEncoding = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(
                CFStringConvertIANACharSetNameToEncoding(encodingName))
            )
        }

        let actualEncoding = convertedEncoding ?? .isoLatin1

        if let string = String(data: validData, encoding: actualEncoding) {
            return .success(string)
        } else {
            return .failure(PagoAFError.responseSerializationFailed(reason: .stringSerializationFailed(encoding: actualEncoding)))
        }
    }
}

extension PagoDataRequest {
    /// Creates a response serializer that returns a result string type initialized from the response data with
    /// the specified string encoding.
    ///
    /// - parameter encoding: The string encoding. If `nil`, the string encoding will be determined from the server
    ///                       response, falling back to the default HTTP default character set, ISO-8859-1.
    ///
    /// - returns: A string response serializer.
    public static func stringResponseSerializer(encoding: String.Encoding? = nil) -> PagoDataResponseSerializer<String> {
        return PagoDataResponseSerializer { _, response, data, error in
            return PagoRequest.serializeResponseString(encoding: encoding, response: response, data: data, error: error)
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter encoding:          The string encoding. If `nil`, the string encoding will be determined from the
    ///                                server response, falling back to the default HTTP default character set,
    ///                                ISO-8859-1.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseString(
        queue: DispatchQueue? = nil,
        encoding: String.Encoding? = nil,
        completionHandler: @escaping (PagoDataResponse<String>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDataRequest.stringResponseSerializer(encoding: encoding),
            completionHandler: completionHandler
        )
    }
}

extension PagoDownloadRequest {
    /// Creates a response serializer that returns a result string type initialized from the response data with
    /// the specified string encoding.
    ///
    /// - parameter encoding: The string encoding. If `nil`, the string encoding will be determined from the server
    ///                       response, falling back to the default HTTP default character set, ISO-8859-1.
    ///
    /// - returns: A string response serializer.
    public static func stringResponseSerializer(encoding: String.Encoding? = nil) -> PagoDownloadResponseSerializer<String> {
        return PagoDownloadResponseSerializer { _, response, fileURL, error in
            guard error == nil else { return .failure(error!) }

            guard let fileURL = fileURL else {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileNil))
            }

            do {
                let data = try Data(contentsOf: fileURL)
                return PagoRequest.serializeResponseString(encoding: encoding, response: response, data: data, error: error)
            } catch {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileReadFailed(at: fileURL)))
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter encoding:          The string encoding. If `nil`, the string encoding will be determined from the
    ///                                server response, falling back to the default HTTP default character set,
    ///                                ISO-8859-1.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseString(
        queue: DispatchQueue? = nil,
        encoding: String.Encoding? = nil,
        completionHandler: @escaping (PagoDownloadResponse<String>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDownloadRequest.stringResponseSerializer(encoding: encoding),
            completionHandler: completionHandler
        )
    }
}

// MARK: - JSON

extension PagoRequest {
    /// Returns a JSON object contained in a result type constructed from the response data using `JSONSerialization`
    /// with the specified reading options.
    ///
    /// - parameter options:  The JSON serialization reading options. Defaults to `.allowFragments`.
    /// - parameter response: The response from the server.
    /// - parameter data:     The data returned from the server.
    /// - parameter error:    The error already encountered if it exists.
    ///
    /// - returns: The result data type.
    public static func serializeResponseJSON(
        options: JSONSerialization.ReadingOptions,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
        -> PagoApiClientResult<Any>
    {
        guard error == nil else { return .failure(error!) }

        if let response = response, emptyDataStatusCodes.contains(response.statusCode) { return .success(NSNull()) }

        guard let validData = data, validData.count > 0 else {
            return .failure(PagoAFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
        }

        do {
            let json = try JSONSerialization.jsonObject(with: validData, options: options)
            return .success(json)
        } catch {
            return .failure(PagoAFError.responseSerializationFailed(reason: .jsonSerializationFailed(error: error)))
        }
    }
}

extension PagoDataRequest {
    /// Creates a response serializer that returns a JSON object result type constructed from the response data using
    /// `JSONSerialization` with the specified reading options.
    ///
    /// - parameter options: The JSON serialization reading options. Defaults to `.allowFragments`.
    ///
    /// - returns: A JSON object response serializer.
    public static func jsonResponseSerializer(
        options: JSONSerialization.ReadingOptions = .allowFragments)
        -> PagoDataResponseSerializer<Any>
    {
        return PagoDataResponseSerializer { _, response, data, error in
            return PagoRequest.serializeResponseJSON(options: options, response: response, data: data, error: error)
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter options:           The JSON serialization reading options. Defaults to `.allowFragments`.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (PagoDataResponse<Any>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDataRequest.jsonResponseSerializer(options: options),
            completionHandler: completionHandler
        )
    }
}

extension PagoDownloadRequest {
    /// Creates a response serializer that returns a JSON object result type constructed from the response data using
    /// `JSONSerialization` with the specified reading options.
    ///
    /// - parameter options: The JSON serialization reading options. Defaults to `.allowFragments`.
    ///
    /// - returns: A JSON object response serializer.
    public static func jsonResponseSerializer(
        options: JSONSerialization.ReadingOptions = .allowFragments)
        -> PagoDownloadResponseSerializer<Any>
    {
        return PagoDownloadResponseSerializer { _, response, fileURL, error in
            guard error == nil else { return .failure(error!) }

            guard let fileURL = fileURL else {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileNil))
            }

            do {
                let data = try Data(contentsOf: fileURL)
                return PagoRequest.serializeResponseJSON(options: options, response: response, data: data, error: error)
            } catch {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileReadFailed(at: fileURL)))
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter options:           The JSON serialization reading options. Defaults to `.allowFragments`.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responseJSON(
        queue: DispatchQueue? = nil,
        options: JSONSerialization.ReadingOptions = .allowFragments,
        completionHandler: @escaping (PagoDownloadResponse<Any>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDownloadRequest.jsonResponseSerializer(options: options),
            completionHandler: completionHandler
        )
    }
}

// MARK: - Property List

extension PagoRequest {
    /// Returns a plist object contained in a result type constructed from the response data using
    /// `PropertyListSerialization` with the specified reading options.
    ///
    /// - parameter options:  The property list reading options. Defaults to `[]`.
    /// - parameter response: The response from the server.
    /// - parameter data:     The data returned from the server.
    /// - parameter error:    The error already encountered if it exists.
    ///
    /// - returns: The result data type.
    public static func serializeResponsePropertyList(
        options: PropertyListSerialization.ReadOptions,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?)
        -> PagoApiClientResult<Any>
    {
        guard error == nil else { return .failure(error!) }

        if let response = response, emptyDataStatusCodes.contains(response.statusCode) { return .success(NSNull()) }

        guard let validData = data, validData.count > 0 else {
            return .failure(PagoAFError.responseSerializationFailed(reason: .inputDataNilOrZeroLength))
        }

        do {
            let plist = try PropertyListSerialization.propertyList(from: validData, options: options, format: nil)
            return .success(plist)
        } catch {
            return .failure(PagoAFError.responseSerializationFailed(reason: .propertyListSerializationFailed(error: error)))
        }
    }
}

extension PagoDataRequest {
    /// Creates a response serializer that returns an object constructed from the response data using
    /// `PropertyListSerialization` with the specified reading options.
    ///
    /// - parameter options: The property list reading options. Defaults to `[]`.
    ///
    /// - returns: A property list object response serializer.
    public static func propertyListResponseSerializer(
        options: PropertyListSerialization.ReadOptions = [])
        -> PagoDataResponseSerializer<Any>
    {
        return PagoDataResponseSerializer { _, response, data, error in
            return PagoRequest.serializeResponsePropertyList(options: options, response: response, data: data, error: error)
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter options:           The property list reading options. Defaults to `[]`.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responsePropertyList(
        queue: DispatchQueue? = nil,
        options: PropertyListSerialization.ReadOptions = [],
        completionHandler: @escaping (PagoDataResponse<Any>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDataRequest.propertyListResponseSerializer(options: options),
            completionHandler: completionHandler
        )
    }
}

extension PagoDownloadRequest {
    /// Creates a response serializer that returns an object constructed from the response data using
    /// `PropertyListSerialization` with the specified reading options.
    ///
    /// - parameter options: The property list reading options. Defaults to `[]`.
    ///
    /// - returns: A property list object response serializer.
    public static func propertyListResponseSerializer(
        options: PropertyListSerialization.ReadOptions = [])
        -> PagoDownloadResponseSerializer<Any>
    {
        return PagoDownloadResponseSerializer { _, response, fileURL, error in
            guard error == nil else { return .failure(error!) }

            guard let fileURL = fileURL else {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileNil))
            }

            do {
                let data = try Data(contentsOf: fileURL)
                return PagoRequest.serializeResponsePropertyList(options: options, response: response, data: data, error: error)
            } catch {
                return .failure(PagoAFError.responseSerializationFailed(reason: .inputFileReadFailed(at: fileURL)))
            }
        }
    }

    /// Adds a handler to be called once the request has finished.
    ///
    /// - parameter options:           The property list reading options. Defaults to `[]`.
    /// - parameter completionHandler: A closure to be executed once the request has finished.
    ///
    /// - returns: The request.
    @discardableResult
    public func responsePropertyList(
        queue: DispatchQueue? = nil,
        options: PropertyListSerialization.ReadOptions = [],
        completionHandler: @escaping (PagoDownloadResponse<Any>) -> Void)
        -> Self
    {
        return response(
            queue: queue,
            responseSerializer: PagoDownloadRequest.propertyListResponseSerializer(options: options),
            completionHandler: completionHandler
        )
    }
}

/// A set of HTTP response status code that do not contain response data.
private let emptyDataStatusCodes: Set<Int> = [204, 205]
