//
//  Equipment.swift
//  beelding
//
//  Created by Mathis Detourbet on 5/11/19.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import Foundation
import Firebase

protocol FirebaseDecodable {
    init?(snapshot: DataSnapshot)
}

struct Equipment: FirebaseDecodable {
    
    enum EquipmentCodingKeys {
        static let idKey = ""
        static let nameKey = "name"
        static let domainKey = "domain"
        static let nbFaultsKey = "nbFaults"
        static let photoUrlKey = "photo"
    }
    
    let id: String
    let name: String
    let domain: String
    let nbFaults: Int
    let photoUrl: URL?
    let checkpoints: [Checkpoint]
    
    init?(snapshot: DataSnapshot) {
        guard
            let dict = snapshot.value as? [String: Any],
//            let id = snapshot.value(forKey: EquipmentCodingKeys.idKey) as? String,
            let name = dict[EquipmentCodingKeys.nameKey] as? String,
            let domain = dict[EquipmentCodingKeys.domainKey] as? String,
            let nbFaults = dict[EquipmentCodingKeys.nbFaultsKey] as? Int,
            let photoUrlString = dict[EquipmentCodingKeys.photoUrlKey] as? String
        else {
            return nil
        }
        
        self.id = ""
        self.name = name
        self.domain = domain
        self.nbFaults = nbFaults
        self.photoUrl = URL(string: photoUrlString)
        self.checkpoints = []
    }
}
