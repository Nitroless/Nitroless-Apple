//
//  SidebarView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

struct SidebarView: View {
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        ScrollView {
            VStack {
                HStack{
                    Rectangle()
                        .fill(.white)
                        .frame(width: 3, height: 32 )
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .offset(x: 3)
                    
                    Image("Icon")
                        .resizable()
                        .frame(width: 48, height: 48)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .shadow(radius: 5)
                }
                .offset(x: -3)
                
                Divider()
                    .frame(width: 40)
                    .offset(x: 2)
                
            }
        }
        .padding(.top, 10)
        .frame(width: 75)
        .background(Color.theme.appBGTertiaryColor)
    }
}
