//
//  Color.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

extension Color {
    static let theme = ColorTheme()
}

struct ColorTheme {
    let appBGColor = Color("AppBGColor")
    let appBGSecondaryColor = Color("AppBGSecondaryColor")
    let appBGTertiaryColor = Color("AppBGTertiaryColor")
    let appPrimaryColor = Color("AppPrimaryColor")
    let appSuccessColor = Color("AppSuccessColor")
    let appDangerColor = Color("AppDangerColor")
    let appWarningColor = Color("AppWarningColor")
    let textColor = Color("TextColor")
}
