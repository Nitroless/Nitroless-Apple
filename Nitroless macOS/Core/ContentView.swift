//
//  ContentView.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import SwiftUI
import AppKit
import AlertToast

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State var isShown = true
    
    var body: some View {
        ZStack(alignment: .leading) {
            RepoView(viewModel: viewModel)
                .zIndex(1)
            
            if isShown {
                HStack {
                    Text("")
                        .frame(width: 80)
                    EmotesView(viewModel: viewModel)
                }
                .zIndex(-1)
                
            } else {
                HStack {
                    Text("")
                        .frame(width: 80)
                    
                    ScrollView(showsIndicators: false) {
                        VStack {
                            Text("Nitroless")
                                .font(.custom("Uni Sans", size: 32))
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(20)
                        .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                        
                        VStack {
                            Text("Nitroless got inactive\nClick to Reactivate")
                                .multilineTextAlignment(.center)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(20)
                        .background(Color(red: 0.13, green: 0.13, blue: 0.15).opacity(0.6))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 0.29, green: 0.30, blue: 0.33).opacity(0.4), lineWidth: 1))
                    }
                    .padding(.top)
                    .padding(.trailing, 40)
                    .padding(.leading, 10)
                }
            }
        }
        .frame(minWidth: 0,
               maxWidth: .infinity,
               minHeight: 0,
               maxHeight: .infinity
               
        ).onAppear {
            viewModel.allowAnimation()
            
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
                self.isShown = NSApplication.shared.isActive
            }
            
        }.onDisappear {
            viewModel.killAnimation()
        }
    }
}
