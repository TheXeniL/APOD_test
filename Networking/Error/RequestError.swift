//
//  RequestError.swift
//  Networking
//
//  Created by Nikita Elizarov on 28.01.2022.
//

import Foundation

/// Predefined error types for networking
public enum RequestError: Error {
    /// The underlying reason the `.parameterEncodingFailed` error occurred.
    public enum ParameterEncodingFailureReason {
        /// The `URLRequest` did not have a `URL` to encode.
        case missingURL
        /// JSON serialization failed with an underlying system error during the encoding process.
        case jsonEncodingFailed(error: Error)
        /// Custom parameter encoding failed due to the associated `Error`.
        case customEncodingFailed(error: Error)
    }

    /// The underlying reason the `.responseValidationFailed` error occurred.
    public enum ResponseValidationFailureReason {
        /// The data file containing the server response did not exist.
        case dataFileNil
        /// The response status code was not acceptable.
        case unacceptableStatusCode(code: Int, headers: [AnyHashable: Any], body: Data?)
        /// Custom response validation failed due to the associated `Error`.
        case customValidationFailed(code: String?, message: String?, body: Data?)
    }

    /// The underlying reason the response serialization error occurred.
    public enum ResponseSerializationFailureReason {
        /// The server response contained no data or the data was zero length.
        case inputDataNilOrZeroLength
        /// The file containing the server response could not be read from the associated `URL`.
        case jsonSerializationFailed(error: Error)
        /// A `DataDecoder` failed to decode the response due to the associated `Error`.
        case decodingFailed(error: Error)
    }

    case requestBuildingFailed
    case sessionTaskFailed(error: Error)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .parameterEncodingFailed(reason):
            return reason.localizedDescription
        case let .responseValidationFailed(reason):
            return reason.localizedDescription
        case let .responseSerializationFailed(reason):
            return reason.localizedDescription
        case let .sessionTaskFailed(error):
            return "URLSessionTask failed with error: \(error.localizedDescription)"
        case .requestBuildingFailed:
            return "URLSessionTask failed to build"
        }
    }
}

extension RequestError.ParameterEncodingFailureReason {
    var localizedDescription: String {
        switch self {
        case .missingURL:
            return "URL request to encode was missing a URL"
        case let .jsonEncodingFailed(error):
            return "JSON could not be encoded because of error:\n\(error.localizedDescription)"
        case let .customEncodingFailed(error):
            return "Custom parameter encoder failed with error: \(error.localizedDescription)"
        }
    }
}

extension RequestError.ResponseValidationFailureReason {
    var localizedDescription: String {
        switch self {
        case .dataFileNil:
            return "Response could not be validated, data file was nil."
        case let .unacceptableStatusCode(code, _, _):
            return "Response status code was unacceptable: \(code)."
        case let .customValidationFailed(code, message, _):
            return "Custom response validation failed with code: \(code ?? "NONE"), message: \(message ?? "")"
        }
    }
}

extension RequestError.ResponseSerializationFailureReason {
    var localizedDescription: String {
        switch self {
        case .inputDataNilOrZeroLength:
            return "Response could not be serialized, input data was nil or zero length."
        case let .jsonSerializationFailed(error):
            return "JSON could not be serialized because of error:\n\(error.localizedDescription)"
        case let .decodingFailed(error):
            return "Response could not be decoded because of error:\n\(error.localizedDescription)"
        }
    }
}
