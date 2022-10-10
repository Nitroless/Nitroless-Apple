//
//  AddDefaultRepos.swift
//  Nitroless iOS
//
//  Created by Lakhan Lothiyi on 08/10/2022.
//

import Foundation
import SwiftUI

struct AddDefaultRepos: View {
    @Binding var isShown: Bool
    @Binding var detent: PresentationDetent
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        switch detent {
        case .fraction(0.3):
            ask
        case .large:
            page
        default:
            ask
        }
    }
    
    @ViewBuilder
    var ask: some View {
        VStack {
            HStack(alignment: .center) {
                Image(systemName: "globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 75)
                    .padding(.trailing)
                Text("Community\nRepositories")
                    .font(.title.bold())
            }
            .padding(.top)
            
            Spacer()
            
            Text(
                repoMan.repos.isEmpty ? "Your repository list is looking a little empty, want to add some to start off with?" : "Want to look at community repositories?"
            )
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            Spacer()
            
            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    detent = .large
                }
            } label: {
                Text("Browse")
                    .font(.title2)
                    .padding(.bottom, 4)
            }
            .buttonStyle(.bordered)
        }
    }
    
    @State var defaultRepos: [URL]? = nil
    @ViewBuilder
    var page: some View {
        ScrollView {
            HStack {
                Text("Our Repositories")
                    .font(.title)
                    .bold()
                Spacer()
            }
            .padding(.leading)
            .task {
                if defaultRepos == nil {
                    do {
                        let req = URLRequest(url: DefaultReposUrl)
                        let (data, _) = try await URLSession.shared.data(for: req)
                        let json = try JSONDecoder().decode([URL].self, from: data)
                        defaultRepos = json
                    } catch {
                        print(error)
                    }
                }
            }
            
            if let defaultRepos = defaultRepos {
                ForEach(defaultRepos, id: \.self) { url in
                    DefaultRepoCell(url: url)
                }
            } else {
                ProgressView()
            }
        }
        .safeAreaInset(edge: .top) {
            HStack {
                Button {
                    isShown.toggle()
                    detent = .fraction(0.3)
                } label: {
                    Circle()
                        .foregroundColor(.secondary)
                        .brightness(colorScheme == .light ? 0 : -0.6)
                        .overlay(content: {
                            Text("X")
                                .foregroundColor(.white)
                        })
                        .frame(width: 30, height: 30)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .padding()
        }
    }
}
