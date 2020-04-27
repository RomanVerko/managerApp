//
//  PersonSettings.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct PersonSettings:Identifiable, View {
    var person:Teammate
    @State var name:String = ""
    @State var role:String = ""
    @State var isPushOn = true
    @State private var didTap:Bool = false
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    var id = UUID()
    var pic:String = "user"
    var team:String = "HSE team"
    
    init(person: Teammate){
        self.person = person
        self.name = person.name
        self.role = person.role
    }
    
    
    var body: some View {
        VStack(spacing: 15){
        Image(person.pic)
            .resizable()
            .clipShape(Circle())
            .overlay(
                Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
                .aspectRatio(contentMode: .fit)
                .frame(width: 230)
            .padding(.top, 10)
            
            
            Text("Name").padding(.top, 20)
                .font(.headline)
          
            TextField("\(person.name)", text: $name)
            .font(.system(size: 14))
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                        lineWidth: 1))
            
            Text("Team role").padding(.top, 5)
            .font(.headline)
            
            TextField("\(person.role)", text: $role)
                       .font(.system(size: 14))
                       .padding(12)
                       .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                                   lineWidth: 1))
            
            Toggle(isOn: $isPushOn){
                Text("Active member")
            }.padding(.top, 30)
            
            Spacer()
            
            Group{
                Button(action: {
                    if (self.name != "" && self.role != ""){
                        self.session.db.collection("users")
                            .document(self.name)
                            .setData(["name":self.name,
                                      "role":self.person.pic,
                                      "pic":self.pic,
                                      "team":self.team,
                                      "isActive":self.isPushOn
                                    
                            ]){ err in
                                      if let err = err {
                                          print("Error adding document: \(err)")
                                      } else {
                                        print("Document added with ID: \(self.self.name.lowercased().trimmingCharacters(in: .whitespaces))")
                                      }
                                            
                            }
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                }){
                    Text(didTap ? "Done!" : "Submit")
                    .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(LinearGradient(gradient: Gradient(colors: [.green ,.blue]), startPoint: .leading , endPoint: .trailing))
                    .cornerRadius(5)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 35)
            }
            
        }.padding(.horizontal)
            .navigationBarTitle(person.name)
        
    }
}

struct PersonSettings_Previews: PreviewProvider {
    static var previews: some View {
        PersonSettings(person: Teammate(pic: "Andrew", name: "Andrew Akhapkin", role: "Backend developer"))
         .environmentObject(SessionStore())
    }
}
