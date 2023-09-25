//
//  LoginPageView.swift
//  Posts
//
//  Created by Constantine Kulak on 25.09.2023.
//

import SwiftUI
import Resolver

struct LoginPageView: View {
    @InjectedObject private var viewModel: LoginViewModel
    var body: some View {
        ScrollView {
            TextField("enter your email", text: $viewModel.email)
                .padding()
            SecureField("enter your email", text: $viewModel.password)
                .padding()
            Button(
                action: {
                    Task {
                        await viewModel.signIn()
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
