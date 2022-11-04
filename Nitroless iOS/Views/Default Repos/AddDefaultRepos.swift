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
    
    @Environment(\.colorScheme) var colorScheme
    
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        page
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
