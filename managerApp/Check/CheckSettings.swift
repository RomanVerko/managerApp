//
//  CheckSettings.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct CheckSettings:Identifiable, View {
    var checkItem:CheckItem
    @State var name:String
    @State var desc: String
    @State private var didTap:Bool = false
    @State private var selectorIndex:Int
    @State private var mode = ["Module results", "Mental health"]
    @State var isActive:Bool
    @EnvironmentObject var session: SessionStore
    @Environment(\.presentationMode) var presentationMode
    var id = UUID()

    init(checkItem: CheckItem){
        self.checkItem = checkItem
        _isActive = State(initialValue: checkItem.isActive)
        _name = State(initialValue: checkItem.name)
        _desc = State(initialValue: checkItem.desc)
        if checkItem.type == "Module results" {
            _selectorIndex = State(initialValue: 0)
        } else {
            _selectorIndex = State(initialValue: 1)
        }
    }
    
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
            
            Group{
                VStack {
                    Button(action: {
                       if (self.name == "" && self.desc != ""){
                           self.name = self.checkItem.name
                       } else if (self.name != "" && self.desc == ""){
                           self.desc = self.checkItem.desc
                       } else if (self.name == "" && self.desc == ""){
                           self.name = self.checkItem.name
                           self.desc = self.checkItem.desc
                       }
                        self.session.db.collection("users").whereField("isActive", isEqualTo: true).getDocuments() { (querySnapshot, err) in
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    for document in querySnapshot!.documents {
                                        let userData = document.data()
                                        print(userData["email"] as? String ?? "not email at all")
                                    }
                                }
                        }
                        
//                            self.session.db.collection(self.mode[self.selectorIndex])
//                                .document(self.checkItem.fireID)
//                                .setData(["date":Date(),
//                                          "name":self.name,
//                                          "type":self.mode[self.selectorIndex],
//                                          "desc":self.desc], merge: true){ err in
//                                            if let err = err {
//                                                print("Error adding document: \(err)")
//                                            } else {
//                                                print("Document added with ID: \(self.name.lowercased().trimmingCharacters(in: .whitespaces))")
//                                            }
//                            }
                                   
                    }) {
                        HStack {
                            Text("Send")
                            Image(systemName: "envelope.fill").font(.headline)
                        }
                    }.buttonStyle(GradientButtonStyle())
                }
                
                
            }
            Spacer()
            
            Group{
                
                
                Button(action: {
                    if (self.name == "" && self.desc != ""){
                        self.name = self.checkItem.name
                    } else if (self.name != "" && self.desc == ""){
                        self.desc = self.checkItem.desc
                    } else if (self.name == "" && self.desc == ""){
                        self.name = self.checkItem.name
                        self.desc = self.checkItem.desc
                    }
                
                        self.session.db.collection("checkouts")
                            .document(self.checkItem.fireID)
                            .setData(["date":Date(),
                                      "name":self.name,
                                      "isActive":self.isActive,
                                      "type":self.mode[self.selectorIndex],
                                      "desc":self.desc], merge: true){ err in
                                        if let err = err {
                                            print("Error adding document: \(err)")
                                        } else {
                                            print("Document added with ID: \(self.name.lowercased().trimmingCharacters(in: .whitespaces))")
                                        }
                        }
                    
                            
                        self.session.isPresentedCheckSet = false
                        self.presentationMode.wrappedValue.dismiss()
                }){
                    Text(didTap ? "Done!" : "Save changes")
                    .frame(minWidth: 0, maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .bold))
                        .background(LinearGradient(gradient: Gradient(colors: [.green ,.blue]), startPoint: .leading , endPoint: .trailing))
                    .cornerRadius(5)
                    
                }
                .buttonStyle(SizeButtonStyle())
                .padding(.horizontal, 40)
                
            }
            
        }.navigationBarTitle(checkItem.name)
            .padding(.horizontal, 40)
            .padding(.bottom, 15)
    }
}

struct SizeButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(15.0)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct CheckSettings_Previews: PreviewProvider {
    static var previews: some View {
        CheckSettings(checkItem: CheckItem())
        .environmentObject(SessionStore())
    }
}
