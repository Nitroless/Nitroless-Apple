//
//  HomeView.swift
//  Nitroless macOS
//
//  Created by Paras KCD on 2022-10-09.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: ContentViewModel
    @State var hovered = Hovered(image: "", hover: false)
    
    var body: some View {
        VStack {
            Text("Nitroless")
                .font(.custom("Uni Sans", size: 32))
            
            HStack(alignment: .center) {
                Button {
                    viewModel.makeAllReposInactive()
                } label: {
                    VStack {
                        Text("Home")
                    }
                    .foregroundColor((self.hovered.image == "Home" && self.hovered.hover == true) || viewModel.isHomeActive == true ? Color(.white) : Color(red: 0.35, green: 0.40, blue: 0.95))
                    .padding(10)
                    .background((self.hovered.image == "Home" && self.hovered.hover == true) || viewModel.isHomeActive == true ? Color(red: 0.35, green: 0.40, blue: 0.95) : Color(red: 0.21, green: 0.22, blue: 0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .animation(.spring(), value: self.hovered.hover && viewModel.isHomeActive == false)
                    .shadow(radius: 5)
                }
                .buttonStyle(.plain)
                .onHover { isHovered in
                    self.hovered = Hovered(image: "Home", hover: isHovered)
                }
                
                Button {
                    viewModel.makeAboutActive()
                } label: {
                    VStack {
                        Text("About")
                    }
                    .foregroundColor((self.hovered.image == "About" && self.hovered.hover == true) || viewModel.isAboutActive == true ? Color(.white) : Color(red: 0.35, green: 0.40, blue: 0.95))
                    .padding(10)
                    .background((self.hovered.image == "About" && self.hovered.hover == true) || viewModel.isAboutActive == true ? Color(red: 0.35, green: 0.40, blue: 0.95) : Color(red: 0.21, green: 0.22, blue: 0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .animation(.spring(), value: self.hovered.hover && viewModel.isAboutActive == false)
                    .shadow(radius: 5)
                }
                .buttonStyle(.plain)
                .onHover { isHovered in
                    self.hovered = Hovered(image: "About", hover: isHovered)
                }
                
                Button {
                    viewModel.askBeforeExiting()
                } label: {
                    VStack {
                        Text("Quit App")
                    }
                    .foregroundColor(self.hovered.image == "Quit" && self.hovered.hover == true ? Color(.white) : Color(red: 0.35, green: 0.40, blue: 0.95))
                    .padding(10)
                    .background(self.hovered.image == "Quit" && self.hovered.hover == true ? Color(red: 0.35, green: 0.40, blue: 0.95) : Color(red: 0.21, green: 0.22, blue: 0.25))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .animation(.spring(), value: self.hovered.hover)
                    .shadow(radius: 5)
                }
                .buttonStyle(.plain)
                .onHover { isHovered in
                    self.hovered = Hovered(image: "Quit", hover: isHovered)
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
        
        VStack {
            HomeChildView(viewModel: viewModel)
        }
    }
}
