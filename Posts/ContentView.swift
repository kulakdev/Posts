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
    @InjectedObject private var databaseViewModel: DatabaseViewModel
    var body: some View {
        switch appStateManager.isLoggedIn {
        case .loggedIn:
            ScrollView {
                VStack {
//                    TweetDetails()
                    if appStateManager.userData != nil {
                        let userdata = appStateManager.userData!
                        
                        Text("\(userdata.username)")
                        Text("\(userdata.handle)")
                        Text("\(userdata.bgLink)")
                    } else if appStateManager.userData == nil {
                        Text("User data is nil")
                    }
//                    TweetTimeline()
                    TextField("Enter your new tweet", text: $appStateManager.newTweetText)
                    Button(
                        action: {
                            Task {
                                await databaseViewModel.makeNewPost()
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
                                await databaseViewModel.checkDBForUser()
                            }
                    }, label: {
                        Text("check the database")
                            .foregroundColor(Color.white)
                            .background(Color.red)
                            .padding()
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
                    Task {
                        await databaseViewModel.checkDBForUser()
                    }
                }
            }
        case .didNotProvideDetails:
            Text("damn daniel")
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
