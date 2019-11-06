//
//  EquipmentTableViewCell.swift
//  beelding
//
//  Created by Mathis Detourbet on 5/11/19.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import UIKit
import Kingfisher

final class EquipmentTableViewCell: UITableViewCell {
    
    static let identifier: String = "idEquipmentTableViewCell"

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var domainLabel: UILabel!
    @IBOutlet private weak var nbFaultsLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.contentMode = .scaleAspectFill
    }
    
    public func fill(with equipment: Equipment) {
        nameLabel.text = equipment.name
        domainLabel.text = equipment.domain
        nbFaultsLabel.text = String(equipment.nbFaults)
        
        if let photoUrl = equipment.photoUrl {
            photoImageView.kf.setImage(with: photoUrl)
        }
    }
    
}
