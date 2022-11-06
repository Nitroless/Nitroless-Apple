//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Lakhan Lothiyi on 04/10/2022.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController, ObservableObject {
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    private lazy var suiView: UIView = {
        let kbView = KeyboardView(vc: self)
        
        let view = UIHostingController(rootView: kbView).view!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(suiView)
        NSLayoutConstraint.activate([
            suiView.topAnchor.constraint(equalTo: view.topAnchor),
            suiView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            suiView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            suiView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        // Perform custom UI setup here
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

}


