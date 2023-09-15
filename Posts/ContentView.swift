//
//  ContentView.swift
//  Posts
//
//  Created by Constantine Kulak on 13.09.2023.
//

import SwiftUI
import Resolver

struct ContentView: View {
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var viewModel: LoginViewModel
    @InjectedObject private var dbService: DatabaseService
    var body: some View {
        switch appStateManager.isLoggedIn {
        case .loggedIn:
            ScrollView {
                VStack {
                    TweetDetails()
                    TweetTimeline()
                    TextField("Enter your new tweet", text: $appStateManager.newTweetText)
                    Button(
                        action: {
                            Task {
                                dbService.makeNewPost()
                            }
                    }, label: {
                        Text("Make a new post on the cloud")
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                        }
                    )
                    Button(
                        action: {
                            Task {
                                await viewModel.signOut()
                            }
                    }, label: {
                        Text("Sign Out")
                            .foregroundColor(Color.white)
                            .background(Color.blue)
                            .padding()
                        }
                    )
                }
                .padding()
                .onAppear {
                    UIApplication.shared.isIdleTimerDisabled = true
                }
            }
        case .notLoggedIn:
            ScrollView {
                TextField("enter your email", text: $viewModel.email)
                SecureField("enter your email", text: $viewModel.password)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
