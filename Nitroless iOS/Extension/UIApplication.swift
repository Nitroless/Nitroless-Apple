//
//  UIApplication.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-11-22.
//

import Foundation
import SwiftUI

extension UIApplication {
    public var isSplitOrSlideOver: Bool {
        guard let window = self.windows.filter({ $0.isKeyWindow }).first else { return false }
        return !(window.frame.width == window.screen.bounds.width)
    }
}
