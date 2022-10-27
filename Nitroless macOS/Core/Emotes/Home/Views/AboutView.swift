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
            
            Text("Nitroless is a small project made by students to help people without Nitro be able to use the community's Emotes to be used in discord. Nitroless is entirely community based requiring the community to make repositories where they can insert their own emotes and share them back to the community. The community uses this service by clicking/tapping on the image and it gets copied in their system's clipboard, allowing them to paste the Emote URL in Discord for the people to see.")
                .padding(.top, 0.2)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(20)
        .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
        
        VStack {
            HStack {
                Button {
                    delegate.popMenubarView()
                    NSWorkspace.shared.open(URL(string: "https://github.com/Nitroless")!)
                } label: {
                    HStack {
                        Image("GithubIcon")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .colorInvert()
                        Text("Github")
                    }
                    
                }
                .padding(.trailing)
                .buttonStyle(.plain)
                Button {
                    delegate.popMenubarView()
                    NSWorkspace.shared.open(URL(string: "https://nitroless.github.io/")!)
                } label: {
                    HStack {
                        Image(systemName: "link")
                            .resizable()
                            .frame(width: 32, height: 32)
                        Text("Website")
                    }
                }
                .padding(.trailing)
                .buttonStyle(.plain)
                Button {
                    delegate.popMenubarView()
                    NSWorkspace.shared.open(URL(string: "https://twitter.com/nitroless_")!)
                } label: {
                    HStack {
                        Image("TwitterIcon")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .colorInvert()
                        Text("Twitter")
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(20)
        .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
        
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
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                        
                        VStack {
                            Text("Paras KCD")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            
                            Text("macOS and Web Developer")
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
                
                VStack {
                    HStack(alignment: .top) {
                        WebImage(url: URL(string: "https://github.com/LillieH001.png"))
                            .resizable()
                            .frame(width: 64, height: 64)
                            .clipShape(RoundedRectangle(cornerRadius: 99, style: .continuous))
                        VStack {
                            Text("Lillie")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            
                            Text("Windows Developer")
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://lillieh001.github.io/")!)
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
                                NSWorkspace.shared.open(URL(string: "https://github.com/LillieH001/")!)
                            } label: {
                                HStack {
                                    Image("GithubIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
                                    Text("LillieH001")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.subheadline)
                            }
                            .buttonStyle(.plain)
                            
                            Button {
                                delegate.popMenubarView()
                                NSWorkspace.shared.open(URL(string: "https://twitter.com/LillieWeeb/")!)
                            } label: {
                                HStack {
                                    Image("TwitterIcon")
                                        .resizable()
                                        .frame(width: 18, height: 18)
                                        .colorInvert()
                                    
                                    Text("@LillieWeeb")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.subheadline)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.leading)
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
        }
        .padding(.bottom)
    }
}
