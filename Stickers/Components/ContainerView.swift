//
//  ContainerView.swift
//  Stickers
//
//  Created by Paras KCD on 2022-12-19.
//

import SwiftUI

struct ContainerView<Content: View>: View {
    var icon: String
    var title: String
    @ViewBuilder var content: Content
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: icon)
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .font(.headline)
            Spacer()
            content
        }
        .padding(20)
        .background(Color.theme.appBGSecondaryColor)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
        .padding(10)
        .padding(.bottom, 10)
        .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
    }
}
