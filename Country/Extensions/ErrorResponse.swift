//
//  ErrorResponse.swift
//  Country
//
//  Created by Mark Anthony Fernandez on 1/24/20.
//  Copyright © 2020 Mark Anthony Fernandez. All rights reserved.
//

import Foundation

struct ErrorResponse: Codable {
    let error: ErrorMessage
}

struct ErrorMessage: Codable {
    let code: String?
    let message: String
    let statusCode: Int
    
    public func toThrowable() -> Throwable {
        return Throwable.init(errorDescription: message, failureReason: "\(statusCode)", recoverySuggestion: "", helpAnchor: "")
    }
}

struct Throwable: LocalizedError {
    public var errorDescription: String?
    /// A localized message describing the reason for the failure.
    public var failureReason: String?
    /// A localized message describing how one might recover from the failure.
    public var recoverySuggestion: String?
    /// A localized message providing "help" text if the user requests help.
    public var helpAnchor: String?
}
