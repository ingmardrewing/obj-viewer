//
//  ContentView.swift
//  Shared
//
//  Created by private on 23.12.20.
//

import SwiftUI
import SceneKit

struct ContentView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var scene = SCNScene(named: "TestScene.scn")

    var cameraNode: SCNNode? {
            scene?.rootNode.childNode(withName: "camera", recursively: false)
    }
    var light: SCNNode? {
            scene?.rootNode.childNode(withName: "light", recursively: false)
    }
    
    func up () {
        SCNTransaction.animationDuration = 1

        SCNTransaction.begin()
        light?.position.y = 0.5
        SCNTransaction.commit()
    }
    
    func down () {
        SCNTransaction.animationDuration = 1
        SCNTransaction.begin()
        light?.position.y = -0.5
        SCNTransaction.commit()
    }
    
    var body: some View {
        VStack {
            SceneView(
                    scene: scene,
                    pointOfView: cameraNode,
                    options: [.allowsCameraControl]
            ).onReceive(timer){ _ in
                if (self.light?.position.y == 0.5 ) {
                    self.down()
                }
                else {
                    self.up()
                }
            }

        }
    }
}

