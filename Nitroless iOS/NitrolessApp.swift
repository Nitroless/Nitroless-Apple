//
//  NitrolessApp.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import SwiftUI

@main
struct NitrolessApp: App {
    var body: some Scene {
        WindowGroup {
            AppView()
                .preferredColorScheme(.dark)
        }
    }
}

struct AppView: View {
    
    @StateObject var repoMan = RepoManager()

    var body: some View {
        ContentView()
            .environmentObject(repoMan)
    }
}
