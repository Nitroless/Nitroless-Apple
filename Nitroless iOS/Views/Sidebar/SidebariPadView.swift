//
//  SidebariPadView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-11-21.
//

import SwiftUI

struct SidebariPadView: View {
    @EnvironmentObject var repoMan: RepoManager
    var showAddPrompt: () -> Void
    
    @State var urlToDelete: URL? = nil
    @State var showDeletePrompt = false
    @State var showBadRepoDeletePrompt = false
    @State var showDefaultReposMenu = false
    
    var body: some View {
            VStack {
                HStack {
                    Rectangle()
                        .fill(Color.theme.textColor)
                        .frame(width: 3, height: repoMan.selectedRepo == nil ? 32 : 0 )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .offset(x: -5)
                        .opacity(0)
                    
                    Button {
                        repoMan.selectHome()
                    } label: {
                        Image("Icon")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: repoMan.selectedRepo == nil ? 8 : 99, style: .continuous))
                            .shadow(radius: 5)
                            .offset(x: -6)
                    }
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .animation(.spring(), value: repoMan.selectedRepo == nil)
                
                if !repoMan.repos.isEmpty {
                    Divider()
                        .frame(width: 40)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(repoMan.repos, id: \.url) { repo in
                            if repo.repoData != nil {
                                SidebarItemView(repo: repo, removeRepo: { urlToDelete = repo.url
                                    showDeletePrompt = true
                                }, selectRepo: { repoMan.selectRepo(selectedRepo: SelectedRepo(active: true, repo: repo)) },  closeSidebar: { return }, selectedRepo: repoMan.selectedRepo)
                            } else {
                                Button {
                                    urlToDelete = repo.url
                                    showBadRepoDeletePrompt = true
                                } label: {
                                    HStack {
                                        Image(systemName: "exclamationmark.triangle")
                                            .resizable()
                                            .foregroundColor(.red)
                                            .frame(width: 28, height: 28)
                                    }
                                }
                                .buttonStyle(.plain)
                                .padding(0)
                                .frame(width: 48, height: 48)
                                .background(Color.theme.appBGColor)
                                .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                                .offset(x: -2)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: CGFloat(52 * repoMan.repos.count > 350 ? 350 : 52 * repoMan.repos.count))
                }
                
                Divider()
                    .frame(width: 40)
                
                Button {
                    self.showDefaultReposMenu = true
                } label: {
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(.plain)
                .frame(width: 48, height: 48)
                .background(Color.theme.appPrimaryColor)
                .clipShape(Circle())
                .shadow(radius: 5)
                .popover(isPresented: $showDefaultReposMenu,  attachmentAnchor: .rect(.rect(CGRect(x: -50, y: -30, width: 120, height: 120))) ,arrowEdge: .bottom) {
                    AddDefaultRepos(isShown: $showDefaultReposMenu)
                        .frame(width: 400, height: 512)
                }
                
                Button {
                    self.showAddPrompt()
                } label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color.white)
                }
                .buttonStyle(.plain)
                .frame(width: 48, height: 48)
                .background(Color.theme.appSuccessColor)
                .clipShape(Circle())
                .shadow(radius: 5)
            }
            .padding(.vertical, 10)
            .frame(width: 72)
            .background(Color.theme.appBGTertiaryColor)
            .confirmationDialog("Remove this broken repository?", isPresented: $showBadRepoDeletePrompt, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    repoMan.removeRepo(repo: urlToDelete!)
                }
            }
            .confirmationDialog("Are you sure you want to remove this Repo?", isPresented: $showDeletePrompt, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    repoMan.removeRepo(repo: urlToDelete!)
                }
            }
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
    }
}
