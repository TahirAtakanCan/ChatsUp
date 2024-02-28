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
    
    private let database = Database.database(url: "https://chatsupfirebase-79809-default-rtdb.europe-west1.firebasedatabase.app").reference()
    
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}


// MARK: - Account Managment

extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping (Bool)-> Void) {
        
        let safeEmail = email.replacingOccurrences(of: ".", with: "-").replacingOccurrences(of: "@", with: "-")
        
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
        
    }
    
    /// Insert new user to database
    public func insertUser(with user: ChatsUpUser, completion: @escaping (Bool) -> Void) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ], withCompletionBlock: { error, _ in
            guard error == nil else{
                print("failed ot write to database ")
                completion(false)
                return
            }
            
            self.database.child("users").observeSingleEvent(of: .value, with: { snapshot in
                if var usersCollection = snapshot.value as? [[String: String]] {
                    // append to user dictionary
                    let newElement = [
                        "name": user.firstName + " " + user.lastName,
                        "email": user.safeEmail
                    ]
                    usersCollection.append(newElement)
                    
                    self.database.child("users").setValue(usersCollection, withCompletionBlock: { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        completion(true)
                    })
                }
                    // create that array
                let newCollecttion: [[String: String]] = [
                    [
                        "name": user.firstName + " " + user.lastName,
                        "email": user.safeEmail
                    ]
                ]
                
                self.database.child("users").setValue(newCollecttion, withCompletionBlock: { error, _ in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                    completion(true)
                })
            })
            
            completion(true)
        })
    }
    
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void ) {
        database.child("users").observeSingleEvent(of: .value, with: {snapshot in
            guard let value = snapshot.value as? [[String: String]] else {
                completion(.failure(DatabaseError.failedToFetch))
                return
            }
            completion(.success(value))
        })
    }
    
    public enum DatabaseError: Error {
        case failedToFetch
    }
    
    /*
     users -> [
        [
            "name":
            "safe_email":
        ],                      Database Design
        [
            "name":
            "safe_email":
        ]
     ]
     */
    
    
}

// MARK: - Sending Messages / Conversation

extension DatabaseManager {
    
    /// Creates a new conversation with targer user email and first message sent
    public func createNewConversation(with otherUserEmail: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
        
    }
    
    /// Fetches and returns all conversation for the user with passed in email
    public func getAllConversation(for email: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    ///  Gets all messages for a given conversation
    public func getAllMessagesForConversation(with id: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    /// Sends a message with target conversation and message
    public func sendMessage(to conversation: String, message: Message, completion: @escaping (Bool) -> Void) {
        
    }
}




struct ChatsUpUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
        
    
    var profilePictureFileName: String {
        //images/atkan4202-gmail-com_profile_picture.png/
        return "\(safeEmail)_profile_picture.png"
    }
    
    
}







