//
//  ApiError.swift
//  M Cards
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation

class ApiError {
    
    static let KEY_MESSAGE: String = "cMensaje"
    
    let message: String
    
    init(message: String) {
        self.message = message
    }
}
