//
//  ResponseObjectSerializable.swift
//  M Cards
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ResponseObjectSerializable {
    
    init(response: HTTPURLResponse, representation: JSON)
}
