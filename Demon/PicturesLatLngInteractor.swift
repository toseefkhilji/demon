//
//  PicturesLatLngInteractor.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import Alamofire

class PicturesLatLngInteractor {
    
    private let onGetItemsResponse: (([PictureLatLng]) -> Void)
    
    private let onSendPictureResponse: ((String) -> Void)
    
    private let onApiError: ((ApiError) -> Void)
    
    private let onRequestError: ((Error) -> Void)
    
    init<C>(callback: C) where C: PicturesLatLngCallback, C.Item == PictureLatLng {
        self.onGetItemsResponse = callback.onGetItemsResponse(items:)
        self.onApiError = callback.onApiResponseError(apiError:)
        self.onRequestError = callback.onRequestFailure(error:)
        self.onSendPictureResponse = callback.onSendPictureResponse
    }
    
    func getPictures(imei: String) {
        let params: Parameters = ["cImei": imei]
        _ = Alamofire.request(Router.getPictures(params: params)).validate().responseObject { (response: DataResponse<ApiResponse<PictureLatLng>>) in
            switch response.result {
            case .success(let result):
                if result.error {
                    self.onApiError(ApiError(message: result.message))
                } else {
                    self.onGetItemsResponse(result.data)
                }
                break
            case .failure(let error):
                switch error {
                case BackendError.apiResponseError(let apiError):
                    self.onApiError(apiError)
                    break
                default:
                    self.onRequestError(error)
                    break
                }
                break
            }
        }
    }
    
    func sendPicture(imei: String, base64Img: String) {
        let params: Parameters = ["cImei": imei, "cFoto": base64Img]
        _ = Alamofire.request(Router.sendPicture(params: params)).validate().responseObject(completionHandler: { (response: DataResponse<EmptyResponse>) in
            switch response.result {
            case .success:
                self.onSendPictureResponse(imei)
                break
            case .failure(let error):
                switch error {
                case BackendError.apiResponseError(let apiError):
                    self.onApiError(apiError)
                    break
                default:
                    self.onRequestError(error)
                    break
                }
                break
            }
        })
    }
}
