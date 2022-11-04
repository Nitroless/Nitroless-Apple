//
//  BottomBarItemView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImageWebPCoder

struct BottomBarItemView: View {
    var repo: Repo
    var selectRepo: () -> Void
    var selectedRepo: SelectedRepo?
    
    var body: some View {
        VStack {
            Button {
                self.selectRepo()
            } label: {
                let imgUrl = repo.url.appending(path: repo.repoData!.icon)
                WebImage(url: imgUrl)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .background(Color.theme.appBGSecondaryColor)
                    .frame(width: 40, height: 40)
                    .clipShape(RoundedRectangle(cornerRadius: selectedRepo == nil ? 99 : selectedRepo?.repo.url == repo.url ? 8 : 99, style: .continuous))
            }
            .padding(0)
            .frame(width: 48, height: 48)
            .buttonStyle(.plain)
            .contentShape(.contextMenuPreview, RoundedRectangle(cornerRadius: selectedRepo == nil && selectedRepo?.repo.url == repo.url ? 99 : selectedRepo?.repo.url == repo.url ? 8 : 99, style: .continuous))
            .shadow(radius: 5)
            
            Rectangle()
                .fill(.white)
                .frame(width: selectedRepo == nil ? 0 : selectedRepo?.repo.url == repo.url ? 32 : 0, height: 3)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .offset(y: 1)
                .opacity(selectedRepo == nil ? 0 : selectedRepo?.repo.url == repo.url ? 1 : 0)
        }
        .padding([.top, .horizontal], 5)
        .animation(.spring(), value: self.selectedRepo != nil && selectedRepo?.repo.url == repo.url)
    }
}
