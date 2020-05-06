//
//  TeamView.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct TeamView: View {
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var userDatas = observer()

   
    
    @State var teammates:[Teammate] = []
    
    
    class observer: ObservableObject{
         
        @Published var userData = [Teammate]()
        
        init(){
            let db = Firestore.firestore().collection("users")
            
            db.addSnapshotListener{ (snap, err) in
                 
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                self.userData = [Teammate]()
                Firestore.firestore().clearPersistence { (err) in
                    print((err?.localizedDescription)!)
                }
                for i in snap!.documents{
                    print((i["name"] as? String ?? "default name"))
                    print((i["role"] as? String ?? "default role"))
                    let mate = Teammate(pic: i["pic"] as? String ?? "user",
                                        name: i["name"] as? String ?? "default name",
                                        role: i["role"] as? String ?? "default role",
                                        email: i["email"] as? String ?? "default email",
                                        isActive: i["isActive"] as? Bool ?? true)
                    self.userData.append(mate)
                }
                
            }
        }
        
    }
    
    var body: some View {
        VStack{
            List(userDatas.userData){ mate in
            NavigationLink(destination: PersonSettings(person: mate)){
                Teammate(mate: mate)
            }
        }.navigationBarTitle("Team")
        Spacer()
        
            Button(action:session.signOut){
                Text("Sign out")
                .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [.green,.blue]), startPoint: .leading , endPoint: .trailing))
                .cornerRadius(5)
            }
            .buttonStyle(SizeButtonStyle())
            .padding(.horizontal, 60)
            .padding(.bottom, 10)
    
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView().environmentObject(SessionStore())
    }
}
