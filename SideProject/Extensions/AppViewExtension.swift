//
//  AppViewExtension.swift
//  SideProject
//
//  Created by Ankit.Gohel on 04/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import SwiftUI

extension View {
    func keyboardAdaptive() -> some View {
        ModifiedContent(content: self, modifier: KeyboardAdaptive())
    }
}
