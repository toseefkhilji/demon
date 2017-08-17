//
//  BackendError.swift
//  M Cards
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation

enum BackendError: Error {
    case apiResponseError(apiError: ApiError)
    case requestFailureError(error: Error)
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case objectSerialization(reason: String)
}
