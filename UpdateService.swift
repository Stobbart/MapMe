//
//  UpdateService.swift
//  MapMe
//
//  Created by Adam Rikardsen-Smith on 18/11/2018.
//  Copyright © 2018 Adam Rikardsen-Smith. All rights reserved.
//

import Foundation
import MapKit
import Firebase

class UpdateService{
    
    static var instance: UpdateService = UpdateService()
    
    func updateUserLocation(withCoordinate coordinate: CLLocationCoordinate2D) {
        DataService.instance.REF_USERS.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userSnapshot = snapshot.children.allObjects as? [DataSnapshot] {
                for user in userSnapshot {
                    if user.key == Auth.auth().currentUser?.uid {
                        //DataService.instance.REF_USERS.child(user.key).updateChildValues([COORDINATE: [coordinate.latitude, coordinate.longitude]])
                    }
                }
            }
        })
    }
    
    func createLocation(coordinate: CLLocationCoordinate2D, notes: String){
        let locationData = [LOCATION_COORDINATE: [coordinate.latitude, coordinate.longitude], NOTES: notes, USER_KEY: "khljg"] as [String : Any]
        DataService.instance.REF_LOCATIONS.updateChildValues(locationData)
    }
    
}
