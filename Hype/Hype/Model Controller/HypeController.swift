//
//  HypeController.swift
//  Hype
//
//  Created by Mitch Merrell on 8/26/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation
import CloudKit

class HypeController {
    // shared Instance
    static let shared = HypeController()
    // SOurce of truth
    var hypes: [Hype] = []
    let publicDB = CKContainer(identifier: "iCloud.com.mitchmerrell.Hype").publicCloudDatabase
    
    // CRUD functions
    
    //Create
    func saveHype(with text: String, completion: @escaping (Bool) -> Void) {
        let hype = Hype(hypeText: text)
        let hypeRecord = CKRecord(hype: hype)
        publicDB.save(hypeRecord) { ( _, error) in
            if let error = error {
                print("Error: \(error)), \(error.localizedDescription)")
                completion(false)
                return
            }
            self.hypes.append(hype)
            completion(true)
        }

    }
    
    // Read
    
    func fetchHypes(completion: @escaping (Bool) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Constants.recordTypeKey, predicate: predicate)
        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("Error: \(error)), \(error.localizedDescription)")
                completion(false)
                return
            }
            // are there records?
            guard let records = records else { completion(false); return }
            let hypes = records.compactMap({ Hype(ckRecord: $0)})
            self.hypes = hypes
            completion(true)
        }
    }
    
    // Update
    
    // Delete
}
