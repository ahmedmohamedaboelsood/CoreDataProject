//
//  LoginAndSignUpVC.swift
//  coreDatatest
//
//  Created by Ahmed on 02/03/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth


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
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        uiSetUp()
    }
    
    
    func resetTxtFields(){
        userNmaeTxtfield.text = ""
        emailTxtField.text = ""
        passwordTxtField.text = ""
        phoneTxtField.text = ""
    }
    
    
    func loginState(){
        resetTxtFields()
        emailView.isHidden = true
        phoneView.isHidden = true
        SignInBtn.setTitle("Sign In", for: .normal)
        registerStack.isHidden = false
        SignUpStack.isHidden = true
    }
    
    
    func registerState(){
        resetTxtFields()
        emailView.isHidden = false
        phoneView.isHidden = false
        SignInBtn.setTitle("Register", for: .normal)
        recovaryPasswordBtn.isHidden = true
        registerStack.isHidden = true
        SignUpStack.isHidden = false
    }
    
    
    func uiSetUp(){
        if state == "login"{
            loginState()
        }else{
            registerState()
        }
    }
    
    func emailSignUp(){
        
        guard let email = emailTxtField.text , !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(massege: "Enter Email")
            return
        }
        
        guard let name = userNmaeTxtfield.text , !name.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(massege: "Enter Username")
            return
        }
        guard let phone = phoneTxtField.text , !phone.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(massege: "Enter Phone Number")
            return
        }
        guard let password = passwordTxtField.text , !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(massege: "Enter Password")
            return
        }
        
        signUp(email: email, password: password) { error in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                self.showAlert(massege: error.localizedDescription)
            } else {
                //self.showAlertWithNavigation(massege: "User signed up successfully")
               
                self.showAlert(massege: "User signed up successfully")
                self.loginState()
            }
        }
    }
    
    
    func emailSignIn(){
        guard let email = emailTxtField.text , !email.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(massege: "Enter Email")
            return
        }
        guard let password = passwordTxtField.text , !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            showAlert(massege: "Enter Password")
            return
        }
        signIn(email: email, password: password) { error in
            if let error = error {
                self.showAlert(massege: error.localizedDescription)
                    print("Error signing in: \(error.localizedDescription)")
                } else {
                    UserDefaults.standard.set(true, forKey: "loged")
                    self.showAlertWithNavigation(massege: "User signed in successfully")
                }

        }
        
    }
    
    func signUp(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }

    func signIn(email: String, password: String, completion: @escaping (_ error: Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    
    
    
    
    @IBAction func registerNowBtn(_ sender: Any) {
        registerState()
        
    }
    
    @IBAction func signInBtn(_ sender: Any) {
       loginState()
    }
    
    @IBAction func loginOrSignUpBtnBtn(_ sender: UIButton) {
        if sender.titleLabel?.text == "Sign In"{
            emailSignIn()
            }else{
                emailSignUp()
            }
        }
}
 
