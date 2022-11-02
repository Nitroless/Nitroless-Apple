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
                    .frame(maxWidth: 64)
                    .padding(.trailing)
                Text("Community\nRepositories")
                    .font(.title.bold())
            }
            .padding(.top, 30)
            
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
                    .foregroundColor(Color(.white))
                    .padding(10)
                    .background(Color.theme.appPrimaryColor)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .shadow(radius: 5)
            }
            .buttonStyle(.plain)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(Color.theme.appBGTertiaryColor)
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
        .background(Color.theme.appBGTertiaryColor)
        .safeAreaInset(edge: .top) {
            HStack {
                Button {
                    isShown.toggle()
                    detent = .fraction(0.3)
                } label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color(.white))
                        .padding(10)
                        .background(Color.theme.appBGColor)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                }
                .buttonStyle(.plain)
                
                Spacer()
            }
            .padding()
        }
    }
}
