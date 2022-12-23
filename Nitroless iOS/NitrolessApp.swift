//
//  NitrolessApp.swift
//  Nitroless
//
//  Created by Lakhan Lothiyi on 29/09/2022.
//

import SwiftUI

@main
struct NitrolessApp: App {
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.theme.appPrimaryColor)
        UISegmentedControl.appearance().backgroundColor = UIColor(Color.theme.appBGTertiaryColor)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(Color.theme.appPrimaryColor)], for: .normal)
    }
    var body: some Scene {
        WindowGroup {
            AppView()
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
