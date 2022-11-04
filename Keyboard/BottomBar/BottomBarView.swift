//
//  BottomBarView.swift
//  Keyboard
//
//  Created by Paras KCD on 2022-11-04.
//

import SwiftUI

struct BottomBarView: View {
    var repoMan: RepoManager
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                VStack {
                    Button {
                        print(repoMan.repos)
                        repoMan.selectHome()
                    } label: {
                        Image("Icon")
                            .resizable()
                            .frame(width: 48, height: 48)
                            .clipShape(RoundedRectangle(cornerRadius: repoMan.selectedRepo == nil ? 8 : 99, style: .continuous))
                            .shadow(radius: 5)
                    }
                    Rectangle()
                        .fill(.white)
                        .frame(width: 32, height: repoMan.selectedRepo == nil ? 3 : 0 )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .offset(y: 1)
                        .opacity(repoMan.selectedRepo == nil ? 1 : 0)
                }
                .padding(.top, 20)
                .padding(.horizontal, 10)
                
                Divider()
                    .frame(height: 40)
                    .offset(y: 4)
                
                if repoMan.repos.isEmpty {
                    Text("Please use the Nitroless App\nto add some Repos")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.white))
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color.theme.appBGSecondaryColor)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                        .padding(.horizontal, 10)
                }
            }
        }
        
    }
}
