//
//  CloudKitUtils.swift
//  ARTest
//
//  Created by mrvl on 23/05/25.
//

import ARKit
import CloudKit

func saveToCloudKit(_ text: String, position: SIMD3<Float>, rotation: simd_quatf, scale: Float) {
    print("App ID: \(Bundle.main.bundleIdentifier ?? "Unknown")")
    print("Container: \(CKContainer.default().containerIdentifier ?? "Default container")")
    
    let record = CKRecord(recordType: "ARTextEntity")
    
    record["text"] = text as CKRecordValue
    record["posX"] = Double(position.x) as CKRecordValue
    record["posY"] = Double(position.y) as CKRecordValue
    record["posZ"] = Double(position.z) as CKRecordValue
    
    record["rotX"] = Double( rotation.vector.x) as CKRecordValue
    record["rotY"] = Double( rotation.vector.y) as CKRecordValue
    record["rotZ"] = Double( rotation.vector.z) as CKRecordValue
    record["rotW"] = Double(rotation.vector.w )as CKRecordValue
    
    record["scale"] = Double(scale) as CKRecordValue
    
    let db = CKContainer.init(identifier: "iCloud.com.luckystrike.fundalize", ).publicCloudDatabase
    db.save(record) { _, error in
        if let error = error {
            print("CloudKit Save Failed: \(error.localizedDescription)")
        } else {
            print("Saved AR text to CloudKit ✅")
        }
    }
}
