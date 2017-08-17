//
//  BaseApiCallback.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation

protocol BaseApiCallback {
    
    func onApiResponseError(apiError: ApiError)
    
    func onRequestFailure(error: Error)
}
