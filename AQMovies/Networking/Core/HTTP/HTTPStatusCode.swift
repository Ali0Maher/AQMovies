//
//  HTTPStatusCode.swift
//  Delivery Boy
//
//  Created by Ali on 12/5/21.
//

import Foundation


public enum HTTPStatusCode: Int {
    case unknown = 0

    // 200 Success
    case success = 200

    // 400 Client Error
    case badRequest = 400

    case unauthorised = 401

    //429 Too Many Requests
    case tooManyRequests = 429

    // 500 Server Error
    case internalServerError = 500

    case noInternetConnection = -1009
    
    init(value: Int) {
        guard let statusCode = HTTPStatusCode(rawValue: value) else {
            self = .unknown
            return
        }
        self = statusCode
    }
}
