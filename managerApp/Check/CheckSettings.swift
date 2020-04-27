//
//  CheckSettings.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct CheckSettings:Identifiable, View {
    var checkItem:CheckItem
    @State var name:String=""
    @State var desc: String = ""
    @State private var didTap:Bool = false
    @State private var selectorIndex = 0
    @State private var mode = ["Module results", "Mental health"]
    @State var isActive:Bool = true
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    var id = UUID()
    

    var body: some View {
        VStack(spacing: 15){
            
            Text("Name").padding(.top, 20)
                  .font(.headline)
            
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
                ForEach(0..<mode.count) { index in
                    Text(self.mode[index]).tag(index)
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
                    if (self.name != "" && self.desc != ""){
                        if self.selectorIndex == 0{
                            self.session.db.collection("checkouts")
                            .document(self.name.lowercased().trimmingCharacters(in: .whitespaces))
                            .setData(["date":Date(),
                                      "isActive":self.isActive,
                                      "type":self.mode[self.selectorIndex],
                                      "desc":self.desc]){ err in
                                          if let err = err {
                                              print("Error adding document: \(err)")
                                          } else {
                                            print("Document added with ID: \(self.name.lowercased().trimmingCharacters(in: .whitespaces))")
                                          }
                            }
                        } else {
                            
                        }
                        self.session.isPresentedCheckSet = false
                        self.presentationMode.wrappedValue.dismiss()
                    }
                   
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

struct CheckSettings_Previews: PreviewProvider {
    static var previews: some View {
        CheckSettings(checkItem: CheckItem())
        .environmentObject(SessionStore())
    }
}
