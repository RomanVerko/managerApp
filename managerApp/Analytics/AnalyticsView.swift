//
//  SwiftUIView.swift
//  managerApp
//
//  Created by Роман Верко on 06.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase

struct AnalyticsView: View {
    var strengths = ["Mild", "Medium", "Mature"]
    @State private var selectedStrength = 0
    @ObservedObject var userDatas = observer()

    @State var teammates:[Teammate] = []
       
       
       class observer: ObservableObject{
            
           @Published var userData = [Teammate]()
           @Published var cards = [AnalyticCardView]()
           
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
                       self.cards.append(AnalyticCardView(mate: mate))
                   }
                   
               }
           }
           
       }
    
    var cards:[AnalyticCardView] = [AnalyticCardView(mate: Teammate(pic: "", name: "radmir", role: "developer", email: "rmimamov@edu.hse.ru", isActive: true)),AnalyticCardView(mate: Teammate(pic: "", name: "Andrew", role: "developer", email: "rmimamov@edu.hse.ru", isActive: true)),AnalyticCardView(mate: Teammate(pic: "", name: "Danya", role: "developer", email: "rmimamov@edu.hse.ru", isActive: true)), AnalyticCardView(mate: Teammate(pic: "", name: "Danya", role: "developer", email: "rmimamov@edu.hse.ru", isActive: true))]
    
    var body: some View {
        VStack{
            ScrollView(.vertical, showsIndicators: false) {
               VStack() {
                ForEach(self.userDatas.cards) { card in
                    NavigationLink(destination: UserAnalyticsView()){
                       VStack {
                           GeometryReader { geo in
                                card
                               .padding()
                               .rotation3DEffect(Angle(degrees: (Double(geo.frame(in: .global).minX) + 40) / 20 ), axis: (x:0, y:0, z: 0))
                           }.frame(width: 350,height:210)
                       }
                       .frame(width: 350, height:200)
                    }
                   }
               }
               .padding(.top, -60)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        AnalyticsView()
    }
}
}
