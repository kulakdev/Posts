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
    func uploadData(photo: PhotosPickerItem) {
        let uid = loginViewModel.authService.currentUser.uid

        photo.loadTransferable(type: Data.self) { [self] result in
            print("goes here \(result)")
            switch result {
            case .success(let data):
                if data != nil {
                    self.storageService.uploadData(data: data!, uid: uid)
                    print("Successfully loaded transferrable")
                } else {
                    print("data was null")
                }
            case .failure:
                print("Failed to load transferrable")
            }
        }
    }

}
