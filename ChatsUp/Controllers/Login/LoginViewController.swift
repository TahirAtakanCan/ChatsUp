//
//  LoginViewController.swift
//  ChatsUp
//
//  Created by Tahir Atakan Can on 13.11.2023.
//

import UIKit
import FirebaseAuth


class LoginViewController: UIViewController {

    private let scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    private let ImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo1")
        imageView.contentMode  = .scaleAspectFill
        return imageView
    }()
    
    
    private let emailField: UITextField = {
        let field = UITextField()
        let blueGreenColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.placeholder = "E-Mail..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = blueGreenColor
        return field
    }()
    
    
    private let passwordField: UITextField = {
        let field = UITextField()
        let blueGreenColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 2
        field.layer.borderColor = UIColor.darkGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = blueGreenColor
        field.isSecureTextEntry = true
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        let blueGreenColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = blueGreenColor
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .black)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueGreenColor = UIColor(red: 0, green: 0.5, blue: 0.5, alpha: 1)
        view.backgroundColor = blueGreenColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapRegister))
        
        loginButton.addTarget(self, action:
                              #selector(loginButtonTapped),
                              for: .touchUpInside)
        
        emailField.delegate = self
        passwordField.delegate = self
        
        // Add Subview
        view.addSubview(scrollView)
        scrollView.addSubview(ImageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        
        let size = view.width/3
        ImageView.frame = CGRect(x: (view.width-size)/2,
                                 y: 100,
                                 width: size,
                                 height: size)
        
        emailField.frame = CGRect(x: 30,
                                  y: ImageView.bottom + 20,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                  y: emailField.bottom + 20,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        loginButton.frame = CGRect(x: 30,
                                  y: passwordField.bottom + 20,
                                  width: scrollView.width - 60,
                                  height: 52)
        
        
    }
    
    @objc private func loginButtonTapped () {
        
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text, let password = passwordField.text,
              !email.isEmpty, !password.isEmpty, password.count >= 6 else {
                  alertUserLoginError()
                  return
              }
        // Firebase
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] AuthDataResult, error in
            guard let strongSelf = self else {
                return
            }
            guard let result = AuthDataResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            
            let user = result.user
            print("Logged In User : \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            
        })
        
    }
    
    func alertUserLoginError () {
        let alert = UIAlertController(title: "Error",
                                      message: "Please enter all information to log in.",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss",
                                      style: .cancel,
                                      handler: nil))
        
        present(alert ,animated: true)
        
    }
    
    
    @objc func didTapRegister () {
        let vc = RegisterViewController()
        vc.title = "Create Account"
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension LoginViewController: UITextFieldDelegate {
    // klavye
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }
        else if textField == passwordField {
            loginButtonTapped()
        }
        
        return true
    }
    
}
