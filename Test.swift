//
//  Test.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import Foundation
import Firebase

struct Test {
    var db = Firestore.firestore()
    
    init(){
        db.collection("users").addDocument(data: ["name":"Andrey Akhapkin" , "role":"Back-end developer", "pic":"Andrew"])
    }
    
}
