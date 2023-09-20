import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseDatabaseSwift
import Resolver

// Define structs for data
struct PublicMetrics: Codable, Hashable {
    let likeCount: Int
    let replyCount: Int
    let retweetCount: Int

    init(from dictionary: [String: Any]) {
        self.likeCount = dictionary["likeCount"] as? Int ?? 0
        self.replyCount = dictionary["replyCount"] as? Int ?? 0
        self.retweetCount = dictionary["retweetCount"] as? Int ?? 0
     }
}

struct FetchedPostData: Codable, Hashable {
let authorHandle: String
let authorName: String
let authorVerified: Bool
let datePosted: String
let media: String?
let peopleLiked: [String: String]
let publicMetrics: PublicMetrics
let text: String

init(child: DataSnapshot) {
    let childValue = child.value as? [String: Any] ?? [:]
    self.authorHandle = childValue["authorHandle"] as? String ?? ""
    self.authorName = childValue["authorName"] as? String ?? ""
    self.authorVerified = childValue["authorVerified"] as? Bool ?? false
    self.datePosted = childValue["datePosted"] as? String ?? ""
    self.media = childValue["media"] as? String
    self.peopleLiked = childValue["peopleLiked"] as? [String: String] ?? [:]

    if let publicMetricsDict = childValue["publicMetrics"] as? [String: Any] {
        self.publicMetrics = PublicMetrics(from: publicMetricsDict)
    } else {
        self.publicMetrics = PublicMetrics(from: [
            "likeCount": 0,
            "replyCount": 0,
            "retweetCount": 0
            ]
        )
    }

    self.text = childValue["text"] as? String ?? ""
}
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
    let verified: Bool
    let pfpLink: String
    let bgLink: String

    init(from dictionary: [String: Any]) {
            self.username = dictionary["username"] as? String ?? ""
            self.handle = dictionary["handle"] as? String ?? ""
            self.verified = dictionary["verified"] as? Bool ?? false
            self.pfpLink = dictionary["pfpLink"] as? String ?? ""
            self.bgLink = dictionary["bgLink"] as? String ?? ""
    }
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

    func observePosts(completion: @escaping (DataSnapshot) -> Void) {
        dbref.child("posts").observe(.childAdded, with: { (dataSnapshot) -> Void in
            completion(dataSnapshot)
            }
        )
//        dbref.child("posts").observeSingleEvent(of: .childAdded, with: { (dataSnapshot) -> Void in
//            completion(dataSnapshot)
//            }
//        )

//        var post = dbref.child("posts").child("-NeNDvgTJPvuvXCnb_8y")
//        print("----\(post)")
    }

    func checkForUser(uid: String) async throws -> UserData? {
        let snapshot = try await self.dbref.child("profiles").child(uid).getData()

        if snapshot.value != nil {
            print("snapshot exists")
            if let value = snapshot.value as? [String: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value)
                    let userData = try JSONDecoder().decode(UserData.self, from: jsonData)
                    return userData
                } catch {
                    throw error
                }
            }
        }

        return nil
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
