//
//  Checkpoint.swift
//  beelding
//
//  Created by Mathis Detourbet on 5/11/19.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import Foundation
import Firebase

struct Checkpoint {
    
    enum CheckpointCodingKeys {
        static let equipmentIdKey = "equipmentKey"
        static let nameKey = "name"
        static let recommandationKey = "recommandation"
        static let photoUrlKey = "photo"
    }
    
    let equipmentId: String
    let name: String
    let fault: String
    let recommandation: String
    let photoUrl: URL?
    
//    init(snapshot: DataSnapshot) {
//
//    }
}
