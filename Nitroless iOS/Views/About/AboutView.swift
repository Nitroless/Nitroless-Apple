//
//  AboutView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI
import SDWebImageSwiftUI

struct AboutView: View {
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "info.circle")
                    Text("About")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                
                Text("Nitroless is a small open-sourced project made by students to let those without Nitro use custom emojis on Discord. Nitroless is entirely community driven as users are able to create and host repositories that store static and animated emojis. These repositories can be shared and added across all platforms that Nitroless supports, much like how you join Discord servers. You can start using Nitroless either through the app by tapping on an emoji and pasting in chat, or through the keyboard for a seamless experience on Discord. Happy chatting!")
                    .padding(.top, 0.2)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "link")
                    Text("Links")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                
                HStack {
                    Button {
                        UIApplication.shared.open(URL(string: "https://github.com/Nitroless")!)
                    } label: {
                        HStack {
                            Image("GithubIcon")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color.theme.textColor)
                            Text("Github")
                                .padding(.leading, 10)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.leading, 20)
                    .buttonStyle(.plain)
                    
                }
                HStack {
                    Button {
                        UIApplication.shared.open(URL(string: "https://nitroless.github.io/")!)
                    } label: {
                        HStack {
                            Image(systemName: "link")
                                .resizable()
                                .frame(width: 25, height: 25)
                            Text("Website")
                                .padding(.leading, 10)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.leading, 20)
                    .buttonStyle(.plain)
                }
                HStack {
                    Button {
                        UIApplication.shared.open(URL(string: "https://discord.gg/dTPJ88fcm3")!)
                    } label: {
                        HStack {
                            Image("DiscordIcon")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color.theme.textColor)
                            Text("Discord")
                                .padding(.leading, 10)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.leading, 20)
                    .buttonStyle(.plain)
                }
                HStack {
                    Button {
                        UIApplication.shared.open(URL(string: "https://twitter.com/nitroless_")!)
                    } label: {
                        HStack {
                            Image("TwitterIcon")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25)
                                .foregroundColor(Color.theme.textColor)
                            Text("Twitter")
                                .padding(.leading, 10)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.leading, 20)
                    .buttonStyle(.plain)
                }

            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1)
                )
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
            
            VStack {
                VStack {
                    HStack {
                        Image(systemName: "info.circle")
                        Text("Credits")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .font(.headline)
                    
                    VStack {
                        HStack(alignment: .top) {
                            WebImage(url: URL(string: "https://github.com/TheAlphaStream.png"))
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                            VStack {
                                Text("Alpha_Stream")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                
                                Text("Founder and Designer")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.subheadline)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://alphastream.weebly.com/")!)
                                } label: {
                                    HStack {
                                        Image(systemName: "link")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                        
                                        Text("Portfolio")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://github.com/TheAlphaStream/")!)
                                } label: {
                                    HStack {
                                        Image("GithubIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("TheAlphaStream")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://twitter.com/Kutarin_/")!)
                                } label: {
                                    HStack {
                                        Image("TwitterIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("@Kutarin_")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.bottom)
                    
                    VStack {
                        HStack(alignment: .top) {
                            WebImage(url: URL(string: "https://github.com/paraskcd1315.png"))
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                            
                            VStack {
                                Text("Paras KCD")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                
                                Text("iOS, macOS, Android and Web Developer")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.subheadline)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://paraskcd.com/")!)
                                } label: {
                                    HStack {
                                        Image(systemName: "link")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                        
                                        Text("Portfolio")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://github.com/paraskcd1315/")!)
                                } label: {
                                    HStack {
                                        Image("GithubIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("paraskcd1315")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://twitter.com/ParasKCD")!)
                                } label: {
                                    HStack {
                                        Image("TwitterIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("@ParasKCD")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.bottom)
                    
                    VStack {
                        HStack(alignment: .top) {
                            WebImage(url: URL(string: "https://github.com/llsc12.png"))
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                            
                            VStack {
                                Text("llsc12")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                
                                Text("iOS and macOS Developer")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.subheadline)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://llsc12.github.io/")!)
                                } label: {
                                    HStack {
                                        Image(systemName: "link")
                                            .resizable()
                                            .frame(width: 18, height: 18)
                                        
                                        Text("Portfolio")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://github.com/llsc12/")!)
                                } label: {
                                    HStack {
                                        Image("GithubIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("llsc12")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://twitter.com/llsc121")!)
                                } label: {
                                    HStack {
                                        Image("TwitterIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("@llsc121")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.bottom)
                    
                    VStack {
                        HStack(alignment: .top) {
                            WebImage(url: URL(string: "https://github.com/Superbro9.png"))
                                .resizable()
                                .frame(width: 64, height: 64)
                                .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                            VStack {
                                Text("Superbro")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.headline)
                                
                                Text("macOS and iOS Adviser, Quality control")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.subheadline)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://github.com/Superbro9/")!)
                                } label: {
                                    HStack {
                                        Image("GithubIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("Superbro9")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                                
                                Button {
                                    UIApplication.shared.open(URL(string: "https://twitter.com/suuperbro/")!)
                                } label: {
                                    HStack {
                                        Image("TwitterIcon")
                                            .renderingMode(.template)
                                            .resizable()
                                            .frame(width: 24, height: 24)
                                            .foregroundColor(Color.theme.textColor)
                                        
                                        Text("@suuperbro")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .font(.subheadline)
                                }
                                .buttonStyle(.plain)
                            }
                            .padding(.leading)
                        }
                    }
                    .padding(.bottom)
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(20)
                .background(Color.theme.appBGSecondaryColor)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
                .padding(.top, 10)
                .padding(.horizontal, 15)
                .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
            }
            .padding(.bottom)
        }
        .padding(.horizontal, 10)
        .padding(.top, idiom == .pad && horizontalSizeClass == .regular ? 10 : 0)
        .padding(.trailing, idiom == .pad && horizontalSizeClass == .regular ? 40 : 0)
        .padding(.leading, idiom == .pad && horizontalSizeClass == .regular ? 25 : 0)
        .background(Color.theme.appBGColor)
        .navigationTitle(idiom == .pad && horizontalSizeClass == .regular ? "" : "About")
        .toolbarBackground(Color.theme.appBGTertiaryColor, for: .navigationBar)
    }
}
