//
//  ContentView.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var session: SessionStore
       
       func getUser(){
           session.listen()
       }
       
    
    var body: some View {
        AnyView({ () -> AnyView in
            if (session.session != nil){
                return AnyView(TabbedView())
            } else {
                return AnyView (AuthView())
            }
        }()).onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(SessionStore())
    }
}
