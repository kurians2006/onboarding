//
//  SignUpViewController.swift
//  signin
//
//  Created by Wouter on 18/12/2016.
//  Copyright © 2016 Wouter. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerLeading: NSLayoutConstraint!
    @IBOutlet weak var containerTrailing: NSLayoutConstraint!
    @IBOutlet weak var containerTop: NSLayoutConstraint!
    @IBOutlet weak var contentTop: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var navigationBar: UIView!
    @IBOutlet weak var navigationTop: NSLayoutConstraint!
    @IBOutlet weak var navigationHeight: NSLayoutConstraint!
    
    
    var containerTrailingConstant: CGFloat!
    var containerLeadingConstant: CGFloat!
    var containerTopConstant: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerTopConstant = containerTop.constant
        containerTrailingConstant = containerTrailing.constant
        containerLeadingConstant = containerLeading.constant
        navigationTop.constant -= navigationHeight.constant
        
        self.backButton.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.signupWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.signupWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func hideKeyboard(_ sender: AnyObject) {
        scrollView.endEditing(true)
    }
    
    @IBAction func signinAction(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if KeyboardStateListener.shared.isVisible == false {
            self.performSegue(withIdentifier: "SignIn", sender: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func signupWithKeyboard(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as! UInt
        let moveUp = (notification.name == NSNotification.Name.UIKeyboardWillShow)
        let moveDown = (notification.name == NSNotification.Name.UIKeyboardWillHide)
        let options = UIViewAnimationOptions(rawValue: curve << 16)
        
        if moveUp == true {
            containerTrailing.constant -= containerTrailing.constant
            containerLeading.constant = UIScreen.main.bounds.minX
            containerTop.constant = 0 - UIApplication.shared.statusBarFrame.height
            contentTop.constant += 110
            
            self.navigationBar.isHidden = false
            
            UIView.animate(withDuration: 0, delay: 0.25, options: options, animations: {
                self.navigationBar.alpha = 0.9
                self.navigationTop.constant += self.navigationHeight.constant
            })
            
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
                self.scrollView.contentInset.bottom = keyboardHeight
                self.backButton.tintColor = UIColor(red: 237/255, green: 32/255, blue: 37/255, alpha: 1.0)
                self.view.layoutIfNeeded()
            });
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.signupWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
        if moveDown == true {
            containerTrailing.constant = containerTrailingConstant
            containerLeading.constant = containerLeadingConstant
            containerTop.constant = containerTopConstant
            contentTop.constant -= 110
            
            self.navigationBar.isHidden = true
            self.navigationTop.constant -= self.navigationHeight.constant
            
            UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
                UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
                self.backButton.tintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
                self.scrollView.contentInset.bottom = 0
                self.view.layoutIfNeeded()
            });
            
            NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.signupWithKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        }
        
    }
}
