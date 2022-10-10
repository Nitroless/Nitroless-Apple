//
//  ViewController.swift
//  Nitroless
//
//  Created by Paras KCD on 2022-10-08.
//

import AppKit

class MainViewController: NSViewController {
    override func viewDidAppear()
    {
        super.viewDidAppear()
        let fontFamilies = NSFontManager.shared.availableFontFamilies.sorted()

        for family in fontFamilies {
                  print(family)
                  let familyFonts = NSFontManager.shared.availableMembers(ofFontFamily: family)
                  if let fonts = familyFonts {
                      for font in fonts {
                        print("\t\(font)")
                      }
                  }
              }

    }
}

