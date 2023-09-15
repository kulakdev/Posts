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
    @InjectedObject private var authService: AuthService
    var dbref: DatabaseReference

    init() {
        dbref = Database.database().reference()
    }

    func checkDBForUser(uid: String) {
        self.dbref.child("profiles").child(authService.currentUser.uid).getData { error, _ in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("profile found")
        }
    }

    func makeNewPost(newPost: PostData) async throws {
        // Convert the struct to a dictionary using your extension
        if let postDataDict = newPost.toDictionary {
            // Save the data to Firebase
            let postsRef = dbref.child("posts")
            let newPostRef = postsRef.childByAutoId()
            try await newPostRef.setValue(postDataDict)
        }
    }
}
