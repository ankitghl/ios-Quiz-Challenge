//
//  KeyboardHandler.swift
//  SideProject
//
//  Created by Ankit.Gohel on 04/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import SwiftUI
import Combine  

struct KeyboardAdaptive: ViewModifier {
    @State private var bottomPadding: CGFloat = 0
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            content
                .padding(.bottom, self.bottomPadding)
                .onReceive(Publishers.keyboardHeight) { keyboardHeight in
                    let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
                    let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
                    self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
            }
            .animation(.easeOut(duration: 0.16))
        }
    }
}
