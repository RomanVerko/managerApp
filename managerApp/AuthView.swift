//
//  AuthView.swift
//  cursach2
//
//  Created by Роман Верко on 16.04.2020.
//  Copyright © 2020 Roman Verko. All rights reserved.
//

import SwiftUI


struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    
    func singIn() {
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else{
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        
        VStack{
            Text("Manager application")
                .font(.system(size: 30, weight: .heavy))
            Text("Check your team performance")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor((Color.gray))
                .padding(.vertical,5)
            
            VStack(spacing: 18){
                
                
                TextField("Email adress", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                                                               lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                                                               lineWidth: 1))
            }
            .padding(.vertical, 64)
            
            Button(action: singIn){
                Text("Sign in")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [.green,.blue]), startPoint: .leading , endPoint: .trailing))
                .cornerRadius(5)
                
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size : 14, weight : .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
            
            NavigationLink(destination: SignUpView()){
                HStack {
                    Text("First time?")
                        .font(.system(size: 14, weight: .light))
                        .foregroundColor(.primary)
                    
                    Text("Start team management")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.blue)
                }
            }
        }
        .padding(.horizontal, 32)
    }
}

struct SignUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: SessionStore
    @State var name: String = ""
    
    func signUp(){
        session.signUp(email: email, password: password){ (result, error) in
        
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    var body: some View {
        VStack {
            Text("Create Account")
                .font(.system(size: 32, weight : .heavy))
            
            Text("Sign up to get started")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.gray)
            
            VStack(spacing: 18){
                TextField("Team name", text: $name)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                                                                               lineWidth: 1))
                
                TextField("Email address", text: $email)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                    lineWidth: 1))
                
                SecureField("Password", text: $password)
                    .font(.system(size: 14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color.gray,
                    lineWidth: 1))
            }.padding(.vertical, 64)
            
            Button(action: signUp){
            Text("Create Team")
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 50)
                .foregroundColor(.white)
                .font(.system(size: 14, weight: .bold))
                .background(LinearGradient(gradient: Gradient(colors: [Color.green,Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
        }
        
            if (error != ""){
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.red)
                    .padding()
            }
            
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}

struct AuthView: View {
    var body: some View {
        NavigationView{
            SignInView()
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(SessionStore())
    }
}
