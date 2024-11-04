//
//  Padding.swift
//  SawtiApp
//
//  Created by Ilmhona 10 on 28/10/24.
//

import UIKit

class ATCTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 45, bottom: 0, right: 0)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
