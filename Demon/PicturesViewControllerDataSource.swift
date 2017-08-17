//
//  PicturesViewControllerDataSource.swift
//  Demon
//
//  Created by Jesús Manuel Ramos Juarez on 15/08/17.
//  Copyright © 2017 Jesús Manuel Ramos Juarez. All rights reserved.
//

import Foundation
import UIKit

extension PicturesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: PictureTableViewCell = tableView.dequeueReusableCell(withIdentifier: PICTURE_TABLE_VIEW_CELL_IDENTIFIER, for: indexPath) as! PictureTableViewCell
        
        let picture: PictureLatLng = self.pictures[indexPath.row]
        
        cell.pictureIdLabel.text = "\(picture.id)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
