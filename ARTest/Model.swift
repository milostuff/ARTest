//
//  Model.swift
//  ARTest
//
//  Created by Vian Martinez on 22/05/25.
//
import SwiftUI
import RealityKit
import Combine


enum ModelCategory: CaseIterable {
    case emoji
    case sticker
    
    var label: String {
        get {
            switch self {
            case .emoji:
                return "Emojis"
            case .sticker:
                return "Stickers"
            }
        }
    }
}

class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named:name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity(){
        let filename = self.name + ".usdz"
 
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error):
                    print("Unable to load modelEntity for \(filename).Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
                
            }, receiveValue: { modelEntity in
                
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded")
            })
    }
    
    
}


 struct Models {
    var all: [Model] = []

    init() {
        let emoji1 = Model(name: "catmoji", category: .emoji, scaleCompensation: 0.32/100)

        self.all += [emoji1]
        
        let sticker1 = Model(name: "sticker1", category: .sticker, scaleCompensation: 0.32/100)

        self.all += [sticker1]
    }
     
     func get(category: ModelCategory) -> [Model] {
         return all.filter({$0.category == category})
     }
 }

 
