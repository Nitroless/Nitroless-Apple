//
//  Binding.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-12-16.
//

import Foundation
import SwiftUI

extension Binding where Value == Bool {
    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
