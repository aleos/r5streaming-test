//
//  LiveStream.swift
//  R5StreamingTest
//
//  Created by Alexander Ostrovsky on 29.11.22.
//

import AVFoundation
import Foundation

@MainActor class LiveStream: ObservableObject {
    
    enum State { case stream, end }
        
    // View
    
    @Published private(set) var publishView: PublishView
    @Published private(set) var state: State = .end
    
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
    
    func onStartStream() {
        state = .stream
        publish.start(stream: "R5StreamingTestStream")
    }
    
    func onEndStream() {
        state = .end
        publish.stop()
    }
}
