//
//  DataManager.swift
//  managerApp
//
//  Created by Роман Верко on 02.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Combine

public struct DataManager{
    var db = Firestore.firestore()
    var allusers:[Teammate] = []
    
    init(){
        allusers = getAllUsers()
    }
    
    func getAllUsers()->[Teammate]{
        var team:[Teammate] = []
        db.collection("users").getDocuments { (snapshot, error) in
            if error == nil && snapshot != nil {
                for document in snapshot!.documents{
                    let data = document.data()
                    team.append(Teammate(pic: "user",
                                                  name: data["name"] as! String,
                                                  role: data["role"] as! String,
                                                  email: data["email"] as! String))
                }
            
            }
        }
        print("1) \(team.count)")
        return team
    }
    
}
