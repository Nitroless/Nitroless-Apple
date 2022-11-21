//
//  AboutView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI
import SDWebImageSwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
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
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
            
            VStack {
                HStack {
                    Button {
                        UIApplication.shared.open(URL(string: "https://github.com/Nitroless")!)
                    } label: {
                        HStack {
                            Image("GithubIcon")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.theme.textColor)
                                
                            Text("Github")
                        }
                        
                    }
                    .padding(.trailing)
                    .buttonStyle(.plain)
                    Button {
                        UIApplication.shared.open(URL(string: "https://nitroless.github.io/")!)
                    } label: {
                        HStack {
                            Image(systemName: "link")
                                .resizable()
                                .frame(width: 24, height: 24)
                            Text("Website")
                        }
                    }
                    .padding(.trailing)
                    .buttonStyle(.plain)
                    Button {
                        UIApplication.shared.open(URL(string: "https://twitter.com/nitroless_")!)
                    } label: {
                        HStack {
                            Image("TwitterIcon")
                                .renderingMode(.template)
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.theme.textColor)
                            
                            Text("Twitter")
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
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
                                
                                Text("iOS, macOS and Web Developer")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
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
                        .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
            }
            .padding(.bottom)
        }
        .padding([.leading, .trailing], 10)
        .background(Color.theme.appBGColor)
        .navigationTitle("About")
        .toolbarBackground(Color.theme.appBGTertiaryColor, for: .navigationBar)
    }
}
