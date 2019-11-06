//
//  EquipmentListViewModel.swift
//  beelding
//
//  Created by Mathis Detourbet on 5/11/19.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import Foundation

class EquipmentListViewModel {
    
    private var equipments: [Equipment]
    private let businessService: BeeldiBusinessService
    
    init() {
        equipments = []
        businessService = BeeldiBusinessService()
    }
}

// MARK: - TableView DataSource
extension EquipmentListViewModel {
    
    public static let numberOfSection: Int = 1
    
    public func numberOfRowIn(_ section: Int) -> Int {
        return equipments.count
    }
    
    public func equipmentAt(_ indexPath: IndexPath) -> Equipment {
        guard case 0...equipments.count = indexPath.row else {
            fatalError("Equipment cannot be found at row: \(indexPath.row)!")
        }
        return equipments[indexPath.row]
    }
    
    public func didSelectEquipmentAt(_ indexPath: IndexPath) {
        
    }
}

// MARK: - Load data from database

extension EquipmentListViewModel {
    
    public func loadOrderedEquipmentsList(completionHandler: @escaping (Bool) -> Void) {
        businessService.fetchOrderedEquipmentList { [weak self] result in
            switch result {
            case .success(let equipments):
                self?.equipments = equipments
                completionHandler(true)
            case .failure(_):
                completionHandler(false)
            case .empty:
                self?.equipments = []
                completionHandler(true)
            }
        }
    }
}
