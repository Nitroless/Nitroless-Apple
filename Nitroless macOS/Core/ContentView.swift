//
//  ContentView.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI
import AppKit
import Combine

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State var isShown = false
    
    var body: some View {
        HStack {
            RepoView(viewModel: viewModel)
            if isShown {
                EmotesView(viewModel: viewModel)
            } else {
                List {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }.removeBackground()
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity
        ).onAppear {
            viewModel.allowAnimation()
            
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                self.isShown = NSApplication.shared.isActive
            }
            
        }.onDisappear {
            viewModel.killAnimation()
        }
    }
}
