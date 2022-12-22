//
//  BottomBarElementView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-22.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImageWebPCoder

struct BottomBarElementView: View {
    @EnvironmentObject var mvc: MessagesViewController
    @EnvironmentObject var repoMan: RepoManager
    
    var buttonAction: () -> Void
    var webImage: URL?
    var repo: Repo?
    
    var body: some View {
        VStack {
            Button {
                buttonAction()
            } label: {
                WebImage(url: webImage)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .background(Color.theme.appBGSecondaryColor)
                    .frame(width: 30, height: 30)
                    .clipShape(RoundedRectangle(cornerRadius: repoMan.selectedRepo == nil ? 99 : repoMan.selectedRepo?.repo.url == repo?.url ? 8 : 99, style: .continuous))
            }
            Rectangle()
                .fill(Color.theme.textColor)
                .frame(width: repoMan.selectedRepo == nil ? 0 : repoMan.selectedRepo?.repo.url == repo?.url ? 28 : 0, height: 3)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .opacity(repoMan.selectedRepo == nil ? 0 : repoMan.selectedRepo?.repo.url == repo?.url ? 1 : 0)
        }
        .padding(.horizontal, 5)
        .padding(.leading, 10)
        .animation(.spring(), value: repoMan.selectedRepo != nil && repoMan.selectedRepo?.repo.url == repo?.url)
    }
}
