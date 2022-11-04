//
//  HomeView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var repoMan: RepoManager
    
    @Binding var toastShown: Bool
    
    var body: some View {
        VStack {
            ForEach(repoMan.repos, id: \.url) { repo in
                if repo.favouriteEmotes != nil && repo.favouriteEmotes!.count > 0 {
                    FavouriteEmotesView(repoName: repo.repoData!.name, emotes: repo.favouriteEmotes!, repoURL: repo.url, toastShown: $toastShown)
                }
            }
            FrequentUsedView(toastShown: $toastShown)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(10)
    }
}
