//
//  ContentView.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI
import AppKit
import AlertToast

struct ContentView: View {
    @Environment (\.colorScheme) var cs
    let pasteboard = NSPasteboard.general
    @StateObject var viewModel = ContentViewModel()
    @State var isShown = true
    @State var hovered = Hovered(image: "", hover: false)
    
    var body: some View {
        ZStack(alignment: .leading) {
            RepoView(viewModel: viewModel)
                .zIndex(1)
            
            if isShown {
                HStack {
                    Text("")
                        .frame(width: 80)
                    VStack {
                        VStack {
                            Image(cs == .dark ? "banner" : "bannerDark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                            
                            if !viewModel.selectedRepo.active {
                                HStack(alignment: .center) {
                                    Button {
                                        viewModel.makeAllReposInactive()
                                    } label: {
                                        VStack {
                                            Text("Home")
                                        }
                                        .frame(width: 64)
                                        .foregroundColor((self.hovered.image == "Home" && self.hovered.hover == true) || viewModel.isHomeActive == true ? Color.white : Color.theme.textColor)
                                        .padding(10)
                                        .background((self.hovered.image == "Home" && self.hovered.hover == true) || viewModel.isHomeActive == true ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .animation(.spring(), value: self.hovered.hover && viewModel.isHomeActive == false)
                                        .shadow(radius: 5)
                                    }
                                    .buttonStyle(.plain)
                                    .onHover { isHovered in
                                        self.hovered = Hovered(image: "Home", hover: isHovered)
                                    }
                                    
                                    Button {
                                        viewModel.makeAboutActive()
                                    } label: {
                                        VStack {
                                            Text("About")
                                        }
                                        .frame(width: 64)
                                        .foregroundColor((self.hovered.image == "About" && self.hovered.hover == true) || viewModel.isAboutActive == true ? Color.white : Color.theme.textColor)
                                        .padding(10)
                                        .background((self.hovered.image == "About" && self.hovered.hover == true) || viewModel.isAboutActive == true ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .animation(.spring(), value: self.hovered.hover && viewModel.isAboutActive == false)
                                        .shadow(radius: 5)
                                    }
                                    .buttonStyle(.plain)
                                    .onHover { isHovered in
                                        self.hovered = Hovered(image: "About", hover: isHovered)
                                    }
                                    
                                    Button {
                                        viewModel.askBeforeExiting()
                                    } label: {
                                        VStack {
                                            Text("Quit App")
                                        }
                                        .frame(width: 64)
                                        .foregroundColor(self.hovered.image == "Quit" && self.hovered.hover == true ? Color.white : Color.theme.textColor)
                                        .padding(10)
                                        .background(self.hovered.image == "Quit" && self.hovered.hover == true ? Color.theme.appDangerColor : Color.theme.appBGColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .animation(.spring(), value: self.hovered.hover)
                                        .shadow(radius: 5)
                                    }
                                    .buttonStyle(.plain)
                                    .onHover { isHovered in
                                        self.hovered = Hovered(image: "Quit", hover: isHovered)
                                    }
                                }
                            } else {
                                HStack {
                                    Button {
                                        viewModel.showToast = true
                                        pasteboard.clearContents()
                                        pasteboard.setString(String("Check out this awesome Repo \(viewModel.selectedRepo.emote.name) - \(viewModel.selectedRepo.url)"), forType: NSPasteboard.PasteboardType.string)
                                    } label: {
                                        HStack {
                                            Image(systemName: "square.and.arrow.up.fill")
                                            Text("Share")
                                        }
                                        .frame(width: 100)
                                        .foregroundColor(self.hovered.image == "square.and.arrow.up.fill" && self.hovered.hover == true ? Color.white : Color.theme.textColor)
                                        .padding(10)
                                        .background(self.hovered.image == "square.and.arrow.up.fill" && self.hovered.hover == true ? Color.theme.appPrimaryColor : Color.theme.appBGColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .animation(.spring(), value: self.hovered.hover)
                                        .shadow(radius: 5)
                                    }
                                    .buttonStyle(.plain)
                                    .onHover { isHovered in
                                        self.hovered = Hovered(image: "square.and.arrow.up.fill", hover: isHovered)
                                    }

                                    Button {
                                        viewModel.removeFromUserDefaults(url: viewModel.selectedRepo.url)
                                        viewModel.deselectRepo()
                                        viewModel.makeAllReposInactive()
                                    } label: {
                                        HStack {
                                            Image(systemName: "minus.circle.fill")
                                            Text("Remove")
                                        }
                                        .frame(width: 100)
                                        .foregroundColor(self.hovered.image == "minus.circle.fill" && self.hovered.hover == true ? Color.white : Color.theme.textColor)
                                        .padding(10)
                                        .background(self.hovered.image == "minus.circle.fill" && self.hovered.hover == true ? Color.theme.appDangerColor : Color.theme.appBGColor)
                                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                                        .animation(.spring(), value: self.hovered.hover)
                                        .shadow(radius: 5)
                                    }
                                    .buttonStyle(.plain)
                                    .onHover { isHovered in
                                        self.hovered = Hovered(image: "minus.circle.fill", hover: isHovered)
                                    }
                                }
                            }
                            
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(20)
                        .background(Color.theme.appBGTertiaryColor.opacity(0.6))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                        .padding(.top)
                        .padding(.trailing, 40)
                        .padding(.leading, 10)
                        
                        EmotesView(viewModel: viewModel)
                    }
                }
                .zIndex(-1)
                
            } else {
                HStack {
                    Text("")
                        .frame(width: 80)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Image("banner")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(20)
                        .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                        
                        VStack {
                            Text("Nitroless got inactive\nClick to Reactivate")
                                .multilineTextAlignment(.center)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(20)
                        .background(Color.theme.appBGTertiaryColor.opacity(0.6))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                    }
                    .padding(.top)
                    .padding(.trailing, 40)
                    .padding(.leading, 10)
                }
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity
               
        ).onAppear {
            viewModel.allowAnimation()
            
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                self.isShown = NSApplication.shared.isActive
            }
            
        }.onDisappear {
            viewModel.killAnimation()
        }
    }
}
