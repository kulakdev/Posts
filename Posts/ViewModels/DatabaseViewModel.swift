//
//  DatabaseViewModel.swift
//  Posts
//
//  Created by Constantine Kulak on 15.09.2023.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseSharedSwift
import Resolver

class DatabaseViewModel: ObservableObject {
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var databaseService: DatabaseService
    @InjectedObject private var loginViewModel: LoginViewModel

    lazy var newPost = PostData(
        authorHandle: "\(appStateManager.userData?.handle ?? "Handle not initialized")",
        authorName: "\(appStateManager.userData?.username ?? "Username not initialized")",
        authorVerified: appStateManager.userData?.verified ?? false,
        datePosted: "\(appStateManager.formattedCurrentDate)",
        // swiftlint:disable:next line_length
        media: "",
        peopleLiked: [:
                     ],
        publicMetrics: PublicMetrics(from: [
            "likeCount": 0,
            "replyCount": 0,
            "retweetCount": 0
            ]
        ),
        text: "\(appStateManager.newTweetText)"
    )
    @Published var posts: [FetchedPostData] = []
    var reversedPosts: [FetchedPostData] {
            return posts.reversed()
        }
    func observePosts() {
        databaseService.observePosts { [weak self] dataSnapshot in
                if let snapshot = dataSnapshot as DataSnapshot? {
                    self?.posts.append(contentsOf: [FetchedPostData(child: snapshot)])
                } else {
                    print("Child is not of the expected format")
                }
        }
    }

    func makeNewPost() async {
        do {
            try await databaseService.makeNewPost(newPost: newPost)
            appStateManager.newTweetText = ""
        } catch {
            loginViewModel.self.hasError = true
            loginViewModel.self.errorMessage = error.localizedDescription
        }
    }

    func checkForUser() async {
        let uid = loginViewModel.authService.currentUser.uid
        print(uid)
        do {
            print("this executes")
            appStateManager.userData = try await databaseService.checkForUser(uid: uid)
            return
        } catch {
            print(error)
        }
    }
}
