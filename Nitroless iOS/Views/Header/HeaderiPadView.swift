//
//  HeaderiPadView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-11-21.
//

import SwiftUI

struct HeaderiPadView: View {
    @Environment (\.colorScheme) var cs
    @EnvironmentObject var repoMan: RepoManager
    @EnvironmentObject var viewModel: HeaderViewModel
    @State var urlToDelete: URL? = nil
    @State var showDeletePrompt = false
    
    var body: some View {
        VStack {
            Image(cs == .dark ? "banner" : "bannerDark")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
            
            if repoMan.selectedRepo == nil {
                HStack {
                    Button {
                        viewModel.isAboutActive = false
                        viewModel.isKeyboardSettingsActive = false
                    } label: {
                        VStack {
                            Text("Home")
                        }
                        .frame(width: 100)
                        .foregroundColor((viewModel.hovered.image == "Home" && viewModel.hovered.hover == true) || viewModel.isAboutActive == false && viewModel.isKeyboardSettingsActive == false ? Color.white : Color.theme.textColor)
                        .padding(10)
                        .background((viewModel.hovered.image == "Home" && viewModel.hovered.hover == true) || viewModel.isAboutActive == false && viewModel.isKeyboardSettingsActive == false ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .animation(.spring(), value: viewModel.hovered.hover && viewModel.isAboutActive == false && viewModel.isKeyboardSettingsActive == false)
                        .shadow(radius: 5)
                    }
                    .buttonStyle(.plain)
                    .onHover { isHovered in
                        viewModel.hovered = Hovered(image: "Home", hover: isHovered)
                    }
                    
                    Button {
                        viewModel.isAboutActive = true
                        viewModel.isKeyboardSettingsActive = false
                    } label: {
                        VStack {
                            Text("About")
                        }
                        .frame(width: 100)
                        .foregroundColor((viewModel.hovered.image == "About" && viewModel.hovered.hover == true) || viewModel.isAboutActive == true && viewModel.isKeyboardSettingsActive == false ? Color.white : Color.theme.textColor)
                        .padding(10)
                        .background((viewModel.hovered.image == "About" && viewModel.hovered.hover == true) || viewModel.isAboutActive == true && viewModel.isKeyboardSettingsActive == false ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .animation(.spring(), value: viewModel.hovered.hover && viewModel.isAboutActive == false)
                        .shadow(radius: 5)
                    }
                    .buttonStyle(.plain)
                    .onHover { isHovered in
                        viewModel.hovered = Hovered(image: "About", hover: isHovered)
                    }
                    
                    Button {
                        viewModel.isAboutActive = false
                        viewModel.isKeyboardSettingsActive = true
                    } label: {
                        VStack {
                            Text("Settings")
                        }
                        .frame(width: 100)
                        .foregroundColor((viewModel.hovered.image == "Settings" && viewModel.hovered.hover == true) || viewModel.isAboutActive == false && viewModel.isKeyboardSettingsActive == true ? Color.white : Color.theme.textColor)
                        .padding(10)
                        .background((viewModel.hovered.image == "Settings" && viewModel.hovered.hover == true) || viewModel.isAboutActive == false && viewModel.isKeyboardSettingsActive == true ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .animation(.spring(), value: viewModel.hovered.hover && viewModel.isAboutActive == false)
                        .shadow(radius: 5)
                    }
                    .buttonStyle(.plain)
                    .onHover { isHovered in
                        viewModel.hovered = Hovered(image: "Settings", hover: isHovered)
                    }
                }
            } else {
                HStack {
                    ShareLink(item: repoMan.selectedRepo!.repo.url, subject: Text(repoMan.selectedRepo!.repo.repoData!.name), message: Text("Check out this Awesome Repo")) {
                        HStack {
                            Image(systemName: "square.and.arrow.up.fill")
                            Text("Share")
                        }
                        .frame(width: 100)
                        .foregroundColor(viewModel.hovered.image == "Share" && viewModel.hovered.hover == true ? Color.white : Color.theme.textColor)
                        .padding(10)
                        .background(viewModel.hovered.image == "Share" && viewModel.hovered.hover == true ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .animation(.spring(), value: viewModel.hovered.hover)
                        .shadow(radius: 5)
                    }
                    .onHover { isHovered in
                        viewModel.hovered = Hovered(image: "Share", hover: isHovered)
                    }
                    
                    Button {
                        urlToDelete = repoMan.selectedRepo!.repo.url
                        showDeletePrompt = true
                    } label: {
                        HStack {
                            Image(systemName: "minus.circle.fill")
                            Text("Delete")
                        }
                        .frame(width: 100)
                        .foregroundColor(viewModel.hovered.image == "Remove" && viewModel.hovered.hover == true ? Color.white : Color.theme.textColor)
                        .padding(10)
                        .background(viewModel.hovered.image == "Remove" && viewModel.hovered.hover == true ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .animation(.spring(), value: viewModel.hovered.hover)
                        .shadow(radius: 5)
                    }
                    .buttonStyle(.plain)
                    .onHover { isHovered in
                        viewModel.hovered = Hovered(image: "Remove", hover: isHovered)
                    }
                }
                
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(20)
        .background(Color.theme.appBGTertiaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
        .padding(.top, 10)
        .padding(.horizontal, 15)
        .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
        .padding(.top)
        .padding(.trailing, 50)
        .padding(.leading, 35)
        .confirmationDialog("Are you sure you want to remove this Repo?", isPresented: $showDeletePrompt, titleVisibility: .visible) {
            Button("Remove", role: .destructive) {
                repoMan.selectHome()
                repoMan.removeRepo(repo: urlToDelete!)
            }
        }
    }
}
