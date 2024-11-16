//
//  HouseViewRepresentable.swift
//  SkyWizard-SwiftUI
//
//  Created by Hishara Dilshan on 06/11/2024.
//

import Foundation
import SwiftUI
import SceneKit

struct HouseViewRepresentable: UIViewRepresentable {
    
    var lightIntensity: CGFloat
    var onRenderFinished: (() -> Void)?
    
    class Coordinator: NSObject, SCNSceneRendererDelegate {
        let sceneView = SCNView()
        let scene = SCNScene(named: "wizard_house.scn")!
        var houseNode: SCNNode?
        var lightNodeFirst: SCNNode?
        var lightNodeSecond: SCNNode?
        // Store the initial rotation angles for resetting later
        var initialRotation = SCNVector3Zero
        var didRenderScene: (() -> Void)?
        let impactGenerator = UIImpactFeedbackGenerator(style: .light)
        var lastHapticTime: Date = .now
        let hapticInterval: TimeInterval = 0.12
        
        override init() {
            super.init()
            guard let houseNode = scene.rootNode.childNode(withName: "RootNode", recursively: true) else {
                fatalError("House node not found")
            }
            
            guard let lightNodeFirst = scene.rootNode.childNode(withName: "omni1", recursively: true) else {
                fatalError("House node not found")
            }
            
            guard let lightNodeSecond = scene.rootNode.childNode(withName: "omni2", recursively: true) else {
                fatalError("House node not found")
            }
            
            sceneView.delegate = self
            
            self.houseNode = houseNode
            self.lightNodeFirst = lightNodeFirst
            self.lightNodeSecond = lightNodeSecond
            
            impactGenerator.prepare()
        }
        
        func renderer(_ renderer: any SCNSceneRenderer, didRenderScene scene: SCNScene, atTime time: TimeInterval) {
            guard let didRenderScene = self.didRenderScene else {
                fatalError("No didRenderScene closure set")
            }
            didRenderScene()
            sceneView.delegate = nil
        }
        
        @objc func pan(panGesture: UIPanGestureRecognizer) {
            let translation = panGesture.translation(in: sceneView)
            
            guard let houseNode else { return }
                
            switch panGesture.state {
            case .began:
                impactGenerator.prepare()
                // Store the initial rotation when the gesture begins
                initialRotation = houseNode.eulerAngles
                
            case .changed:
                // Calculate rotation angles based on pan translation
                let angleY = Float(translation.x) * .pi / 180
                
                // Apply rotation to the node
                houseNode.eulerAngles.y -= angleY
                
                // Reset translation to avoid compounded rotation
                panGesture.setTranslation(.zero, in: sceneView)
                
                if Date().timeIntervalSince(lastHapticTime) > hapticInterval {
                    impactGenerator.impactOccurred(intensity: 1)
                    lastHapticTime = .now
                }
                
            case .ended, .cancelled:
                // Reset rotation to the initial position when the gesture ends
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 1.0
                houseNode.eulerAngles = initialRotation
                SCNTransaction.commit()
                
                impactGenerator.impactOccurred()
            default:
                break
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    func makeUIView(context: Context) -> SCNView {
        let sceneView = context.coordinator.sceneView
        let scene = context.coordinator.scene
        
        context.coordinator.didRenderScene = {
            self.onRenderFinished?()
        }
        
        
        let camera = SCNCamera()
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 4.5, 28.5)
        scene.rootNode.addChildNode(cameraNode)
        
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.clear
        
        sceneView.addGestureRecognizer(UIPinchGestureRecognizer(target: context.coordinator, action: nil))
        sceneView.addGestureRecognizer(UIRotationGestureRecognizer(target: context.coordinator, action: nil))

        
        let panGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.pan))
        sceneView.addGestureRecognizer(panGesture)
        
        return sceneView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 1.0
        context.coordinator.lightNodeFirst?.light?.intensity = lightIntensity
        context.coordinator.lightNodeSecond?.light?.intensity = lightIntensity
        SCNTransaction.commit()
    }
}
