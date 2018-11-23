//
//  DataService.swift
//  MapMe
//
//  Created by Adam Rikardsen-Smith on 18/11/2018.
//  Copyright © 2018 Adam Rikardsen-Smith. All rights reserved.
//

import Foundation
import FirebaseCore
import Firebase

let DB_BASE = Database.database().reference()

class DataService{
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_LOCATIONS = DB_BASE.child("locations")
    
    static var instance: DataService = DataService()
    
    var REF_BASE: DatabaseReference{
        return _REF_BASE
    }
    
    var REF_USERS: DatabaseReference{
        return _REF_USERS
    }
    
    var REF_LOCATIONS: DatabaseReference{
        return _REF_LOCATIONS
    }
    
    
    func createFirebaseDBUser(uid: String, userData: Dictionary<String, Any>) {
            REF_USERS.child(uid).updateChildValues(userData)
    }
}
