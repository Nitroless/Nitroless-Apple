//
//  HomeView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var repoMan: RepoManager
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    
    @Binding var toastShown: Bool
    
    var body: some View {
        VStack {
            if repoMan.favouriteEmotes.count > 0 {
                FavouriteEmotesView(emotes: repoMan.favouriteEmotes, toastShown: $toastShown, stickerFlag: false)
            }
            if repoMan.favouriteStickers.count > 0 {
                FavouriteEmotesView(emotes: repoMan.favouriteStickers, toastShown: $toastShown, stickerFlag: true)
            }
            FrequentUsedView(toastShown: $toastShown)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(10)
        .padding(.trailing, idiom == .pad && horizontalSizeClass == .regular ? 40 : 0)
        .padding(.leading, idiom == .pad && horizontalSizeClass == .regular ? 25 : 0)
    }
}
