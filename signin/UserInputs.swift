//
//  UserInputs.swift
//  signin
//
//  Created by Wouter on 13/12/2016.
//  Copyright © 2016 Wouter. All rights reserved.
//

import UIKit

class UserInputs: UITextField, UITextFieldDelegate {
    
    @IBOutlet weak var nextField: UITextField?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        customTextField()
    }
    
    required override init(frame: CGRect){
        super.init(frame: frame)
        delegate = self
        customTextField()
    }
    
    func customTextField(){       
        self.layer.borderColor = UIColor(red: 34/255, green: 41/255, blue: 47/255, alpha: 0.3).cgColor
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 2.0;
        self.layer.masksToBounds = true
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 10, dy: 10)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor(red: 34/255, green: 41/255, blue: 47/255, alpha: 1.0).cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.layer.borderColor = UIColor(red: 34/255, green: 41/255, blue: 47/255, alpha: 0.3).cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        textField.nextTextFieldField()?.becomeFirstResponder()
        return true
    }
}

extension UITextField{
    func nextTextFieldField() -> UITextField?{
        var returnField : UITextField?
        if self.superview != nil{
            for (_, view) in self.superview!.subviews.enumerated(){
                if view.isKind(of: UITextField.self){
                    let currentTextField = view as! UITextField
                    if currentTextField.frame.origin.y > self.frame.origin.y{
                        if returnField == nil {
                            returnField = currentTextField
                        }
                        else if currentTextField.frame.origin.y < returnField!.frame.origin.y{
                            returnField = currentTextField
                        }
                    }
                }
            }
        }
        return returnField
    }
    
}
