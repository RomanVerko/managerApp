//
//  CheckItem.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct CheckItem: Identifiable, View {
    var id = UUID()
    var color:Color = .red
    var name:String = ""
    var desc:String = ""
    var type:String = ""
    var isActive = true
    var dttm : Date = Date()
    var fireID: String = ""
    
    
    init(){
        type = "Module results"
        name = "New checkout"
        desc = "Daily"
        isActive = true
        color = .red
        dttm = Date()
        id = UUID()
    }
    
    init(name: String, desc: String, type: String, isActive: Bool, dttm:Date, fireID: String){
        self.desc = desc
        self.name = name
        self.type = type
        self.isActive = isActive
        if isActive == true{
            self.color = .green
        }  else {
            color = .red
        }
        self.dttm = dttm
        self.fireID = fireID
    }
    
    init(item: CheckItem){
        self.desc = item.desc
        self.name = item.name
        self.type = item.type
        self.isActive = item.isActive
        if isActive == true{
           self.color = .green
       }  else {
           color = .red
       }
        self.dttm = item.dttm
        self.fireID = item.fireID
    }
    
    var body: some View {
        HStack{
           Rectangle()
           .fill(color)
           .frame(width: 20, height: 70, alignment: .center)
           .cornerRadius(2)
            
            VStack{
                HStack(alignment: .bottom){
                    Text(name)
                    .font(.system(size : 30))
                    
                    Spacer()
                }
                HStack{
                    Text(desc)
                    .font(.caption)
                    .foregroundColor(.gray)
                    Spacer()
                    Text(type)
                    .font(.caption)
                        .foregroundColor(.gray)
                }
                
            }.padding()
        }
    }
}

struct CheckItem_Previews: PreviewProvider {
    static var previews: some View {
        CheckItem()
    }
}
