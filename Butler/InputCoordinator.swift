//
//  InputCoordinator.swift
//  Butler
//
//  Created by Nick O'Neill on 5/10/16.
//  Copyright © 2016 922am Burrito. All rights reserved.
//

import UIKit

open class InputCoordinator: NSObject {
    static func configureText(_ textField: UITextField) {
        textField.keyboardType = .asciiCapable
        textField.autocorrectionType = .yes
        textField.autocapitalizationType = .none
    }

    static func configureEmail(_ textField: UITextField) {
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }

    static func configurePhone(_ textField: UITextField) {
        textField.keyboardType = .phonePad
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
    }

    static func configurePassword(_ textField: UITextField) {
        textField.keyboardType = .asciiCapable
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
    }

    var fields: [UITextField] = []
    var finishedBlock: (() -> ())?

    open func createInputFlow(_ view: UIView, completion: (() -> ())? = nil) {
        fields = []
        finishedBlock = completion

        for subview in view.subviews {
            if let subview = subview as? UITextField {
                fields.append(subview)
                subview.delegate = self
                subview.returnKeyType = .next
            }
        }

        if let last = fields.last {
            last.returnKeyType = .done
        }
    }

    open func firstResponder() -> UITextField? {
        for field in fields {
            if field.isFirstResponder {
                return field
            }
        }

        return nil
    }
}

extension InputCoordinator: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let last = fields.last else {
            return true
        }

        textField.resignFirstResponder()

        if textField == last {
            if let finishedBlock = finishedBlock {
                finishedBlock()
            }
        } else if fields.contains(textField) {
            if let index = fields.index(of: textField) {
                fields[index+1].becomeFirstResponder()
            }
        } else {
            // field not in fields array?
        }
        
        return true
    }
}
