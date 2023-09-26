//
//  StorageService.swift
//  Posts
//
//  Created by Constantine Kulak on 22.09.2023.
//

import Foundation
import Resolver
import Firebase
import FirebaseCore
import FirebaseStorage

/// Service that handles interaction with Firebase Storage
///
class StorageService: ObservableObject {
    /// Reference to Firebase Storage
    let storageRef = Storage.storage().reference()
    /// Function that handles sending user media added to tweet
    /// - Parameters:
    ///   - data: image data obtained from PhotosPicker
    ///   - uid: User UID obtained from LoginViewModel
    ///   - randomImageUID: randomly generated UUID name for an image
    ///   - completion: escaping closure that is used to add the URLs to "media" of each post
    ///

    func uploadData(
        data: Data,
        uid: String,
        randomImageUID: String,
        completion: @escaping (URL?) -> Void) {
            /// Reference to file \(randomImageUID) folder \(uid)
            let userImageRef = storageRef.child("images/\(uid)/\(randomImageUID).jpg")
            userImageRef.putData(data, metadata: nil) { (metadata, _) in
                guard let metadata = metadata else {
                    print("STORAGE SERVICE: \(String(describing: metadata))")
                    return
                }
                // Metadata contains file metadata such as size, content-type.
                // let size = metadata.size
                // print(size)
                self.storageRef.child("images/\(uid)/\(randomImageUID).jpg").downloadURL { (url, error) in
                    guard let downloadURL = url else {
                        print("Uh-oh, an error occurred! \(String(describing: error))")
                        completion(nil)
                        return
                    }
                    completion(downloadURL)
                    return
                }
            }
        }

    func deleteData(url: String, uid: String) {
        storageRef.child("image").child("\(uid)").delete { error in
            if let error = error {
                print("error \(error)")
            } else {
                print("file was deleted successfully")
            }
        }
    }
}
