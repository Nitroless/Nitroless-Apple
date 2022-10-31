//
//  HomeViewModel.swift
//  Nitroless iOS
//
//  Created by Paras KCD on 2022-10-31.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isHomeActive: Bool = true;
    @Published var isAboutActive: Bool = false;
    
    func toggleHomeMenus() {
        self.isHomeActive = !self.isHomeActive
        self.isAboutActive = !self.isAboutActive
    }
}
