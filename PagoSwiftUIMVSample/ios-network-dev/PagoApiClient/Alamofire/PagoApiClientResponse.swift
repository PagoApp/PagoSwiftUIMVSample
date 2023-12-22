//
//  Response.swift
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

/// Used to store all data associated with an non-serialized response of a data or upload request.
public struct PagoDefaultDataResponse {
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

    /// The error encountered while executing or validating the request.
    public let error: Error?

    /// The timeline of the complete lifecycle of the request.
    public let timeline: PagoTimeline

    var _metrics: AnyObject?

    /// Creates a `DefaultDataResponse` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - request:  The URL request sent to the server.
    ///   - response: The server's response to the URL request.
    ///   - data:     The data returned by the server.
    ///   - error:    The error encountered while executing or validating the request.
    ///   - timeline: The timeline of the complete lifecycle of the request. `Timeline()` by default.
    ///   - metrics:  The task metrics containing the request / response statistics. `nil` by default.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        error: Error?,
        timeline: PagoTimeline = PagoTimeline(),
        metrics: AnyObject? = nil)
    {
        self.request = request
        self.response = response
        self.data = data
        self.error = error
        self.timeline = timeline
    }
}

// MARK: -

/// Used to store all data associated with a serialized response of a data or upload request.
public struct PagoDataResponse<Value> {
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The data returned by the server.
    public let data: Data?

    /// The result of response serialization.
    public let result: PagoApiClientResult<Value>

    /// The timeline of the complete lifecycle of the request.
    public let timeline: PagoTimeline

    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Value? { return result.value }

    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Error? { return result.error }

    var _metrics: AnyObject?

    /// Creates a `DataResponse` instance with the specified parameters derived from response serialization.
    ///
    /// - parameter request:  The URL request sent to the server.
    /// - parameter response: The server's response to the URL request.
    /// - parameter data:     The data returned by the server.
    /// - parameter result:   The result of response serialization.
    /// - parameter timeline: The timeline of the complete lifecycle of the `Request`. Defaults to `Timeline()`.
    ///
    /// - returns: The new `DataResponse` instance.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        data: Data?,
        result: PagoApiClientResult<Value>,
        timeline: PagoTimeline = PagoTimeline())
    {
        self.request = request
        self.response = response
        self.data = data
        self.result = result
        self.timeline = timeline
    }
}

// MARK: -

extension PagoDataResponse: CustomStringConvertible, CustomDebugStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure.
    public var description: String {
        return result.debugDescription
    }

    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the server data, the response serialization result and the timeline.
    public var debugDescription: String {
        var output: [String] = []

        output.append(request != nil ? "[Request]: \(request!.httpMethod ?? "GET") \(request!)" : "[Request]: nil")
        output.append(response != nil ? "[Response]: \(response!)" : "[Response]: nil")
        output.append("[Data]: \(data?.count ?? 0) bytes")
        output.append("[Result]: \(result.debugDescription)")
        output.append("[Timeline]: \(timeline.debugDescription)")

        return output.joined(separator: "\n")
    }
}

// MARK: -

