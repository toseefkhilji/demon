//
//  PictureLatLng.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import SwiftyJSON

final class PictureLatLng: ResponseObjectSerializable {
    
    let KEY_ID: String = "nIdImagen"
    
    let id: Int
    
    init(response: HTTPURLResponse, representation: JSON) {
        self.id = representation[KEY_ID].intValue
    }
}
