//
//  LoginView.swift
//  iOSDevUK
//
//  Created by David Kababyan on 13/01/2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = LoginViewModel()
    
    @State private var email = ""
    @State private var password = ""

    @ViewBuilder
    private func dismissButton() -> some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Spacer()
                Button { dismiss() }
                label: {
                    Image(systemName: ImageNames.xmark)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                }
                .padding()
            }
        }
    }
    
    @ViewBuilder
    private func loginButton() -> some View {
        Button {
            Task {
               await viewModel.loginUserWith(email: email, password: password)
            }
            
        } label: {
            Text(AppStrings.login)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.borderedProminent)
        .padding(.top, 10)
        .onChange(of: viewModel.loginSuccessful, perform: { newValue in
            if newValue {
                dismiss()
            }
        })
    }
    
    @ViewBuilder
    private func loginComponent() -> some View {
        VStack(spacing: 10) {
            Text(AppStrings.login)
                .font(.title)
                .fontWeight(.semibold)
            
            HStack {
                Image(systemName: ImageNames.envelope)
                    .foregroundColor(.accentColor)
                    .frame(width: 30)
                TextField(AppStrings.email, text: $email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)
            }
            
            HStack {
                Image(systemName: ImageNames.lock)
                    .foregroundColor(.accentColor)
                    .frame(width: 30)
                SecureField(AppStrings.password, text: $password)
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
            dismissButton()
            loginComponent()
            Spacer()
            Spacer()
        }
        .alert(isPresented: $viewModel.showError, content: {
            Alert(title: Text(AppStrings.error), message: Text(viewModel.loginError?.localizedDescription ?? ""), dismissButton: .default(Text(AppStrings.ok)))
        })
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
