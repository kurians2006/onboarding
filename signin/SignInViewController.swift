//
//  ViewController.swift
//  signin
//
//  Created by Wouter on 13/12/2016.
//  Copyright © 2016 Wouter. All rights reserved.
//

import UIKit
import AVFoundation

class SignInViewController: UIViewController {
    @IBOutlet weak var containerHeight: NSLayoutConstraint!
    @IBOutlet weak var containerLeading: NSLayoutConstraint!
    @IBOutlet weak var containerTrailing: NSLayoutConstraint!
    @IBOutlet weak var contentTop: NSLayoutConstraint!
    @IBOutlet weak var emailTextfield: UserInputs!
    @IBOutlet weak var passwordTextfield: UserInputs!
    
    var containerHeightConstant: CGFloat!
    var containerTrailingConstant: CGFloat!
    var containerLeadingConstant: CGFloat!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    var keyboardIsActive:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        containerHeightConstant = containerHeight.constant
        containerTrailingConstant = containerTrailing.constant
        containerLeadingConstant = containerLeading.constant
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.animateWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.animateWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func signupAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if KeyboardStateListener.shared.isVisible == false {
            self.performSegue(withIdentifier: "SignUp", sender: nil)
        }
    }
    
    func animateWithKeyboard(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let moveUp = (notification.name == NSNotification.Name.UIKeyboardWillShow)
        let moveDown = (notification.name == NSNotification.Name.UIKeyboardWillHide)
        let options = UIViewAnimationOptions(rawValue: curve << 16)
        
        
        if moveUp == true {
            containerHeight.constant = UIScreen.main.bounds.size.height
            contentTop.constant += 110
            containerTrailing.constant -= containerTrailing.constant
            containerLeading.constant = UIScreen.main.bounds.minX
            
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
                self.logoImageView.tintColor = UIColor(red: 237/255, green: 32/255, blue: 37/255, alpha: 1.0)
                self.view.layoutIfNeeded()
            })
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.animateWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        if moveDown == true {
            containerHeight.constant = containerHeightConstant
            contentTop.constant -= 110
            containerTrailing.constant = containerTrailingConstant
            containerLeading.constant = containerLeadingConstant
            
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                self.logoImageView.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                self.view.layoutIfNeeded()
            })
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.animateWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        }
    }
}

