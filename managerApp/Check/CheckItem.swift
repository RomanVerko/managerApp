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
    var color:Color = Color.green
    var name:String = ""
    var desc:String = ""
    
    init(){
        color = Color.red
        name = "New checkout"
        desc = "Everyday notification"
    }
    
    init(name: String, desc: String, color: Color){
        self.color = color
        self.desc = desc
        self.name = name
    }
    
    init(item: CheckItem){
        self.color = item.color
        self.desc = item.desc
        self.name = item.name
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
