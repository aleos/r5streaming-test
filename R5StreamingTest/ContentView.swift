//
//  ContentView.swift
//  R5StreamingTest
//
//  Created by Alexander Ostrovsky on 29.11.22.
//

import SwiftUI

struct ContentView: View {
    @State private var isShowingPublish = false
    
    var body: some View {
        VStack {
            NavigationLink(isActive: $isShowingPublish) { LiveView(liveStream: LiveStream()) } label: { EmptyView() }
            Button("Publish") { isShowingPublish = true }
                .font(.largeTitle)
                .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
