//
//  ContentView.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI
import AppKit

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        HStack {
            RepoView(viewModel: viewModel)
            EmotesView(viewModel: viewModel)
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity
        )
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
