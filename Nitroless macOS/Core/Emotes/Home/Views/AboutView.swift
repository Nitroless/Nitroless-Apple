//
//  AboutView.swift
//  Nitroless macOS
//
//  Created by Paras KCD on 2022-10-10.
//

import SwiftUI
import SDWebImageSwiftUI

struct AboutView: View {
    let delegate = NSApplication.shared.delegate as! AppDelegate
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "info.circle")
                Text("About")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.title)
            
            Text("Nitroless is a small open-sourced project made by students to let those without Nitro use custom emojis on Discord. Nitroless is entirely community driven as users are able to create and host repositories that store static and animated emojis. These repositories can be shared and added across all platforms that Nitroless supports, much like how you join Discord servers. You can start using Nitroless through the app located on your menu bar by clicking on an emoji and pasting in chat. Happy chatting!")
                .padding(.top, 0.2)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(20)
        .background(Color.theme.appBGSecondaryColor.opacity(0.6))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1)
            )
        
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "link")
                Text("Links")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.title)
            
            HStack {
                Button {
                    delegate.popMenubarView()
                    NSWorkspace.shared.open(URL(string: "https://github.com/Nitroless")!)
                } label: {
                    HStack {
                        Image("GithubIcon")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .colorInvert()
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
                    delegate.popMenubarView()
                    NSWorkspace.shared.open(URL(string: "https://nitroless.github.io/")!)
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
                    delegate.popMenubarView()
                    NSWorkspace.shared.open(URL(string: "https://discord.gg/dTPJ88fcm3")!)
                } label: {
                    HStack {
                        Image("DiscordIcon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .colorInvert()
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
                    delegate.popMenubarView()
                    NSWorkspace.shared.open(URL(string: "https://twitter.com/nitroless_")!)
                } label: {
                    HStack {
                        Image("TwitterIcon")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .colorInvert()
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
        .background(Color.theme.appBGSecondaryColor.opacity(0.6))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1)
            )
        
        VStack {
            VStack {
                HStack {
                    Image(systemName: "info.circle")
                    Text("Credits")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.title)
                
                VStack {
                    HStack(alignment: .top) {
                        WebImage(url: URL(string: "https://github.com/TheAlphaStream.png"))
                            .resizable()
                            .placeholder {
                                ProgressView()
                            }
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                        VStack {
                            Text("Alpha_Stream")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            
                            Text("Founder and Designer")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://alphastream.weebly.com/")!)
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
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://github.com/TheAlphaStream/")!)
                            } label: {
                                HStack {
                                    Image("GithubIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
                                    Text("TheAlphaStream")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.subheadline)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://twitter.com/Kutarin_/")!)
                            } label: {
                                HStack {
                                    Image("TwitterIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
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
                            .placeholder {
                                ProgressView()
                            }
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                        
                        VStack {
                            Text("Paras KCD")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            
                            Text("macOS, iOS, Android and Web Developer")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://paraskcd.com/")!)
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
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://github.com/paraskcd1315/")!)
                            } label: {
                                HStack {
                                    Image("GithubIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
                                    Text("paraskcd1315")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.subheadline)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://twitter.com/ParasKCD")!)
                            } label: {
                                HStack {
                                    Image("TwitterIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
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
                            .placeholder {
                                ProgressView()
                            }
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                        
                        VStack {
                            Text("llsc12")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            
                            Text("macOS and iOS Developer")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://llsc12.github.io/")!)
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
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://github.com/llsc12/")!)
                            } label: {
                                HStack {
                                    Image("GithubIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
                                    Text("llsc12")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.subheadline)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://twitter.com/llsc121")!)
                            } label: {
                                HStack {
                                    Image("TwitterIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
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
                            .placeholder {
                                ProgressView()
                            }
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                        VStack {
                            Text("Superbro")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            
                            Text("macOS and iOS Adviser, Quality control")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://github.com/Superbro9/")!)
                            } label: {
                                HStack {
                                    Image("GithubIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
                                    Text("Superbro9")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.subheadline)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://twitter.com/suuperbro/")!)
                            } label: {
                                HStack {
                                    Image("TwitterIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
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
            .background(Color.theme.appBGSecondaryColor.opacity(0.6))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1)
                )
        }
        .padding(.bottom)
    }
}
