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
    var body: some View {
        switch appStateManager.isLoggedIn {
        case .loggedIn:
            MainPageView()
        case .didNotProvideDetails:
            ProvideDetailsView()
        case .notLoggedIn:
            LoginPageView()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
