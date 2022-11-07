//
//  HomeView.swift
//  Nitroless macOS
//
//  Created by Paras KCD on 2022-10-09.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: ContentViewModel
    
    var body: some View {
        VStack {
            if(viewModel.isAboutActive) {
                AboutView()
            } else {
                HomeChildView(viewModel: viewModel)
            }
        }
    }
}
