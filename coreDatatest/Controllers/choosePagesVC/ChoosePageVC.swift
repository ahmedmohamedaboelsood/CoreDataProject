//
//  ChoosePageVC.swift
//  coreDatatest
//
//  Created by Ahmed on 05/03/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
class ChoosePageVC: UIViewController {

    
    static var ID = String(describing: ChoosePageVC.self)
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func addProduct(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: AddProductVC.ID) as! AddProductVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    
    @IBAction func goHome(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: SearchForMeal.ID) as! SearchForMeal
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func logOutBtn(_ sender: Any) {
        
        do{
            try Auth.auth().signOut()
        }catch{
            print("error")
        }
        UserDefaults.standard.set(false, forKey: "loged")
        let vc = storyboard?.instantiateViewController(withIdentifier: IntroVC.ID) as! IntroVC
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
        
        
    }
    
}
