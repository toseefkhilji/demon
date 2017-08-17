//
//  PicturesViewControllerLocationManager.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 16/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import MapKit

extension PicturesViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        switch status {
        case .authorizedWhenInUse:
            self.getPictures()
            break
        default:
            break
        }
    }
}
