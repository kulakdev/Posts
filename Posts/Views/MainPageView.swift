//
//  MainPageView.swift
//  Posts
//
//  Created by Constantine Kulak on 25.09.2023.
//

import SwiftUI
import PhotosUI
import Resolver

struct MainPageView: View {
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var databaseViewModel: DatabaseViewModel
    @State private var selectedPhoto: PhotosPickerItem?
    var transferrablePhoto: Data?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if appStateManager.userData != nil {
                    let userdata = appStateManager.userData!
                    Text("Profile screen")
                        .padding(5.0)
                        .font(.caption)
                        .background(.red)
                        .foregroundColor(.white)
                    TweetBio(userData: userdata).padding(.bottom, 10.0)
                } else if appStateManager.userData == nil {
                    Text("User data is nil")
                }
                TweetCreateNew(selectedPhoto: $selectedPhoto)
                Text("Timeline")
                    .padding(5.0)
                    .font(.caption)
                    .background(.red)
                    .foregroundColor(.white)
                
                VStack {
                    ForEach(databaseViewModel.reversedPosts, id: \.self) { post in
                        TweetTimeline(postData: post)
                            .transition(.opacity)
                    }
                }.border(.red)
                
            }
            .padding()
            .task {
                await databaseViewModel.checkForUser()
                databaseViewModel.observePosts()
            }
            .onAppear {
#if DEBUG
                UIApplication.shared.isIdleTimerDisabled = true
#endif
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

struct MainPageView_Previews: PreviewProvider {
    static var previews: some View {
        MainPageView()
    }
}
