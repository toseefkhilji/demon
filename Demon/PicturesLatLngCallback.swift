//
//  PicturesLatLngCallback.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 16/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import Alamofire

protocol PicturesLatLngCallback: ListBaseCallback {
    
    func onSendPictureResponse(imei: String)
}
