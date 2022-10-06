//
//  Nitroless_macOSApp.swift
//  Nitroless macOS
//
//  Created by Lakhan Lothiyi on 06/10/2022.
//

import SwiftUI

@main
struct Nitroless_macOSApp: App {
    var body: some Scene {
        MenuBarExtra("Nitroless", systemImage: "hammer") {
            AppView()
        }
        .menuBarExtraStyle(.window)
    }
}

struct AppView: View {
    @StateObject var repoMan = RepoManager()
    
    var body: some View {
        ContentView()
            .environmentObject(repoMan)
    }
}
