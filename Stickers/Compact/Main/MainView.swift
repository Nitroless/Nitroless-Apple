//
//  MainView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-19.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                FrequentlyUsedView()
            }
        }
        .frame(height: 200)
        .padding(10)
    }
}
