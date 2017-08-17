//
//  PicturesLatLngImagePickerController.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 16/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension PicturesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.pickerController.dismiss(animated: true) { 
            let image: UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
            if let i = image {
                self.progressContainer.isHidden = false
                UIImageWriteToSavedPhotosAlbum(i, self, #selector(self.image(image:didFinishSavingWhitError:contextInfo:)), nil)
            }
        }
    }
    
    func image(image: UIImage, didFinishSavingWhitError error: Error?, contextInfo: UnsafeRawPointer?) {
        if let e = error {
            print(e.localizedDescription)
        } else {
            DispatchQueue.global(qos: .background).async {
                let encodedImage: String? = UIImageJPEGRepresentation(image, 0.9)?.base64EncodedString()
                DispatchQueue.main.async {
                    self.progressContainer.isHidden = true
                    if let imei = UIDevice.current.identifierForVendor?.uuidString, let imageResult = encodedImage {
                        print(imageResult)
                        self.picturesPresenter.sendPicture(imei: imei, base64Img: imageResult)
                    }
                }
            }
        }
    }
}
