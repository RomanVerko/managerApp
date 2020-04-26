//
//  TeamView.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct TeamView: View {
    
    @EnvironmentObject var session: SessionStore
    
    var teammates:[Teammate] = [Teammate(pic: "Andrew", name: "Andrey Akhapkin", role: "Back-end developer"),
    Teammate(pic: "Danya", name: "Daniil Pleshkov", role: "DWS developer"),
    Teammate(pic: "Radmir", name: "Radmir Imamov", role: "Front-end developer"),
    Teammate(pic: "Sasha", name: "Alexandr Manuilov", role: "Front-end developer") 
    ]
    
    var body: some View {
        VStack{
        List(teammates){ mate in
            NavigationLink(destination: PersonSettings(person: mate)){
               Teammate(pic: mate.pic, name: mate.name, role: mate.role)
            }
        }.navigationBarTitle("Your teammates")
        .navigationBarItems(trailing:
            Button(action:{}){
                Image(systemName:"plus.circle")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
            )
        
        Spacer()
        
            Button(action:session.signOut){
                Text("Sign out")
                .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [.green,.blue]), startPoint: .leading , endPoint: .trailing))
                .cornerRadius(5)
            }.padding(.horizontal, 60)
                .padding(.bottom, 10)
    
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView().environmentObject(SessionStore())
    }
}
