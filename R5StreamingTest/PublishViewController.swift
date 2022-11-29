//
//  PublishViewController.swift
//  R5StreamingTest
//
//  Created by Alexander Ostrovsky on 29.11.22.
//

import Foundation
import SwiftUI

#if !targetEnvironment(simulator)

import R5Streaming

class PublishViewController: R5VideoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AVAudioSession.sharedInstance().requestRecordPermission { (gotPerm: Bool) -> Void in
            
        };
    }
}

extension PublishViewController: R5StreamDelegate {
    func onR5StreamStatus(_ stream: R5Stream!, withStatus statusCode: Int32, withMessage msg: String!) {
        let s = String(format: "Publish Status: %s (%@)", r5_string_for_status(statusCode), msg)
        print(s)
    }
}

#else

class PublishViewController: UIViewController { }

#endif

struct PublishView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    let controller: UIViewController
    
    func makeUIViewController(context: Context) -> UIViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}
