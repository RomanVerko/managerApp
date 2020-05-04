//
//  ChecksView.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import Combine

struct ChecksView: View {

    @EnvironmentObject var session: SessionStore
    @ObservedObject var checkoutData = observer()
    
    var checkouts: [CheckItem] = []
//        CheckItem(name: "Everyday check", desc: "code review", color: .green),
//        CheckItem(name: "Mood analisys", desc: "additional metric", color: .red),
//        CheckItem(name: "Module datacheck", desc: "project possibilities", color: .green)]
    
    class observer: ObservableObject{
            
           @Published var checkouts = [CheckItem]()
           
           init(){
               let db = Firestore.firestore().collection("checkouts")
               
               db.addSnapshotListener{ (snap, err) in
                    
                   if err != nil{
                       print((err?.localizedDescription)!)
                       return
                   }
                   self.checkouts = [CheckItem]()
                   Firestore.firestore().clearPersistence { (err) in
                       print((err?.localizedDescription)!)
                   }
                   for i in snap!.documents {
                       print((i["name"] as? String ?? "default name"))
                       print((i["desc"] as? String ?? "default description"))
                       let check = CheckItem(name: i["name"] as? String ?? "default name", 
                                             desc: i["desc"] as? String ?? "default description",
                                             type: i["type"] as? String ?? "Module results",
                                             isActive: i["isActive"] as? Bool ?? true,
                                             dttm: i["date"] as? Date ?? Date(),
                                             fireID: i.documentID)
                    self.checkouts.append(check)
                    self.checkouts.sort(by: { $0.dttm > $1.dttm })
                   }
                   
               }
           }
           
       }
    
    
    
    var body: some View {
//        List(self.checkoutData.checkouts){ item in
//            NavigationLink(destination: CheckSettings(checkItem: item)){
//                  CheckItem(item: item)
//            }
//        }
        List() {
            ForEach(self.checkoutData.checkouts){item in
                NavigationLink(destination: CheckSettings(checkItem: item)){
                      CheckItem(item: item)
                }
            }.onDelete { (index) in
                let id = self.checkoutData.checkouts[index.first!].fireID
                let db = Firestore.firestore().collection("checkouts")
                
                db.document(id).delete { (err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                    print("deleted id: \(id)")
                    self.checkoutData.checkouts.remove(atOffsets: index)
                }
            }
        }
        .navigationBarTitle("Checkouts")
        .navigationBarItems(trailing:
        Button(action:{
            self.session.isPresentedCheckSet.toggle()
        }){
            Image(systemName:"plus.app")
                .font(.largeTitle)
                .foregroundColor(.gray)
            }
        ).sheet(isPresented: $session.isPresentedCheckSet){
            CheckSettings(checkItem: CheckItem())
                .environmentObject(self.session)
        }
    }
}

struct ChecksView_Previews: PreviewProvider {
    static var previews: some View {
        ChecksView()
        .environmentObject(SessionStore())
    }
}
