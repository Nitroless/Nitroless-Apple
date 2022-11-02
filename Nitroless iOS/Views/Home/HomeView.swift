//
//  HomeView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

struct HomeView: View {
    var repoMan: RepoManager
    
    var body: some View {
        VStack {
            FrequentUsedView(repoMan: repoMan)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(10)
    }
}
