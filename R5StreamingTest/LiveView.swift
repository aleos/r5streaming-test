//
//  LiveView.swift
//  R5StreamingTest
//
//  Created by Alexander Ostrovsky on 29.11.22.
//

import SwiftUI

struct LiveView: View {
    @StateObject var liveStream: LiveStream
    
    var body: some View {
        ZStack {
            EmptyView()
        }
        .preferredColorScheme(.dark)
        .background(
            ZStack {
                liveStream.publishView
                    .ignoresSafeArea()
            }
        )
        .background(.black)
        .onAppear { liveStream.preview() }
        .onDisappear { liveStream.stop() }
    }
}

struct LiveView_Previews: PreviewProvider {
    static var previews: some View {
        LiveView(liveStream: LiveStream())
    }
}
