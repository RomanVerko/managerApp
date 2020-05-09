//
//  UserAnalyticsView.swift
//  managerApp
//
//  Created by Роман Верко on 07.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase

struct UserAnalyticsView: View {
    var teammate: Teammate
     @ObservedObject var results:observer = observer(teammate: Teammate())
       
    init(mate: Teammate){
           teammate = mate
           results = observer(teammate: mate)
    }
       
    
    class observer: ObservableObject{
               
        @Published var checkNames = [String]()
        @Published var uniqNames = Array<String>()
              
           init(teammate: Teammate){
                  let db = Firestore.firestore().collection("results")
                   .whereField("email", isEqualTo: (teammate.email))
                  
                   db.addSnapshotListener{ (snap, err) in
                       
                      if err != nil{
                          print((err?.localizedDescription)!)
                          return
                      }
                      Firestore.firestore().clearPersistence { (err) in
                          print((err?.localizedDescription)!)
                      }
                    
                    for i in snap!.documents {
                        self.checkNames.append(i["name"] as? String ?? "no data srtring")
                        
                    }
                    
                    self.uniqNames = Array(Set(self.checkNames))
                  }
            }
              
    }
    
    
    
    var body: some View {
        VStack{
            VStack{
                Text(self.teammate.name)
                    .font(.largeTitle)
                Text(self.teammate.email)
                if self.results.uniqNames.count == 0{
                    Spacer()
                    Text("This user do not have any completed checkpoints")
                    .font(.system(size: 17, weight: .light))
                    Spacer()
                }
            }.padding(.top, -45)
            Spacer()
            if self.results.uniqNames.count != 0{
                List(self.results.uniqNames, id: \.self){ uniq in
                    NavigationLink(destination: GraphicsView(mate: self.teammate, uniq: uniq)){
                        Text(uniq)
                    }
                }.padding(.top, 20)
            }
        }.padding(.horizontal, 10)
        
    }
    
   
}



struct UserAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        UserAnalyticsView(mate: Teammate())
    }
}
