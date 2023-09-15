import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseDatabaseSwift
import Resolver

// Define structs for data
struct PublicMetrics: Encodable {
    let likeCount: Int
    let replyCount: Int
    let retweetCount: Int
}

struct PostData: Encodable {
    let authorHandle: String
    let authorName: String
    let authorVerified: Bool
    let datePosted: String
    let media: String?
    let peopleLiked: [String: String]
    let publicMetrics: PublicMetrics
    let text: String
}

struct UserData: Codable {
    let username: String
    let handle: String
    let pfpLink: String
    let bgLink: String
}

extension Encodable {
    var toDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else {
            return nil
        }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}

class DatabaseService: ObservableObject {
    @InjectedObject private var viewModel: LoginViewModel
    @InjectedObject private var appStateManager: AppStateManager
    var dbref: DatabaseReference

    init() {
        dbref = Database.database().reference()
    }

    func makeNewPost() {
        // Create a new post using struct with memberwise initializer
        let newPost = PostData(
            authorHandle: "@beebon_busk",
            authorName: "Beebon Busk",
            authorVerified: true,
            datePosted: DateFormatter().string(from: Date()),
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

        // Convert the struct to a dictionary using your extension
        if let postDataDict = newPost.toDictionary {
            // Save the data to Firebase
            let postsRef = dbref.child("posts")
            let newPostRef = postsRef.childByAutoId()
            newPostRef.setValue(postDataDict) { (error, _) in
                if let error = error {
                    print("Error posting data: \(error.localizedDescription)")
                } else {
                    print("Data posted successfully!")
                }
            }
        }
    }
}
