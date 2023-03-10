//
//  LoginAndSignUpVC.swift
//  coreDatatest
//
//  Created by Ahmed on 02/03/2023.
//

import UIKit

class LoginAndSignUpVC: UIViewController {

    @IBOutlet weak var userNmaeTxtfield: UITextField!
    @IBOutlet weak var phoneTxtField: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var SignInBtn: UIButton!
    @IBOutlet weak var recovaryPasswordBtn: UIButton!
    @IBOutlet weak var registerStack: UIStackView!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var emailView: UIView!
  
    
    
    @IBOutlet weak var SignUpStack: UIStackView!
    static var ID = String(describing: LoginAndSignUpVC.self)
    var state = ""
    var username = "a@gmail.com"
    var password = "123"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uiSetUp()
    }
    
    
    
    func uiSetUp(){
        if state == "login"{
            emailView.isHidden = true
            phoneView.isHidden = true
            SignInBtn.setTitle("Sign In", for: .normal)
            registerStack.isHidden = false
            SignUpStack.isHidden = true
            
        }else{
            emailView.isHidden = false
            phoneView.isHidden = false
            SignInBtn.setTitle("Register", for: .normal)
            recovaryPasswordBtn.isHidden = true
            registerStack.isHidden = true
            SignUpStack.isHidden = false
        }
            
    }
    
    
    @IBAction func registerNowBtn(_ sender: Any) {
        emailView.isHidden = false
        phoneView.isHidden = false
        SignInBtn.setTitle("Register", for: .normal)
        recovaryPasswordBtn.isHidden = true
        registerStack.isHidden = true
        SignUpStack.isHidden = false
        
    }
    
    @IBAction func signInBtn(_ sender: Any) {
        emailView.isHidden = true
        phoneView.isHidden = true
        SignInBtn.setTitle("Sign In", for: .normal)
        registerStack.isHidden = false
        SignUpStack.isHidden = true
        recovaryPasswordBtn.isHidden = false
    }
    
    @IBAction func loginOrSignUpBtnBtn(_ sender: UIButton) {
     
        if sender.titleLabel?.text == "Sign In"{
            if userNmaeTxtfield.text == username && passwordTxtField.text == password{
                UserDefaults.standard.set(true, forKey: "loged")
                let vc = storyboard?.instantiateViewController(withIdentifier: ChoosePageVC.ID) as! ChoosePageVC
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                present(vc, animated: true)
               
            }
            
            
           
            
        }
        
        
        
    }
}
