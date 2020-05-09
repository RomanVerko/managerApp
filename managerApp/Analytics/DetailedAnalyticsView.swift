//
//  DetailedAnalyticsView.swift
//  managerApp
//
//  Created by Роман Верко on 09.05.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI

struct DetailedAnalyticsView: View {
    var check:doneCheck
    var body: some View {
        VStack(alignment: HorizontalAlignment.center, spacing: 10){
            if check.type == "Module results"{
                HStack {
                    Text("The aim was:")
                        .font(.largeTitle)
                    Spacer()
                }
                HStack {
                    Text("📌 \(check.aim)")
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Text("What has been done:")
                        .font(.largeTitle)
                    Spacer()
                }.padding(.top, 30)
                
                HStack {
                    Text("✅ \(check.achievements)")
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Text("Progress  -  \(Int(check.progress))\\5")
                        .font(.system(size: 20))
                        .padding(.top, 20)
                    Spacer()
                }
            } else{
                HStack {
                    Text("The mood was:")
                        .font(.largeTitle)
                    Spacer()
                }
                HStack {
                    Text("😏 \(check.aim)")
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Text("Because of:")
                        .font(.largeTitle)
                    Spacer()
                }.padding(.top, 30)
                
                HStack {
                    Text("🟡 \(check.achievements)")
                        .font(.system(size: 20))
                    Spacer()
                }
                HStack {
                    Text("Moody on   \(Int(check.progress))\\5")
                        .font(.system(size: 20))
                        .padding(.top, 20)
                    Spacer()
                }
            }
            Spacer()
        }.navigationBarTitle("\(check.dateDone)")
            .padding( 20)
    }
}

struct DetailedAnalyticsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedAnalyticsView(check: doneCheck(name: "Everyday check", desc: "code review", type: "Module results", dttm: "May 6, 10:53", aim: "to Write a lot of code eah baby", achievements: "2 methods and 100 strings of code", dateDone: "May 6, 10:53", progress: 6.0, done: true))
    }
}
