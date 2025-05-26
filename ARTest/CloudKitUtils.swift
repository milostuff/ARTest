//
//  CloudKitUtils.swift
//  ARTest
//
//  Created by mrvl on 23/05/25.
//

import ARKit
import CloudKit
import RealityKit
import Foundation
import RealityKit
import CloudKit
import simd

extension PlaneDetectorARView {
    func loadAndPlaceSavedTexts() {
        let db = CKContainer.default().publicCloudDatabase
        let query = CKQuery(recordType: "ARTextEntity", predicate: NSPredicate(value: true))

        db.perform(query, inZoneWith: nil) { [weak self] records, error in
            guard let self = self else { return }

            if let error = error {
                print("CloudKit fetch error: \(error.localizedDescription)")
                return
            }

            guard let records = records else {
                print("No records found.")
                return
            }

            DispatchQueue.main.async {
                for record in records {
                    guard
                        let text = record["text"] as? String,
                        let posX = record["posX"] as? Double,
                        let posY = record["posY"] as? Double,
                        let posZ = record["posZ"] as? Double,
                        let rotX = record["rotX"] as? Double,
                        let rotY = record["rotY"] as? Double,
                        let rotZ = record["rotZ"] as? Double,
                        let rotW = record["rotW"] as? Double,
                        let scale = record["scale"] as? Double
                    else {
                        print("Skipping invalid record.")
                        continue
                    }

                    let position = SIMD3<Float>(Float(posX), Float(posY), Float(posZ))
                    let rotation = simd_quatf(ix: Float(rotX), iy: Float(rotY), iz: Float(rotZ), r: Float(rotW))

                    let anchor = AnchorEntity(world: position)
                    anchor.orientation = rotation

                    let mesh = MeshResource.generateText(
                        text,
                        extrusionDepth: 0.02,
                        font: .systemFont(ofSize: 0.15),
                        containerFrame: .zero,
                        alignment: .center,
                        lineBreakMode: .byWordWrapping
                    )

                    let material = SimpleMaterial(color: .blue, isMetallic: false)
                    let textEntity = ModelEntity(mesh: mesh, materials: [material])
                    textEntity.scale = SIMD3<Float>(repeating: Float(scale))

                    // Offset to appear centered
                    textEntity.setPosition([0, 0.05, 0], relativeTo: anchor)

                    anchor.addChild(textEntity)
                    self.scene.addAnchor(anchor)
                }
            }
        }
    }
}

func saveToCloudKit(_ text: String, position: SIMD3<Float>, rotation: simd_quatf, scale: Float) {
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
    
    let db = CKContainer.init(identifier: "iCloud.com.luckystrike.fundalize" ).publicCloudDatabase
    db.save(record) { _, error in
        if let error = error {
            print("CloudKit Save Failed: \(error.localizedDescription)")
        } else {
            print("Saved AR text to CloudKit ✅")
        }
    }
}
