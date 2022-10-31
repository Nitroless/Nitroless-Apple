//
//  FrequentUsedView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

struct FrequentUsedView: View {
    @EnvironmentObject var repoMan: RepoManager
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock.arrow.circlepath")
                Text("Frequently used emotes")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.title)
            
            Spacer()
            
            if repoMan.frequentlyUsed.count == 0 {
                Text("Start using Nitroless to show your frequently used emotes here.")
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(20)
        .background(Color.theme.appBGSecondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
        
    }
}
