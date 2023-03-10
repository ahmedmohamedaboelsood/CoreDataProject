//
//  Extentions.swift
//  coreDatatest
//
//  Created by Ahmed on 02/03/2023.
//

import Foundation
import UIKit

extension UIView{
    
    @IBInspectable var cornerRadius:CGFloat{
        
        get{
            return 0
        }
        set{
            self.layer.cornerRadius = newValue
        }
        
    }
    
}

extension UITextField {
    @IBInspectable var underLineTF: Bool {
        get {
            return false
        } set {
            let underLineLayer = CALayer()
            underLineLayer.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width - 1, height: 1)
            underLineLayer.backgroundColor = UIColor(named: "underLineColor")?.cgColor
            self.borderStyle = .none
            self.layer.addSublayer(underLineLayer)
        }
    }
}



 
