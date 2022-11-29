//
//  Publish.swift
//  R5StreamingTest
//
//  Created by Alexander Ostrovsky on 29.11.22.
//

import Foundation

#if !targetEnvironment(simulator)

import R5Streaming

class Publish: ObservableObject {
    @Published private(set) var isPublishing = false
    
    let publishViewController = PublishViewController()
    
    static private let config: R5Configuration = {
        let config = R5Configuration()
        config.host = ""
        config.port = 8554
        config.contextName = "live"
        config.licenseKey = ""
        return config
    }()
    private var stream: R5Stream?
    
    init() {
        r5_set_log_level((Int32)(r5_log_level_debug.rawValue))
    }
    
    func preview() {
        stream = Self.makeCameraStream(config: Self.config)
        stream?.delegate = publishViewController
        
        publishViewController.attach(stream)
        publishViewController.showPreview(true)
        publishViewController.showDebugInfo(true)
    }
    
    func start(stream name: String) {
        guard !isPublishing else { return }
        isPublishing = true
        
        publishViewController.showPreview(false)
        stream?.publish(name, type: R5RecordTypeLive)
    }
    
    func stop() {
        guard isPublishing else { return }
        isPublishing = false
        
        stream?.stop()
        stream?.delegate = nil
        preview()
    }
    
    private static func makeCameraStream(config: R5Configuration) -> R5Stream? {
        let videoDevice = AVCaptureDevice.default(for: .video)
        let camera = R5Camera(device: videoDevice, andBitRate: 1000)
        camera?.width = Int32(UIScreen.main.bounds.width)
        camera?.height = Int32(UIScreen.main.bounds.height)
        
        let audioDevice = AVCaptureDevice.default(for: .audio)
        let microphone = R5Microphone(device: audioDevice)
        
        let connection = R5Connection(config: Self.config)
        
        let stream = R5Stream(connection: connection)
        stream?.attachVideo(camera)
        stream?.attachAudio(microphone)
        
        return stream
    }
}

#else

import UIKit

class Publish: ObservableObject {
    @Published private(set) var isPublishing = false
    
    let publishViewController = UIViewController()
    
    let useDefaultStreamName = true
    
    func preview() { }
    
    func start(stream name: String) {
        isPublishing = true
    }
    
    func stop() {
        isPublishing = false
    }
}

#endif
