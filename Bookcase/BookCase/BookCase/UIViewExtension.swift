//
//  UIViewExtension.swift
//  BookCase
//
//  Created by Marzieh on 2019-11-02.
//  Copyright © 2019 Myph. All rights reserved.
//

import UIKit

extension UIView { //finding which view is the first responder
    var firstResponder:UIView? {
        if self.isFirstResponder {
            return self
        }
        for view in self.subviews {
            if let firstResponder = view.firstResponder {
                return firstResponder
            }
        }
        return nil
    }
}

extension UIViewController { //for conveneince
    var firstResponder:UIView? {
        return view.firstResponder
    }
}
