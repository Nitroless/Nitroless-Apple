//
//  HomeView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button {
                    viewModel.toggleHomeMenus()
                } label: {
                    Text("Home")
                        .foregroundColor(Color(.white))
                        .padding(10)
                        .background(viewModel.isHomeActive ? Color.theme.appPrimaryColor : Color.theme.appBGSecondaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .shadow(radius: 5)
                }
                Button {
                    viewModel.toggleHomeMenus()
                } label: {
                    Text("About")
                        .foregroundColor(Color(.white))
                        .padding(10)
                        .background(viewModel.isAboutActive ? Color.theme.appPrimaryColor : Color.theme.appBGSecondaryColor)
                        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                        .shadow(radius: 5)
                }
            }
            .padding(20)
            .background(Color.theme.appBGTertiaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
            
            VStack {
                if viewModel.isHomeActive {
                    FrequentUsedView()
                } else {
                    AboutView()
                }
            }
        }
        .offset(y: viewModel.isAboutActive ? -11 : 0)
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(10)
        .animation(.spring(), value: viewModel.isHomeActive)
    }
}
