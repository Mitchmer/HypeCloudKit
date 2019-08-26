//
//  Hype.swift
//  Hype
//
//  Created by Mitch Merrell on 8/26/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

import Foundation
import CloudKit

struct Constants {
    static let recordTypeKey = "Hype"
    static let recordTextKey = "Text"
    static let recordTimestampKey = "Timestamp"
}

class Hype {
    let hypeText: String
    let timestamp: Date
    
    init(hypeText: String, timestamp: Date = Date()) {
        self.hypeText = hypeText
        self.timestamp = timestamp
    }
}

extension CKRecord {
    // Create a CKRecord from a Hype
    convenience init(hype: Hype) {
        // same as (Save) - Upload
        self.init(recordType: Constants.recordTypeKey)
        self.setValue(hype.hypeText , forKey: Constants.recordTextKey)
        self.setValue(hype.timestamp, forKey: Constants.recordTimestampKey)
    }
}

extension Hype {
    //Creating a Hype from a record. (Load)
    convenience init?(ckRecord: CKRecord) {
        guard let hypeText = ckRecord[Constants.recordTextKey] as? String, let timestamp = ckRecord[Constants.recordTimestampKey] as? Date else { return nil }
        self.init(hypeText: hypeText, timestamp: timestamp)
    }
}
