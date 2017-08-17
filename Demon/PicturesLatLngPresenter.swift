//
//  PicturesLatLngPresenter.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import Alamofire

class PicturesLatLngPresenter: PicturesLatLngCallback {
    
    private lazy var picturesLatLngInteractor: PicturesLatLngInteractor = PicturesLatLngInteractor(callback: self)
    
    let setProgressVisibility: ((Bool, Bool, Bool) -> Void)
    
    let endRefreshing: (() -> Void)
    
    let displayItems: (([PictureLatLng]) -> Void)
    
    let displayApiError: ((ApiError) -> Void)
    
    let displayError: ((Error) -> Void)
    
    var pictures: [PictureLatLng] = []
    
    init<V>(viewModel: V) where V : ListViewModel, V.Item == PictureLatLng {
        self.setProgressVisibility = viewModel.setProgressVisibility(isProgressHidden:isEmptyListMessageHidden:isTableViewHidden:)
        self.endRefreshing = viewModel.endRefreshing
        self.displayItems = viewModel.displayItems(items:)
        self.displayApiError = viewModel.displayApiError(apiError:)
        self.displayError = viewModel.displayError(error:)
    }
    
    func getPictures(imei: String) {
        self.setProgressVisibility(false, true, false)
        self.picturesLatLngInteractor.getPictures(imei: imei)
    }
    
    func refreshPictures(imei: String) {
        self.setProgressVisibility(true, true, false)
        self.picturesLatLngInteractor.getPictures(imei: imei)
    }
    
    func sendPicture(imei: String, base64Img: String) {
        self.setProgressVisibility(false, true, false)
        self.picturesLatLngInteractor.sendPicture(imei: imei, base64Img: base64Img)
    }
    
    func onGetItemsResponse(items: [PictureLatLng]) {
        self.pictures = items
        self.setProgressVisibility(true, !self.pictures.isEmpty, self.pictures.isEmpty)
        self.endRefreshing()
        self.displayItems(self.pictures)
    }

    func onSendPictureResponse(imei: String) {
        self.getPictures(imei: imei)
    }

    func onApiResponseError(apiError: ApiError) {
        self.setProgressVisibility(true, !self.pictures.isEmpty, self.pictures.isEmpty)
        self.endRefreshing()
        self.displayApiError(apiError)
    }
    
    func onRequestFailure(error: Error) {
        self.setProgressVisibility(true, !self.pictures.isEmpty, self.pictures.isEmpty)
        self.endRefreshing()
        self.displayError(error)
    }
}
