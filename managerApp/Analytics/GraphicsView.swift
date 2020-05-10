//
//  GraphicsView.swift
//  managerApp
//
//  Created by Роман Верко on 09.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Firebase

struct GraphicsView: View {
    var uniq: String
    var teammate: Teammate
    @ObservedObject var results:observer = observer(teammate: Teammate(), uniq: "")
    let formatter = DateFormatter()
    
    init(mate: Teammate, uniq: String){
        self.uniq = uniq
        teammate = mate
        results = observer(teammate: mate, uniq: uniq)
        self.formatter.dateFormat = "MMM d, h:mm"
    }
    
    
    class observer: ObservableObject{
        
        @Published var checks = [doneCheck]()
        
        init(teammate: Teammate, uniq:String){
            let db = Firestore.firestore().collection("results")
                .whereField("email", isEqualTo: (teammate.email))
                .whereField("name", isEqualTo: uniq)
            
            db.addSnapshotListener{ (snap, err) in
                
                if err != nil{
                    print((err?.localizedDescription)!)
                    return
                }
                Firestore.firestore().clearPersistence { (err) in
                    print((err?.localizedDescription)!)
                }
                self.checks = []
                for i in snap!.documents {
                    let check = doneCheck(name: i["name"] as? String ?? "",
                                          desc: i["desc"] as? String ?? "",
                                          type: i["type"] as? String ?? "",
                                          dttm: i["date"] as? String ?? "",
                                          aim: i["aim"] as? String ?? "",
                                          achievements: i["achievements"] as? String ?? "",
                                          dateDone: i["dateDone"] as? String ?? "",
                                          progress: i["progress"] as? Double ?? 0.0,
                                          done: i["done"] as? Bool ?? false)
                    self.checks.append(check)
                }
                self.checks.sort(by: { $0.dateDone > $1.dateDone })
                
            }
        }
        
    }
    
    
    var body: some View {
        VStack(alignment: .center){
            Text(self.uniq)
                .font(.largeTitle)
                .padding(.top, -45)
          
            if self.results.checks.filter {$0.done == true}.count != 0 {
                VStack(spacing: 10){
                    Text(self.results.checks[0].desc)
                    Text("by \(teammate.name)")
                }
                List(self.results.checks.filter {$0.done == true}){ check in
                    NavigationLink(destination: DetailedAnalyticsView(check: check)){
                        HStack{
                            Text("\(check.dateDone)")
                               .frame(width: 100.0)
                            ZStack(alignment: .leading){
                                Rectangle()
                                    .fill(self.getcol(i: check.progress))
                                    .frame(width: CGFloat((check.progress == 0 ? 0.5 : check.progress) * 40.0), height: 10.0)
                                    .cornerRadius(4)
                                    .zIndex(1)
                                ForEach(1..<6) { mark in
                                  Rectangle()
                                    .fill(Color("myGray"))
                                    .offset(x: CGFloat(mark) * 40.0)
                                    .frame(width: 1.0)
                                    .zIndex(0)
                                    
                                }
                            }
                            
                            Spacer()
                        }
                    }
                }.padding(.top, 20)
            } else {
                Spacer()
                Text("This user do not have any completed checkpoints from \(self.uniq)")
                .padding()
                .font(.system(size: 17, weight: .light))
                Spacer()
            }
            
        }
    }
    
    func getcol(i:Double) -> Color {
        switch i {
        case 0:
            return Color.init(red: 255/255, green: 0, blue: 0)
        case 1:
        return Color.init(red: 255/255, green: 128/255, blue: 0)
        case 2:
        return Color.init(red: 230/255, green: 230/255, blue: 0)
        case 3:
        return Color.init(red: 200/255, green: 255/255, blue: 0)
        case 4:
        return Color.init(red: 128/255, green: 255/255, blue: 0)
        case 5:
        return Color.init(red: 0, green: 255/255, blue: 0)
        default:
            return Color.black
        }
    }
}

struct doneCheck:Identifiable {
    
    internal init(name: String = "", desc: String = "", type: String = "", dttm: String = "", aim: String = "", achievements: String = "",  dateDone: String = "", progress: Double = 0.0, done: Bool) {
        self.name = name
        self.desc = desc
        self.type = type
        self.dttm = dttm
        self.aim = aim
        self.achievements = achievements
        self.dateDone = dateDone
        self.progress = progress
        self.done = done
    }
    
    var id = UUID()
    var name:String = ""
    var desc:String = ""
    var type:String = ""
    var dttm : String = ""
    var dateDone = ""
    var fireID: String = ""
    var aim:String = ""
    var achievements = ""
    var progress = 0.0
    var done = true
}

struct GraphicsView_Previews: PreviewProvider {
    static var previews: some View {
        GraphicsView(mate: Teammate(), uniq: "")
    }
}
