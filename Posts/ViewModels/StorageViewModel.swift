//
//  StorageViewModel.swift
//  Posts
//
//  Created by Constantine Kulak on 22.09.2023.
//

import Foundation
import Resolver
import SwiftUI
import PhotosUI

class StorageViewModel: ObservableObject {
    @InjectedObject private var loginViewModel: LoginViewModel
    @InjectedObject private var storageService: StorageService
    /// Function that receives array of user picked images and uploads them to Storage
    ///
    /// - Parameters:
    ///   - photoArray: array of user selected images
    ///   - completion: URL to successfully uploaded image
    func uploadData(photoArray: [PhotosPickerItem?], completion: @escaping (URL?) -> Void) {
        // This function handles response from uploadData() in Storage Service
        // It takes uid of a currently logged in user, then makes use of
        // DispatchGroup to assign a unique UUID as a name and post image to DB
        let uid = loginViewModel.authService.currentUser.uid
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "upload-data")

        dispatchQueue.async {
            // Loop over the photoArray
            for photo in photoArray {
                // Dispatch Group is used to make sure that each task is done concurrently
                dispatchGroup.enter()
                // Assign random UUID to each image to store it there
                // [TODO?]: asign name based on contents of the image & avoid dupes in db?
                let randomImageUID = UUID().uuidString
                // Decode PhotosPickerItem into Data
                photo?.loadTransferable(type: Data.self) { [self] result in
                    switch result {
                    case .success(let data):
                        /// Early return if data is null
                        if data == nil {
                            print("data was null")
                            dispatchGroup.leave()
                            return
                        }
                        self.storageService.uploadData(
                            data: data!,
                            uid: uid,
                            randomImageUID: randomImageUID) { downloadURL in

                            if let url = downloadURL {
                                print("Download URL : \(url)")
                                dispatchGroup.leave()
                                return
                            }
                            print("Error uploading or getting download URL")
                            dispatchGroup.leave()
                        }
                        print("Successfully loaded transferrable")

                    case .failure:
                        print("Failed to load transferrable")
                        dispatchGroup.leave()
                    }
                }
            }
        }
        dispatchGroup.notify(queue: dispatchQueue) {

            DispatchQueue.main.async {

                print("finished all requests")
            }
        }
    }

}
