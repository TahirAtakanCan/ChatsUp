//
//  ViewController.swift
//  ChatsUp
//
//  Created by Tahir Atakan Can on 11.11.2023.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        
        
        
        DatabaseManager.shared.test()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = UserDefaults.standard.bool(forKey: "logged_in ")
        
        validateAuth()
        
    }
    
    private func validateAuth(){
        
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }


}