extension PagoDataResponse {
    /// Evaluates the specified closure when the result of this `DataResponse` is a success, passing the unwrapped
    /// result value as a parameter.
    ///
    /// Use the `map` method with a closure that does not throw. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleInt = possibleData.map { $0.count }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A `DataResponse` whose result wraps the value returned by the given closure. If this instance's
    ///            result is a failure, returns a response wrapping the same failure.
    public func map<T>(_ transform: (Value) -> T) -> PagoDataResponse<T> {
        var response = PagoDataResponse<T>(
            request: request,
            response: self.response,
            data: data,
            result: result.map(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }

    /// Evaluates the given closure when the result of this `DataResponse` is a success, passing the unwrapped result
    /// value as a parameter.
    ///
    /// Use the `flatMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMap {
    ///         try JSONSerialization.jsonObject(with: $0)
    ///     }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A success or failure `DataResponse` depending on the result of the given closure. If this instance's
    ///            result is a failure, returns the same failure.
    public func flatMap<T>(_ transform: (Value) throws -> T) -> PagoDataResponse<T> {
        var response = PagoDataResponse<T>(
            request: request,
            response: self.response,
            data: data,
            result: result.flatMap(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }

    /// Evaluates the specified closure when the `DataResponse` is a failure, passing the unwrapped error as a parameter.
    ///
    /// Use the `mapError` function with a closure that does not throw. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let withMyError = possibleData.mapError { MyError.error($0) }
    ///
    /// - Parameter transform: A closure that takes the error of the instance.
    /// - Returns: A `DataResponse` instance containing the result of the transform.
    public func mapError<E: Error>(_ transform: (Error) -> E) -> PagoDataResponse {
        var response = PagoDataResponse(
            request: request,
            response: self.response,
            data: data,
            result: result.mapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }

    /// Evaluates the specified closure when the `DataResponse` is a failure, passing the unwrapped error as a parameter.
    ///
    /// Use the `flatMapError` function with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DataResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMapError {
    ///         try someFailableFunction(taking: $0)
    ///     }
    ///
    /// - Parameter transform: A throwing closure that takes the error of the instance.
    ///
    /// - Returns: A `DataResponse` instance containing the result of the transform.
    public func flatMapError<E: Error>(_ transform: (Error) throws -> E) -> PagoDataResponse {
        var response = PagoDataResponse(
            request: request,
            response: self.response,
            data: data,
            result: result.flatMapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }
}

// MARK: -

/// Used to store all data associated with an non-serialized response of a download request.
public struct PagoDefaultDownloadResponse {
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The temporary destination URL of the data returned from the server.
    public let temporaryURL: URL?

    /// The final destination URL of the data returned from the server if it was moved.
    public let destinationURL: URL?

    /// The resume data generated if the request was cancelled.
    public let resumeData: Data?

    /// The error encountered while executing or validating the request.
    public let error: Error?

    /// The timeline of the complete lifecycle of the request.
    public let timeline: PagoTimeline

    var _metrics: AnyObject?

    /// Creates a `DefaultDownloadResponse` instance from the specified parameters.
    ///
    /// - Parameters:
    ///   - request:        The URL request sent to the server.
    ///   - response:       The server's response to the URL request.
    ///   - temporaryURL:   The temporary destination URL of the data returned from the server.
    ///   - destinationURL: The final destination URL of the data returned from the server if it was moved.
    ///   - resumeData:     The resume data generated if the request was cancelled.
    ///   - error:          The error encountered while executing or validating the request.
    ///   - timeline:       The timeline of the complete lifecycle of the request. `Timeline()` by default.
    ///   - metrics:        The task metrics containing the request / response statistics. `nil` by default.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        temporaryURL: URL?,
        destinationURL: URL?,
        resumeData: Data?,
        error: Error?,
        timeline: PagoTimeline = PagoTimeline(),
        metrics: AnyObject? = nil)
    {
        self.request = request
        self.response = response
        self.temporaryURL = temporaryURL
        self.destinationURL = destinationURL
        self.resumeData = resumeData
        self.error = error
        self.timeline = timeline
    }
}

// MARK: -

/// Used to store all data associated with a serialized response of a download request.
public struct PagoDownloadResponse<Value> {
    /// The URL request sent to the server.
    public let request: URLRequest?

    /// The server's response to the URL request.
    public let response: HTTPURLResponse?

    /// The temporary destination URL of the data returned from the server.
    public let temporaryURL: URL?

    /// The final destination URL of the data returned from the server if it was moved.
    public let destinationURL: URL?

    /// The resume data generated if the request was cancelled.
    public let resumeData: Data?

    /// The result of response serialization.
    public let result: PagoApiClientResult<Value>

    /// The timeline of the complete lifecycle of the request.
    public let timeline: PagoTimeline

    /// Returns the associated value of the result if it is a success, `nil` otherwise.
    public var value: Value? { return result.value }

    /// Returns the associated error value if the result if it is a failure, `nil` otherwise.
    public var error: Error? { return result.error }

    var _metrics: AnyObject?

    /// Creates a `DownloadResponse` instance with the specified parameters derived from response serialization.
    ///
    /// - parameter request:        The URL request sent to the server.
    /// - parameter response:       The server's response to the URL request.
    /// - parameter temporaryURL:   The temporary destination URL of the data returned from the server.
    /// - parameter destinationURL: The final destination URL of the data returned from the server if it was moved.
    /// - parameter resumeData:     The resume data generated if the request was cancelled.
    /// - parameter result:         The result of response serialization.
    /// - parameter timeline:       The timeline of the complete lifecycle of the `Request`. Defaults to `Timeline()`.
    ///
    /// - returns: The new `DownloadResponse` instance.
    public init(
        request: URLRequest?,
        response: HTTPURLResponse?,
        temporaryURL: URL?,
        destinationURL: URL?,
        resumeData: Data?,
        result: PagoApiClientResult<Value>,
        timeline: PagoTimeline = PagoTimeline())
    {
        self.request = request
        self.response = response
        self.temporaryURL = temporaryURL
        self.destinationURL = destinationURL
        self.resumeData = resumeData
        self.result = result
        self.timeline = timeline
    }
}

// MARK: -

extension PagoDownloadResponse: CustomStringConvertible, CustomDebugStringConvertible {
    /// The textual representation used when written to an output stream, which includes whether the result was a
    /// success or failure.
    public var description: String {
        return result.debugDescription
    }

    /// The debug textual representation used when written to an output stream, which includes the URL request, the URL
    /// response, the temporary and destination URLs, the resume data, the response serialization result and the
    /// timeline.
    public var debugDescription: String {
        var output: [String] = []

        output.append(request != nil ? "[Request]: \(request!.httpMethod ?? "GET") \(request!)" : "[Request]: nil")
        output.append(response != nil ? "[Response]: \(response!)" : "[Response]: nil")
        output.append("[TemporaryURL]: \(temporaryURL?.path ?? "nil")")
        output.append("[DestinationURL]: \(destinationURL?.path ?? "nil")")
        output.append("[ResumeData]: \(resumeData?.count ?? 0) bytes")
        output.append("[Result]: \(result.debugDescription)")
        output.append("[Timeline]: \(timeline.debugDescription)")

        return output.joined(separator: "\n")
    }
}

// MARK: -

extension PagoDownloadResponse {
    /// Evaluates the given closure when the result of this `DownloadResponse` is a success, passing the unwrapped
    /// result value as a parameter.
    ///
    /// Use the `map` method with a closure that does not throw. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleInt = possibleData.map { $0.count }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A `DownloadResponse` whose result wraps the value returned by the given closure. If this instance's
    ///            result is a failure, returns a response wrapping the same failure.
    public func map<T>(_ transform: (Value) -> T) -> PagoDownloadResponse<T> {
        var response = PagoDownloadResponse<T>(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.map(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }

    /// Evaluates the given closure when the result of this `DownloadResponse` is a success, passing the unwrapped
    /// result value as a parameter.
    ///
    /// Use the `flatMap` method with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMap {
    ///         try JSONSerialization.jsonObject(with: $0)
    ///     }
    ///
    /// - parameter transform: A closure that takes the success value of the instance's result.
    ///
    /// - returns: A success or failure `DownloadResponse` depending on the result of the given closure. If this
    /// instance's result is a failure, returns the same failure.
    public func flatMap<T>(_ transform: (Value) throws -> T) -> PagoDownloadResponse<T> {
        var response = PagoDownloadResponse<T>(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.flatMap(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }

    /// Evaluates the specified closure when the `DownloadResponse` is a failure, passing the unwrapped error as a parameter.
    ///
    /// Use the `mapError` function with a closure that does not throw. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let withMyError = possibleData.mapError { MyError.error($0) }
    ///
    /// - Parameter transform: A closure that takes the error of the instance.
    /// - Returns: A `DownloadResponse` instance containing the result of the transform.
    public func mapError<E: Error>(_ transform: (Error) -> E) -> PagoDownloadResponse {
        var response = PagoDownloadResponse(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.mapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }

    /// Evaluates the specified closure when the `DownloadResponse` is a failure, passing the unwrapped error as a parameter.
    ///
    /// Use the `flatMapError` function with a closure that may throw an error. For example:
    ///
    ///     let possibleData: DownloadResponse<Data> = ...
    ///     let possibleObject = possibleData.flatMapError {
    ///         try someFailableFunction(taking: $0)
    ///     }
    ///
    /// - Parameter transform: A throwing closure that takes the error of the instance.
    ///
    /// - Returns: A `DownloadResponse` instance containing the result of the transform.
    public func flatMapError<E: Error>(_ transform: (Error) throws -> E) -> PagoDownloadResponse {
        var response = PagoDownloadResponse(
            request: request,
            response: self.response,
            temporaryURL: temporaryURL,
            destinationURL: destinationURL,
            resumeData: resumeData,
            result: result.flatMapError(transform),
            timeline: timeline
        )

        response._metrics = _metrics

        return response
    }
}

// MARK: -

protocol PagoApiClientResponse {
    /// The task metrics containing the request / response statistics.
    var _metrics: AnyObject? { get set }
    mutating func add(_ metrics: AnyObject?)
}

extension PagoApiClientResponse {
    mutating func add(_ metrics: AnyObject?) {
        #if !os(watchOS)
            guard #available(iOS 10.0, macOS 10.12, tvOS 10.0, *) else { return }
            guard let metrics = metrics as? URLSessionTaskMetrics else { return }

            _metrics = metrics
        #endif
    }
}

// MARK: -

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension PagoDefaultDataResponse: PagoApiClientResponse {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension PagoDataResponse: PagoApiClientResponse {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension PagoDefaultDownloadResponse: PagoApiClientResponse {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
}

@available(iOS 10.0, macOS 10.12, tvOS 10.0, *)
extension PagoDownloadResponse: PagoApiClientResponse {
#if !os(watchOS)
    /// The task metrics containing the request / response statistics.
    public var metrics: URLSessionTaskMetrics? { return _metrics as? URLSessionTaskMetrics }
#endif
}
