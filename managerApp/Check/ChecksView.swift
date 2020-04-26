//
//  ChecksView.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct ChecksView: View {

    @EnvironmentObject var session: SessionStore
    
    var checkouts: [CheckItem] = [
        CheckItem(name: "Everyday check", desc: "code review", color: .green),
        CheckItem(name: "Mood analisys", desc: "additional metric", color: .red),
        CheckItem(name: "Module datacheck", desc: "project possibilities", color: .green)]
    
    
    
    var body: some View {
        List(checkouts){ item in
            NavigationLink(destination: CheckSettings(checkItem: item)){
                  CheckItem(item: item)
            }
        }.navigationBarTitle("Checkouts")
        .navigationBarItems(trailing:
        Button(action:{
            self.session.isPresentedCheckSet.toggle()
        }){
            Image(systemName:"plus.app")
                .font(.largeTitle)
                .foregroundColor(.gray)
            }
        ).sheet(isPresented: $session.isPresentedCheckSet){
            CheckSettings(checkItem: CheckItem())
                .environmentObject(self.session)
        }
    }
}

struct ChecksView_Previews: PreviewProvider {
    static var previews: some View {
        ChecksView()
        .environmentObject(SessionStore())
    }
}
