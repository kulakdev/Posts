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
        media: "https://plus.unsplash.com/premium_photo-1693881702158-092b00136f76?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1287&q=80",
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

    func observePosts() {
        databaseService.observePosts { [weak self] dataSnapshot in
//            for child in dataSnapshot.children {
                if let snapshot = dataSnapshot as? DataSnapshot {
//                    let dict = snapshot.value as? [String: Any] ?? [:]
//                    print("\( dict )")
                    self?.posts.append(contentsOf: [FetchedPostData(child: snapshot)])
                    print(self?.posts)
                } else {
                    print("Child is not of the expected format")
                }
//            }
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
// init(from dictionary: [String: Any]) {
//    self.likeCount = dictionary["likeCount"] as? Int ?? 0
//    self.replyCount = dictionary["replyCount"] as? Int ?? 0
//    self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
//    }
// }
//
// struct FetchedPostData: Codable {
// let authorHandle: String
// let authorName: String
// let authorVerified: Bool
// let datePosted: String
// let media: String?
// let peopleLiked: [String: String]
// let publicMetrics: PublicMetrics
// let text: String
//
// init(child: DataSnapshot) {
//    let childValue = child.value as? [String: Any] ?? [:]
//    self.authorHandle = childValue["authorHandle"] as? String ?? ""
//    self.authorName = childValue["authorName"] as? String ?? ""
//    self.authorVerified = childValue["authorVerified"] as? Bool ?? false
//    self.datePosted = childValue["datePosted"] as? String ?? ""
//    self.media = childValue["media"] as? String
//    self.peopleLiked = childValue["peopleLiked"] as? [String: String] ?? [:]
//
//    if let publicMetricsDict = childValue["publicMetrics"] as? [String: Any] {
//        self.publicMetrics = PublicMetrics(from: publicMetricsDict)
//    } else {
//        self.publicMetrics = PublicMetrics(from:
//                                            [
//            "likeCount": 0,
//            "replyCount": 0,
//            "retweetCount": 0
//            ]
//        )
//    }
//
//    self.text = childValue["text"] as? String ?? ""
// }
// }
//
// struct PostData: Codable, Hashable {
// let authorHandle: String
// let authorName: String
// let authorVerified: Bool
// let datePosted: String
// let media: String?
// let peopleLiked: [String: String]
// let publicMetrics: PublicMetrics
// let text: String
//
//// A custom initializer to create FetchedPostData from PostData
// init(postData: PostData) {
//    self.authorHandle = postData.authorHandle
//    self.authorName = postData.authorName
//    self.authorVerified = postData.authorVerified
//    self.datePosted = postData.datePosted
//    self.media = postData.media
//    self.peopleLiked = postData.peopleLiked
//    self.publicMetrics = postData.publicMetrics
//    self.text = postData.text
// }
//
//// Implement the hash(into:) method required by Hashable
// func hash(into hasher: inout Hasher) {
//    hasher.combine(authorHandle)
//    hasher.combine(authorName)
//    hasher.combine(authorVerified)
//    hasher.combine(datePosted)
//    hasher.combine(media)
//    hasher.combine(peopleLiked)
//    hasher.combine(publicMetrics)
//    hasher.combine(text)
// }
// }
