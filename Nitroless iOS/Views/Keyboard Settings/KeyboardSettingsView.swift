//
//  KeyboardSettingsView.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-12-14.
//

import SwiftUI

struct KeyboardSettingsView: View {
    private var idiom : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @AppStorage("useEmotesAsStickers", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var useEmotesAsStickers = false
    @AppStorage("hideFavouriteEmotes", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var hideFavouriteEmotes = false
    @AppStorage("hideFrequentlyUsedEmotes", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var hideFrequentlyUsedEmotes = false
    @AppStorage("hideRepoDrawer", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var hideRepoDrawer = false
    @AppStorage("darkTheme", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var darkTheme = false
    @AppStorage("systemTheme", store: UserDefaults(suiteName: "group.llsc12.Nitroless")) private var systemTheme = true
    
    @State private var testKeyboard = ""
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Image(systemName: "gearshape.fill")
                    Text("Activation")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                .padding(.bottom, 10)
                
                VStack {
                    HStack {
                        Image(systemName: "hand.tap.fill")
                        Text("Tap **Enable Keyboard** Button below")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Image(systemName: "hand.tap.fill")
                        Text("Tap **Keyboards**")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Image(systemName: "switch.2")
                        Text("Turn on **Keyboard**")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom, 5)
                    HStack {
                        Image(systemName: "switch.2")
                        Text("Turn on **Full Access**")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom, 5)
                }
                .padding(.bottom, 10)
                
                Text("This lets you use our Nitroless Keyboard. Nitroless needs Full access so it can connect with the Internet to show you all the emotes. No Data is collected, transmitted or sold. Nitroless uses no third-party analytics or advertising frameworks. Nitroless logs no information on you and has no interest in doing such.")
                    .padding(.bottom, 10)
                
                Button {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                } label: {
                    VStack {
                        Text("Enable Keyboard")
                    }
                    .frame(width: 250)
                    .foregroundColor(Color.white)
                    .padding(10)
                    .background(Color.theme.appPrimaryColor)
                    .clipShape(Capsule())
                    .shadow(radius: 5)
                }
                .buttonStyle(.plain)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
            
            VStack {
                TextField("Test Keyboard", text: $testKeyboard)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
            
            VStack {
                Toggle("Copy Emotes as Images", isOn: $useEmotesAsStickers)
                    .toggleStyle(SwitchToggleStyle(tint: Color.theme.appPrimaryColor))
                    .padding(.bottom, 10)
                    
                Text("This allows users to use Keyboard in other messaging apps other than Discord. Tapping on any emote will allow user to copy the Emote's Image to the system's Clipboard, which can be manually pasted in any Message Box of any Messaging App.")
                    .padding(.bottom, 10)
                
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
            
            VStack {
                HStack {
                    Image(systemName: "gearshape.fill")
                    Text("Hide")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                Toggle("Hide Favourite Emotes", isOn: $hideFavouriteEmotes)
                    .toggleStyle(SwitchToggleStyle(tint: Color.theme.appPrimaryColor))
                Toggle("Hide Frequently Used Emotes", isOn: $hideFrequentlyUsedEmotes)
                    .toggleStyle(SwitchToggleStyle(tint: Color.theme.appPrimaryColor))
                Toggle("Hide Repository Bottom bar", isOn: $hideRepoDrawer)
                    .toggleStyle(SwitchToggleStyle(tint: Color.theme.appPrimaryColor))
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
            
            VStack {
                HStack {
                    Image(systemName: "gearshape.fill")
                    Text("Theme")
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .font(.headline)
                if !systemTheme {
                    Toggle("Use Light Theme", isOn: $darkTheme.not)
                        .toggleStyle(SwitchToggleStyle(tint: Color.theme.appPrimaryColor))
                    Toggle("Use Dark Theme", isOn: $darkTheme)
                        .toggleStyle(SwitchToggleStyle(tint: Color.theme.appPrimaryColor))
                }
                Toggle("Use System Theme", isOn: $systemTheme)
                    .toggleStyle(SwitchToggleStyle(tint: Color.theme.appPrimaryColor))
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding(20)
            .background(Color.theme.appBGSecondaryColor)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(Color.theme.appBGTertiaryColor.opacity(0.2), lineWidth: 1))
            .padding(.top, 10)
            .padding(.horizontal, 15)
            .padding(.bottom, 30)
            .shadow(color: Color.theme.appBGTertiaryColor.opacity(0.5), radius: 10, x: -2, y: 7)
        }
        .padding(.horizontal, 10)
        .padding(.top, idiom == .pad && horizontalSizeClass == .regular ? 10 : 0)
        .padding(.trailing, idiom == .pad && horizontalSizeClass == .regular ? 40 : 0)
        .padding(.leading, idiom == .pad && horizontalSizeClass == .regular ? 25 : 0)
        .background(Color.theme.appBGColor)
        .navigationTitle(idiom == .pad && horizontalSizeClass == .regular ? "" : "Keyboard Settings")
        .toolbarBackground(Color.theme.appBGTertiaryColor, for: .navigationBar)
    }
}
