//
//  SidebarView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

struct SidebarView: View {
    var repoMan: RepoManager
    var showDefaultReposMenu: () -> Void
    var showAddPrompt: () -> Void
    var closeSidebar: () -> Void
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Rectangle()
                        .fill(.white)
                        .frame(width: 3, height: repoMan.selectedRepo == nil ? 32 : 0 )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .offset(x: -7)
                        .opacity(repoMan.selectedRepo == nil ? 1 : 0)
                    
                    Button {
                        repoMan.selectHome()
                        closeSidebar()
                    } label: {
                        Image("Icon")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: repoMan.selectedRepo == nil ? 8 : 99, style: .continuous))
                            .shadow(radius: 5)
                            .offset(x: -8)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .animation(.spring(), value: repoMan.selectedRepo == nil)
                
                if !repoMan.repos.isEmpty {
                    Divider()
                        .frame(width: 40)
                        .offset(x: -2)
                }
                
                
                ForEach(repoMan.repos, id: \.url) { repo in
                    SidebarItemView(repo: repo, removeRepo: { repoMan.removeRepo(repo: repo.url) }, selectRepo: { repoMan.selectRepo(selectedRepo: SelectedRepo(active: true, repo: repo)) },  closeSidebar: { self.closeSidebar() }, selectedRepo: repoMan.selectedRepo)
                }
                
                Divider()
                    .frame(width: 40)
                    .offset(x: -2)
                
                Button {
                    self.showDefaultReposMenu()
                } label: {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
                .buttonStyle(.plain)
                .frame(width: 48, height: 48)
                .background(Color.theme.appPrimaryColor)
                .clipShape(Circle())
                .shadow(radius: 5)
                .offset(x: -2)
                
                Button {
                    self.showAddPrompt()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                }
                .buttonStyle(.plain)
                .frame(width: 48, height: 48)
                .background(Color.theme.appSuccessColor)
                .clipShape(Circle())
                .shadow(radius: 5)
                .offset(x: -2)
            }
        }
        .padding(.top, 10)
        .padding(.leading, 0)
        .frame(width: 75)
        .background(Color.theme.appBGTertiaryColor)
    }
}
