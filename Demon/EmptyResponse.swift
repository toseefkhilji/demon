//
//  EmptyResponse.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 16/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import SwiftyJSON

final class EmptyResponse: ResponseObjectSerializable {
    
    init(response: HTTPURLResponse, representation: JSON) {
        
    }
}
