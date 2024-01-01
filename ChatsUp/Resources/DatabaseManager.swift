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
    
    public func test () {
        database.child("blabla").setValue(["something": true])
    }
    
    
}







