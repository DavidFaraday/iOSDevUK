//
//  LoginView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/01/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: NavigationRouter

    @State private var email = ""
    @State private var password = ""
    
    let firebaseAuth = FirebaseAuthentication.shared

    @ViewBuilder
    private func loginButton() -> some View {
        Button {
            firebaseAuth.loginUserWith(email: email, password: password) { error in
                if error == nil {
                    router.infoPath.removeLast()
                    router.infoPath.append(InfoDestination.admin)
                }
            }
        }label: {
            Text("Login")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(.top, 10)
    }
    
    @ViewBuilder
    private func loginComponent() -> some View {
        VStack(spacing: 10) {
            Text("Login")
                .font(.title)
                .fontWeight(.semibold)
            
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.accentColor)
                    .frame(width: 30)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Image(systemName: "lock")
                    .foregroundColor(.accentColor)
                    .frame(width: 30)
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
            }
            
            loginButton()
        }
        .padding()
        .background(.ultraThinMaterial)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.accentColor, lineWidth: 2)
        )
        .padding()
    }
    
    var body: some View {
        VStack {
            Spacer()
            loginComponent()
            Spacer()
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
