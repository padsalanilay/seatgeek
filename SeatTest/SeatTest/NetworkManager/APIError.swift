//
//  APIError.swift
//  SeatTest
//
//  Created by Nilay Padsala on 3/29/21.
//

import Foundation
enum APIError: Error {
    case invalidServerResponseError
    case emptyDataError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidServerResponseError:
            return NSLocalizedString("Server response is Invalid for given API call", comment: "invalid server respose error")
        case .emptyDataError:
            return NSLocalizedString("API Response Data is Empty", comment: "Empty data error")
        }
    }
}
