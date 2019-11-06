//
//  BeeldiBusinessService.swift
//  beelding
//
//  Created by Mathis Detourbet on 5/11/19.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import Foundation

class BeeldiBusinessService {
    
    let dataAccess: DataAccess
    
    init() {
        dataAccess = DatabaseDataAccess()
    }
    
    func fetchOrderedEquipmentList(completionHandler: @escaping ((Result<[Equipment]>) -> Void)) {
        dataAccess.fetchEquipments { result in
            switch result {
            case.success(let equipments): ()
            let orderedEquipments = equipments.sorted { $0.name < $1.name }
                completionHandler(.success(orderedEquipments))
            case .failure(let error): ()
                completionHandler(.failure(error))
            case .empty:
                completionHandler(.empty)
            }
        }
    }
}
