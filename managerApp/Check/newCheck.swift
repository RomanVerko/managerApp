//
//  newCheck.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct newCheck: View {
    
    @EnvironmentObject var session: SessionStore
    var checkItem:CheckItem
    @State var name:String=""
    @State var desc: String = ""
    @State private var didTap:Bool = false
    @State private var selectorIndex = 0
    @State private var numbers = ["Module results", "Mental health"]
    @State var isActive:Bool = true
    
    

    var body: some View {
        VStack(spacing: 15){
            
            Text("Name").padding(.top, 20)
                  .font(.headline)
                .padding(.top, 60)
            
            TextField("\(checkItem.name)", text: $name)
            .font(.system(size: 14))
            .padding(12)
            .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                        lineWidth: 1))
            
            Text("Description").padding(.top, 5)
            .font(.headline)
            
            TextField("\(checkItem.desc)", text: $desc)
                  .font(.system(size: 14))
                  .padding(12)
                  .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                              lineWidth: 1))
            
           
            Picker("Numbers", selection: $selectorIndex) {
                ForEach(0..<numbers.count) { index in
                    Text(self.numbers[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Divider()
            
            Toggle(isOn: $isActive){
                Text("Active notification")
            }.padding()
            
            Spacer()
            
            Group{
                Button(action: {
                    self.session.isPresentedCheckSet.toggle()
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
            
        }.navigationBarTitle(checkItem.name)
            .padding(.horizontal, 40)
            .padding(.bottom, 35)
    }
}

struct newCheck_Previews: PreviewProvider {
    static var previews: some View {
        newCheck(checkItem: CheckItem())
        .environmentObject(SessionStore())
    }
}
