//
//  AppNotificationExtension.swift
//  SideProject
//
//  Created by Ankit.Gohel on 04/07/20.
//  Copyright © 2020 Ankit Gohel. All rights reserved.
//

import UIKit

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

