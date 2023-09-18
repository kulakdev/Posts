//
//  DatabaseViewModel.swift
//  Posts
//
//  Created by Constantine Kulak on 15.09.2023.
//

import Foundation
import Firebase
import Resolver

class DatabaseViewModel: ObservableObject {
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var databaseService: DatabaseService
    @InjectedObject private var loginViewModel: LoginViewModel

    lazy var newPost = PostData(
        authorHandle: "@beebon_busk",
        authorName: "Beebon Busk",
        authorVerified: true,
        datePosted: "\(appStateManager.formattedCurrentDate)",
        // swiftlint:disable:next line_length
        media: "https://plus.unsplash.com/premium_photo-1693881702158-092b00136f76?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
        peopleLiked: [:
                     ],
        publicMetrics: PublicMetrics(
            likeCount: 0,
            replyCount: 0,
            retweetCount: 0
        ),
        text: "\(appStateManager.newTweetText)"
    )

    func makeNewPost() async {
        do {
            try await databaseService.makeNewPost(newPost: newPost)
            appStateManager.newTweetText = ""
        } catch {
            loginViewModel.self.hasError = true
            loginViewModel.self.errorMessage = error.localizedDescription
        }
    }

    func checkDBForUser() async {
        let uid = loginViewModel.authService.currentUser.uid
        print(uid)
        do {
            print("this executes")
            appStateManager.userData = try await databaseService.checkDBForUser(uid: uid)
            return
        } catch {
            print(error)
        }
    }
}
