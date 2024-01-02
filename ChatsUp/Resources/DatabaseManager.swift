//
//  DatabaseManager.swift
//  ChatsUp
//
//  Created by Tahir Atakan Can on 17.12.2023.
//

import Foundation
import UIKit
import FirebaseDatabase


final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    
}


// MARK: - Account Managment

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping (Bool)-> Void) {
        
        database.child(email).observeSingleEvent(of: .value, with: { snapshot in
            
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
    
    /// Insert new user to database
    public func insertUser(with user: ChatsUpUser) {
        database.child(user.emailAddress).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        
        ])
    }
    
    
}

struct ChatsUpUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //let profilePictureUrl: String
    
    
}







