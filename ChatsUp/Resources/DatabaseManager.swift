//
//  DatabaseManager.swift
//  ChatsUp
//
//  Created by Tahir Atakan Can on 17.12.2023.
//

import Foundation
import FirebaseDatabase
import UIKit



/*final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    /*public func test() {
        
        database.child("foo").setValue(["something": true])
        
    }*/
}

// MARK: - Account Management




extension DatabaseManager {
    
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void )) {
        
        let safeEmail = email.replacingOccurrences(of: ".", with: "-")
                        .replacingOccurrences(of: "@", with: "-")
                        //.trimmingCharacters(in: <#T##CharacterSet#>)
        
        
        database.child(email).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
                
            }
            
            completion(true)
            
        })
        
    }
    
    
    
    public func insertUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}



struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    // let profilePictureUrl: String
    
    
}
*/
