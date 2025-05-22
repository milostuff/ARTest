//
//  ContentView.swift
//  ARTest
//
//  Created by Vian Martinez on 20/05/25.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import Combine

struct ContentView: View {
    //Text Input variables
    @State private var arText: String = "Hello AR!"
    @State private var scale: Float = 1.0

    @State private var showTextInputView: Bool = false
    
    @State private var isButtonVisible: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(text: $arText, scale: $scale)
            if(isButtonVisible){
                ControlView(showText: $showTextInputView)
            }
            
            if(showTextInputView) {
                InputTextView(arText: $arText, scale: $scale)
            }
        }
        .onTapGesture {
            isButtonVisible.toggle()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

class PlaneDetectorARView: ARView {
    var currentText: String = "Hello AR!"
    var focusEntity: FocusEntity?
    var placedTextEntity: ModelEntity?
    var cancellables: Set<AnyCancellable> = []
    
    init() {
        super.init(frame: .zero)
        // ActionStrean
        subscribeToActionStream()
        
        // FocusEntity
        self.focusEntity = FocusEntity(on: self, style: .classic(color: .yellow))
        
        // Configuration
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.meshWithClassification) {
            config.sceneReconstruction = .meshWithClassification
        }
        
        self.session.run(config)
    }
    
    func subscribeToActionStream() { ActionManager.shared
            .actionStream
            .sink { [weak self] action in
                
                switch action {
                case .place3DModel:
                    self?.place3DModel()
                case .rotateLeft:
                    self?.rotatePlacedText(by: -15) // rotate left
                case .rotateRight:
                    self?.rotatePlacedText(by: 15) // rotate right
                }
            }
            .store(in: &cancellables)
    }
    
    func scalePlacedText(by factor: Float) {
        guard let textEntity = placedTextEntity else { return }

        let currentScale = textEntity.transform.scale
        let newScale = SIMD3<Float>(
            x: currentScale.x * factor,
            y: currentScale.y * factor,
            z: currentScale.z * factor
        )
        
        textEntity.transform.scale = newScale
    }

    
    func rotatePlacedText(by degrees: Float) {
        guard let textEntity = placedTextEntity else { return }
        
        let rotation = simd_quatf(angle: degrees * (.pi / 180), axis: [0, 1, 0])
        textEntity.transform.rotation *= rotation
    }
    
    func updatePlacedTextScale(to newScale: Float) {
        placedTextEntity?.transform.scale = SIMD3<Float>(repeating: newScale)
    }
    
    func place3DModel() {
        guard let focusEntity = self.focusEntity else { return }
        
        let anchorEntity = AnchorEntity(world: focusEntity.position)
        
        let mesh = MeshResource.generateText(
            currentText,
            extrusionDepth: 0.02,
            font: .systemFont(ofSize: 0.15),
            containerFrame: .zero,
            alignment: .center,
            lineBreakMode: .byWordWrapping
        )
        let material = SimpleMaterial(color: .blue, isMetallic: false)
        let textEntity = ModelEntity(mesh: mesh, materials: [material])
        
        if let bounds = textEntity.model?.mesh.bounds {
            let centerOffset = bounds.extents / 2
            textEntity.position = [-centerOffset.x, -centerOffset.y, -centerOffset.z]
        }
        
        // Parent for rotation at center
        let parentEntity = ModelEntity()
        parentEntity.addChild(textEntity)
        
        placedTextEntity = parentEntity
        // store parent so rotation works cleanly
        
        anchorEntity.addChild(parentEntity)
        self.scene.addAnchor(anchorEntity)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @MainActor required dynamic init(frame frameRect: CGRect) {
        fatalError("init(frame:) has not been implemented")
    }
}

enum Actions {
    case place3DModel
    case rotateLeft
    case rotateRight}

class ActionManager {
    static let shared = ActionManager()
    
    private init() { }
    
    var actionStream = PassthroughSubject<Actions, Never>()
}

struct ARViewContainer: UIViewRepresentable{
    @Binding var text: String
    @Binding var scale: Float
    
    func makeUIView(context: Context) -> PlaneDetectorARView {
        let view = PlaneDetectorARView()
        view.currentText = text // pass initial text
        return view
    }
    
    func updateUIView(_ uiView: PlaneDetectorARView, context: Context) {
        uiView.currentText = text // keep it in sync
        uiView.updatePlacedTextScale(to: scale)
    }
}


//#Preview {
//    ContentView()
//}
