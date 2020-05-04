//
//  Teammate.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct Teammate: Identifiable,View {
    var id = UUID()
    var pic:String
    var name:String
    var role:String
    var email:String=""
    var isActive:Bool
  
    
    init(){
        self.id = UUID()
        self.pic = "user"
        self.name = "username"
        self.role = "role"
        self.isActive = true
    }

    init(pic: String, name: String, role: String, isActive: Bool){
        self.id = UUID()
        self.pic = pic
        self.name = name
        self.role = role
        self.isActive = isActive
    }
    
    init(pic: String, name: String, role: String, email:String, isActive:Bool){
        self.id = UUID()
        self.pic = pic
        self.name = name
        self.role = role
        self.email = email
        self.isActive = isActive
    }
    
    init(mate: Teammate){
        self.id = UUID()
        self.pic = mate.pic
        self.name = mate.name
        self.role = mate.role
        self.isActive = mate.isActive
    }
    
    var body: some View {
        HStack{
            Image(pic)
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 5)
                .aspectRatio(contentMode: .fit)
                .frame(width: 70)
            VStack{
                Text(name)
                    .multilineTextAlignment(.center)
                Text(role)
                    .font(.caption)
                    .foregroundColor(.gray)
            }.padding()
        }
    }
}

struct Teammate_Previews: PreviewProvider {
    static var previews: some View {
        Teammate(pic: "Andrew", name: "Andrey Akhapkin", role: "Back-end developer", isActive: true)
    }
}
