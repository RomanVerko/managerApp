//
//  TabbedView.swift
//  managerApp
//
//  Created by Роман Верко on 26.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI


struct TabbedView: View {
    @EnvironmentObject var session: SessionStore
    var body: some View {
        TabView{
            NavigationView{TeamView()}.tabItem({
            Image(systemName: "person.3.fill")
                .font(.title)
            Text("Team")
            }).tag(0)
            
            NavigationView{ChecksView()}.tabItem({
            Image(systemName: "square.and.arrow.up.fill")
                .font(.title)
            Text("Checkouts")
            }).tag(1)
        }
    }
}

struct TabbedView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedView()
    }
}
