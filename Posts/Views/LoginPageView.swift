//
//  LoginPageView.swift
//  Posts
//
//  Created by Constantine Kulak on 25.09.2023.
//

import SwiftUI
import Resolver

struct LoginPageView: View {
    @InjectedObject private var loginViewModel: LoginViewModel
    var body: some View {
        ScrollView {
            TextField("enter your email", text: $loginViewModel.email)
                .padding()
            SecureField("enter your email", text: $loginViewModel.password)
                .padding()
            Button(
                action: {
                    Task {
                        await loginViewModel.signIn()
                    }
            }, label: {
                Text("Sign In")
                    .foregroundColor(Color.white)
                    .background(Color.blue)
            }
            )
        }
        .padding()
    }
}

struct LoginPageView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPageView()
    }
}
