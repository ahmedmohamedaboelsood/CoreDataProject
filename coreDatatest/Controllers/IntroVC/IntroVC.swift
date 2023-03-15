//
//  ViewController.swift
//  coreDatatest
//
//  Created by Ahmed on 10/02/2023.
//

import UIKit


class IntroVC: UIViewController {

    
    static let ID = String(describing: IntroVC.self)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
    }
    
    @IBAction func loginBtn(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: LoginAndSignUpVC.ID) as! LoginAndSignUpVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        vc.state = "login"
        present(vc, animated: true)
    }
    
    @IBAction func signUpBtn(_ sender: Any) {
         
        let vc = storyboard?.instantiateViewController(identifier: LoginAndSignUpVC.ID) as! LoginAndSignUpVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true)
    }
    
}

