//
//  DataAccessService.swift
//  beelding
//
//  Created by Mathis Detourbet on 5/11/19.
//  Copyright © 2019 Beeldi. All rights reserved.
//

import Foundation
import Firebase

enum Result<T> {
    case success(T)
    case failure(Error)
    case empty
}

protocol DataAccess {
    func fetchEquipments(completionHandler: @escaping ((Result<[Equipment]>) -> Void))
    func fetchCheckpoints(completionHandler: @escaping ((Result<[Checkpoint]>) -> Void))
}

class DatabaseDataAccess: DataAccess {
    func fetchCheckpoints(completionHandler: @escaping ((Result<[Checkpoint]>) -> Void)) {
        
    }
    
    
    enum DatebaseRefPath: String {
        case equipment = "Equipments"
        case checkpoints = "Checkpoints"
        
        var reference: DatabaseReference {
            Database.database().reference(withPath: rawValue)
        }
    }
    
    func fetchEquipments<T: FirebaseDecodable>(completionHandler: @escaping ((Result<[T]>) -> Void)) {
        DatabaseDataAccess.fetch(path: .equipment, completionHandler: completionHandler)
    }
    
    func fetchCheckpoints<T: FirebaseDecodable>(completionHandler: @escaping ((Result<[T]>) -> Void)) {
        DatabaseDataAccess.fetch(path: .checkpoints, completionHandler: completionHandler)
    }
}

fileprivate extension DatabaseDataAccess {
    
    static func fetch<T: FirebaseDecodable>(path: DatebaseRefPath, completionHandler: @escaping (Result<[T]>) -> Void) {
        let ref = path.reference
        ref.keepSynced(true)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.exists() {
                var resList = Array<T>()
                for res in snapshot.children.allObjects as! [DataSnapshot] {
                    if let entity = T(snapshot: res) {
                        resList.append(entity)
                    }
                }
                completionHandler(.success(resList))
                
            } else {
                completionHandler(.empty)
            }
        }, withCancel: { error in
            completionHandler(.failure(error))
        })
    }
}

