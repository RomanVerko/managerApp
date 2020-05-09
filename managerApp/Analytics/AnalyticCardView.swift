//
//  AnalyticCardView.swift
//  managerApp
//
//  Created by Роман Верко on 06.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase

struct AnalyticCardView: Identifiable, View {
    var id = UUID()
    var teammate:Teammate = Teammate()
    var moduleRes:Int = 12
    var mentalRes:Int = 9
    @ObservedObject var results:observer = observer(teammate: Teammate())
    
    init(mate: Teammate){
        results = observer(teammate: mate)
        teammate = mate
    }
    
    class observer: ObservableObject{
            
        @Published var module = 0
        @Published var mental = 0
           
        init(teammate: Teammate){
               let db = Firestore.firestore().collection("results")
                .whereField("email", isEqualTo: (teammate.email))
                .whereField("type", isEqualTo: "Mental health")
               
                db.addSnapshotListener{ (snap, err) in
                    
                   if err != nil{
                       print((err?.localizedDescription)!)
                       return
                   }
                    
                   self.mental = 0
                
                   Firestore.firestore().clearPersistence { (err) in
                       print((err?.localizedDescription)!)
                   }
                    
                    print(snap!.documents.count)
                    self.mental = snap!.documents.count
               }
            
            let db2 = Firestore.firestore().collection("results")
             .whereField("email", isEqualTo: (teammate.email))
             .whereField("type", isEqualTo: "Module results")
            
             db2.addSnapshotListener{ (snap, err) in
                 
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                 
                self.module = 0
             
                Firestore.firestore().clearPersistence { (err) in
                    print((err?.localizedDescription)!)
                }
                 print(snap!.documents.count)
                 self.module = snap!.documents.count
            }
           }
           
       }
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(LinearGradient(
                    gradient: .init(colors: [.firstColor, .secondColor]),
                    startPoint: .init(x: 0.4, y: 0.1),
                  endPoint: .init(x: 0.5, y: 0.8)
                ))
                .frame(width: 320, height: 130, alignment: .center)
                .cornerRadius(20)
                .shadow(radius: 5)
                
            VStack{
                HStack {
                    VStack(alignment: .leading) {
                        Text(teammate.name)
                            .font(.system(size: 20, weight: .medium))
                        Text(teammate.role)
                            .font(.system(size: 15, weight: .light))
                    }.padding(.horizontal, 10)
                        
                    Spacer()
                }
               
                
                HStack {
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Module results:  \(self.results.module)")
                        Text("Mental health:    \(self.results.mental)")
                        }
                 .padding(.horizontal, 20)
                }
            }.foregroundColor(.black)
        }
    }
}

struct AnalyticCardView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticCardView(mate: Teammate(pic: "", name: "Andrew A", role: "back dev", email: "rmimamov@edu.hse.ru", isActive: true))
    }
}

extension Color {
    static let secondColor = Color("secondColor")
    static let firstColor = Color("firstColor")

}
