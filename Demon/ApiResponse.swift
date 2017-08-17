//
//  ApiResponse.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import SwiftyJSON

final class ApiResponse<T: ResponseObjectSerializable>: ResponseObjectSerializable {
    
    private let KEY_ERROR: String = "bError"
    
    private let KEY_MESSAGE: String = "cMessage"
    
    private let KEY_DATA: String = "lstImagenes"
    
    var error: Bool = false
    
    var message: String = ""
    
    var data: [T] = []
    
    init(response: HTTPURLResponse, representation: JSON) {
        self.error = representation[KEY_ERROR].boolValue
        self.message = representation[KEY_MESSAGE].stringValue
        
        if let itemsJsonArray = representation[KEY_DATA].array {
            var items: [T] = []
            for i in itemsJsonArray {
                let item: T = T(response: response, representation: i)
                items.append(item)
            }
            self.data = items
        }
    }
}
