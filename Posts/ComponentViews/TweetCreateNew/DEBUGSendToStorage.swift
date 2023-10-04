//
//  DEBUGSendToStorage.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI
import PhotosUI

struct DEBUGSendToStorage: View {
    @ObservedObject var storageViewModel: StorageViewModel
    @ObservedObject var databaseViewModel: DatabaseViewModel
    @Binding var selectedPhoto: [PhotosPickerItem]
    var body: some View {
        Button {
            if selectedPhoto != [nil] {
                storageViewModel.uploadData(photoArray: selectedPhoto) { mediaURL in
                    if mediaURL?.absoluteString == "" {
                    print("Media URL is broken")
                    }
                    if let mediaURL = mediaURL?.absoluteString {
                        let newIndex = databaseViewModel.newPost.media.count
                        databaseViewModel.newPost.media[newIndex] = mediaURL
                    }
                }
            }
            print("Le button was clicked")

        } label: {
            Text("Upload photo to the Storage")
                .padding()
                .border(.purple)
        }
    }
}

struct DEBUGSendToStorage_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedPhoto = [PhotosPickerItem]()
        DEBUGSendToStorage(
            storageViewModel: StorageViewModel(),
            databaseViewModel: DatabaseViewModel(),
            selectedPhoto: $selectedPhoto)
    }
}
