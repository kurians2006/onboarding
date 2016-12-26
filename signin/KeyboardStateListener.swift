//
//  KeyboardStateListener.swift
//  signin
//
//  Created by Wouter van de Kamp on 23/12/2016.
//  Copyright © 2016 Wouter. All rights reserved.
//

import UIKit

class KeyboardStateListener: NSObject {
    static var shared = KeyboardStateListener()
    var isVisible = false
    
    func start() {
        NotificationCenter.default.addObserver(self, selector: #selector(didShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func didShow() {
        isVisible = true
    }
    
    func didHide() {
        isVisible = false
    }
}
