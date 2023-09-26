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
    @State private var selectedPhoto = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    var transferrablePhoto: Data?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                if appStateManager.userData != nil {
                    let userdata = appStateManager.userData!
                    TweetBio(userData: userdata)
                        .padding(.bottom, 10.0)
                } else if appStateManager.userData == nil {
                    Text("User data is nil")
                }
                VStack {
                    Spacer()
                        .frame(height: 10)
                    TweetCreateNew(selectedPhoto: $selectedPhoto, selectedImages: $selectedImages)
                    Spacer()
                        .frame(height: 10)
                }
                .background(.gray.opacity(0.4))
                ForEach(databaseViewModel.reversedPosts, id: \.self) { post in
                    TweetTimeline(postData: post)
                        .transition(.opacity)
                }

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
