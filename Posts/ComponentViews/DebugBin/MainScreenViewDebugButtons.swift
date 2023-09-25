//
//  MainScreenViewDebugButtons.swift
//  Posts
//
//  Created by Constantine Kulak on 25.09.2023.
//

import SwiftUI
import Resolver

struct MainScreenViewDebugButtons: View {
    @InjectedObject private var databaseViewModel: DatabaseViewModel
    @InjectedObject private var loginViewModel: LoginViewModel
    var body: some View {
        VStack {
            // This should be removed asap, but i'll keep it for debugging
            Button(
                action: {
                    Task {
                        await databaseViewModel.checkForUser()
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
                        await loginViewModel.signOut()
                    }
                }, label: {
                    Text("Sign Out")
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .padding()
                }
            )
        }
    }
}

struct MainScreenViewDebugButtons_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenViewDebugButtons()
    }
}
