//
//  PicturesTableViewController.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import UIKit
import SwiftyJSON
import MapKit

class PicturesViewController: UIViewController, ListViewModel {
    
    @IBOutlet weak var emptyMessageContainer: UIView!
    
    @IBOutlet weak var picturesTableView: UITableView!
    
    @IBOutlet weak var progressContainer: UIView!
    
    private let refreshControl: UIRefreshControl = UIRefreshControl()
    
    typealias Item = PictureLatLng
    
    let PICTURE_TABLE_VIEW_CELL_IDENTIFIER: String = "PictureTableViewCell"
    
    var pictures: [PictureLatLng] = []
    
    lazy var picturesPresenter: PicturesLatLngPresenter = PicturesLatLngPresenter(viewModel: self)
    
    private lazy var locationManager: CLLocationManager = CLLocationManager()
    
    var locationStatus: CLAuthorizationStatus = CLAuthorizationStatus.denied
    
    lazy var pickerController: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshPictures), for: .valueChanged)
        self.picturesTableView.addSubview(self.refreshControl)
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.pickerController.delegate = self
        self.pickerController.sourceType = .camera
        
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        if self.locationStatus == CLAuthorizationStatus.authorizedWhenInUse {
            self.present(self.pickerController, animated: true, completion: nil)
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    @IBAction func updatePicturesButtonPressed(_ sender: UIButton) {
        self.getPictures()
    }
    
    func getPictures() {
        if self.locationStatus == CLAuthorizationStatus.authorizedWhenInUse {
            if let imei = UIDevice.current.identifierForVendor?.uuidString {
                self.picturesPresenter.getPictures(imei: imei)
            }
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func refreshPictures() {
        if self.locationStatus == CLAuthorizationStatus.authorizedWhenInUse {
            if let imei = UIDevice.current.identifierForVendor?.uuidString {
                self.picturesPresenter.refreshPictures(imei: imei)
            }
        } else {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func setProgressVisibility(isProgressHidden: Bool, isEmptyListMessageHidden: Bool, isTableViewHidden: Bool) {
        self.emptyMessageContainer.isHidden = isEmptyListMessageHidden
        self.progressContainer.isHidden = isProgressHidden
        self.picturesTableView.isHidden = isTableViewHidden
    }
    
    func endRefreshing() {
        self.refreshControl.endRefreshing()
    }
    
    func displayItems(items: [PictureLatLng]) {
        self.pictures = items
        self.picturesTableView.reloadData()
    }
    
    func displayApiError(apiError: ApiError) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: apiError.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func displayError(error: Error) {
        let alert: UIAlertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
