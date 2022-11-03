//
//  ContentView.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import SwiftUI
import SDWebImageSwiftUI
import SDWebImageWebPCoder
import AlertToast

struct ContentView: View {
    @EnvironmentObject var repoMan: RepoManager
    @State var urlToAdd: String = ""
    @State var showAddPrompt = false
    @State var urlInvalidError = false
    @State var toastShown = false
    @State var showDefaultReposMenu = false
    @State var sheetDetent: PresentationDetent = .medium
    @State var urlToDelete: URL? = nil
    @State var showDeletePrompt = false
    @State private var offset: CGFloat = 0
    @State private var sidebarOpened: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .leading) {
                SidebarView(repoMan: repoMan, showDefaultReposMenu: { toggleShowDefaultReposMenu() }, showAddPrompt: { toggleShowAddPrompt() }, closeSidebar: { closeSidebar() })
                ScrollView {
                    if repoMan.selectedRepo == nil {
                        HomeView(repoMan: repoMan)
                    } else {
                        RepoView(toastShown: $toastShown, repo: repoMan.selectedRepo!.repo)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .background(Color.theme.appBGColor)
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            if value.translation.height > 0 {
                                 return
                            } else {
                                 return
                            }
                            if value.translation.width > 0 {
                                self.offset = value.translation.width
                            } else {
                                self.offset = 72 + value.translation.width
                            }
                        })
                        .onEnded({ value in
                            if value.translation.width > 0 {
                                if value.translation.width > 5 {
                                    openSidebar()
                                }
                            } else {
                                closeSidebar()
                            }
                        })
                )
                .animation(.spring().speed(1.5), value: self.offset)
                .toolbar {
                    ToolbarItemGroup(placement: .principal) {
                        HStack {
                            Button {
                                if self.offset == 0 {
                                    openSidebar()
                                } else if self.offset == 72 {
                                    closeSidebar()
                                }
                            } label: {
                                if !self.sidebarOpened {
                                    VStack(spacing: 4) {
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 20, height: 2)
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 20, height: 2)
                                        RoundedRectangle(cornerRadius: 5)
                                            .frame(width: 20, height: 2)
                                    }
                                } else {
                                    Image(systemName: "arrow.left")
                                        .frame(width: 20)
                                }
                            }
                            .buttonStyle(.plain)
                            .offset(x: 8)
                            .animation(.spring().speed(1.5), value: self.sidebarOpened)
                            
                            Spacer()
                            
                            Text("Nitroless")
                                .font(.custom("Uni Sans", size: 32))
                                .offset(x: repoMan.selectedRepo == nil ? 2 : 19)
                            
                            Spacer()
                            
                            if repoMan.selectedRepo == nil {
                                NavigationLink {
                                    AboutView()
                                } label: {
                                    Image(systemName: "info.circle")
                                        .foregroundColor(Color.theme.appPrimaryColor)
                                }
                                .buttonStyle(.plain)
                            } else {
                                HStack {
                                    ShareLink(item: repoMan.selectedRepo!.repo.url, subject: Text(repoMan.selectedRepo!.repo.repoData!.name), message: Text("Check out this Awesome Repo")) {
                                        Image(systemName: "square.and.arrow.up.circle")
                                            .foregroundColor(Color.theme.appPrimaryColor)
                                    }
                                    .buttonStyle(.plain)
                                    
                                    Button {
                                        urlToDelete = repoMan.selectedRepo!.repo.url
                                        showDeletePrompt = true
                                    } label: {
                                        Image(systemName: "trash.circle")
                                            .foregroundColor(Color.theme.appDangerColor)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                    }
                }
                .toolbarBackground(Color.theme.appBGTertiaryColor, for: .navigationBar)
            }
            .sheet(isPresented: $showDefaultReposMenu) {
                AddDefaultRepos(isShown: $showDefaultReposMenu, detent: $sheetDetent)
                    .presentationDetents([.fraction(0.3), .large],
                                         selection: $sheetDetent.animation(.easeInOut(duration: 0.2)))
            }
            .alert("Add Repository", isPresented: $showAddPrompt) {
                TextField("Repository URL", text: $urlToAdd)

                Button("Add", role: .none) {
                    if let url = URL(string: urlToAdd) {
                        if repoMan.addRepo(repo: url.absoluteString) {} else {
                            urlInvalidError = true
                        }
                    } else {
                        urlInvalidError = true
                    }

                    urlToAdd = ""
                }

                Button("Cancel", role: .cancel) {urlToAdd = ""}
            } message: {
                Text("Please enter the URL of a Nitroless Repository")
            }
            .alert("Invalid URL", isPresented: $urlInvalidError) {
                Button("Dismiss", role: .cancel) {}
            } message: {
                Text("Please check the URL and try again.")
            }
            .onOpenURL { url in
                handleUrl(url)
            }
            .confirmationDialog("Are you sure you want to remove this Repo?", isPresented: $showDeletePrompt, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    repoMan.selectHome()
                    repoMan.removeRepo(repo: urlToDelete!)
                }
            }
        }
        .toast(isPresenting: $toastShown) {
            AlertToast(displayMode: .hud, type: .systemImage("checkmark", Color.theme.appSuccessColor), title: "Copied!", style: AlertToast.AlertStyle.style(backgroundColor: Color.theme.appBGTertiaryColor, titleColor: .white))
        }
    }
    
    func closeSidebar() {
        self.offset = 0
        self.sidebarOpened = false
    }
    
    func openSidebar() {
        self.offset = 72
        self.sidebarOpened = true
    }
    
    func toggleShowDefaultReposMenu() {
        self.showDefaultReposMenu = !self.showDefaultReposMenu
    }
    
    func toggleShowAddPrompt() {
        self.showAddPrompt = !self.showAddPrompt
    }
    
    func handleUrl(_ url: URL) {
        var str = url.absoluteString
        str = str.replacingOccurrences(of: "nitroless://", with: "https://nitroless.github.io/")
        let comp = URLComponents(string: str)!
        let path = comp.path.dropFirst()
        
        switch path {
        case "add-repository":
            guard let urlparam = comp.queryItems?.filter({ item in item.name == "url"}).first else { return }
            guard let param = urlparam.value else { return }
            
            urlToAdd = param
            showAddPrompt = true
        default:
            return;
        }
    }
}
