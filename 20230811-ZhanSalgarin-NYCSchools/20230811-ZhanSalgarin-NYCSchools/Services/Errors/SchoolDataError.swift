//
//  SchoolDataError.swift
//  20230811-ZhanSalgarin-NYCSchools
//
//  Created by SALGARA, YESKENDIR on 14.08.23.
//

import Foundation

enum SchoolAPIError: Error {
    case custom(error: Error)
    case failedToDecode
    case invalidStatusCode
    
    var errorDescription: String {
        switch self {
        case .custom(let error):
            return error.localizedDescription
        case .failedToDecode:
            return "Failed to decode response"
        case .invalidStatusCode:
            return "Invalid status code"
        }
    }
}
