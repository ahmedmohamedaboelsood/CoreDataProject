//
//  UIViewControllerExtention.swift
//  coreDatatest
//
//  Created by Ahmed on 15/03/2023.
//

import Foundation
import UIKit

extension UIViewController{
    
    
    
    func showAlert(massege : String) {
        let alert = UIAlertController(title: "Alert", message: massege, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default))
        self.present(alert, animated: true, completion: nil)
    }
     
    
    func showAlertWithNavigation(massege : String ) {
        
        let alertController = UIAlertController(title: "Alert", message: massege, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .default) { _ in
            // Alert dismissed, navigate to another view
            let vc = self.storyboard?.instantiateViewController(identifier: ChoosePageVC.ID) as! ChoosePageVC
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
        alertController.addAction(defaultAction)

        present(alertController, animated: true, completion: nil)
    }
    
    
    func hideKeyboardWhenTappedAround() {
            let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }
        
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    
}
