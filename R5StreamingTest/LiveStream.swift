//
//  LiveStream.swift
//  R5StreamingTest
//
//  Created by Alexander Ostrovsky on 29.11.22.
//

import AVFoundation
import Foundation

@MainActor class LiveStream: ObservableObject {
    enum State { case settings, countdown, stream, end, stats }
        
    // View
    
    @Published private(set) var publishView: PublishView
    @Published private(set) var state: State = .settings
    
    // Camera
    
    @Published private(set) var cameraIsOn = true
    @Published private(set) var microphoneIsOn = true
    @Published private(set) var selectedCamera: AVCaptureDevice.Position = .back
    
    private var publish = Publish()
    
    init() {
        publishView = PublishView(controller: publish.publishViewController)
    }
    
    func preview() {
        publish.preview()
    }
    
    func stop() {
        publish.stop()
    }
    
    // MARK: Intents
    
    func onStartStream(_ title: String, category: String) async throws {
        state = .countdown
    }
    
    func onFinalCountdown() {
        state = .stream
        publish.start(stream: "R5StreamingTestStream")
    }
    
    func onEndStream() {
        state = .end
    }
    
    func onEndStreamConfirm(cancel: Bool = false) {
        state = cancel ? .stream : .stats
        if !cancel {
            publish.stop()
        }
    }
            
    // MARK: Camera Control
    
    func turnCamera(on: Bool) {
        cameraIsOn = on
    }
    
    func turnMicrophone(on: Bool) {
        microphoneIsOn = on
    }
    
    func switchCamera(to position: AVCaptureDevice.Position) {
        selectedCamera = position
    }
}
