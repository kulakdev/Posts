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

class StorageService: ObservableObject {
    let storageRef = Storage.storage().reference()

    func uploadData(data: Data, uid: String) {
        storageRef.child("images").child("\(uid)").putData(data, metadata: nil) { (metadata, _) in
            guard let metadata = metadata else {
                print("STORAGE SERVICE: \(String(describing: metadata))")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            print(size)
            self.storageRef.child("images").child("\(uid)").downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Uh-oh, an error occurred! \(String(describing: error))")
                  return
                }
                print(downloadURL)
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