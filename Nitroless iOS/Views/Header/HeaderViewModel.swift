//
//  HeaderViewModel.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-11-21.
//

import Foundation

class HeaderViewModel: ObservableObject {
    @Published var isAboutActive = false
    @Published var isKeyboardSettingsActive = false
    @Published var hovered = Hovered(image: "", hover: false)
}
