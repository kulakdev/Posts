//
//  TweetCreateNew.swift
//  Posts
//
//  Created by Constantine Kulak on 25.09.2023.
//

import SwiftUI
import PhotosUI
import Resolver

struct TweetCreateNew: View {
    @Environment(\.colorScheme) var colorScheme
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var databaseViewModel: DatabaseViewModel
    @InjectedObject private var storageViewModel: StorageViewModel
    @Binding var selectedPhotos: [PhotosPickerItem]
    @Binding var selectedImages: [Image]
    @State private var emptyTextWarning: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {
                HeaderView(selectedPhotos: $selectedPhotos)
            }
            .padding(.bottom, 10.0)
            HStack(alignment: .top) {
                TEMPProfilePicture()
                VStack(alignment: .leading) {
                    TextField(text: $appStateManager.newTweetText) {
                        if emptyTextWarning == true {
                            Text("Please enter your tweet first")
                                .foregroundColor(.red)
                        } else {
                            Text("Enter your new tweet")
                                .task {
                                    emptyTextWarning = false
                                }
                        }
                    }
                    .padding(.vertical, 10.0)
                    .frame(height: 100, alignment: .topLeading)
                    .onChange(of: appStateManager.newTweetText) { _ in
                        emptyTextWarning = false
                    }
                    if emptyTextWarning == true {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .resizable()
                                .frame(width: 10, height: 10, alignment: .leading)
                            Text("The text cannot be empty")
                                .font(.footnote)
                        }
                        .frame(height: 12)
                        .foregroundColor(.red)
                    }
                    HStack {
                        ForEach(0..<selectedImages.count, id: \.self) { photo in
                            selectedImages[photo]
                                .resizable()
                                .scaledToFit()
                                .frame(width: 64, height: 64)
                                .onTapGesture {
                                    selectedImages.remove(at: photo)
                                }
                        }
                    }
                    HStack {
                        Divider()

                        TweetCreateNewButtonsStack(selectedPhoto: $selectedPhotos)
                        Spacer()
                        // tweet button

                        TweetCreateNewTweetButton(emptyTextWarning: $emptyTextWarning)
                    }
                }
                .padding(.bottom, 5.0)
            }
            .padding(.trailing)
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(15)
        .frame(maxHeight: 500)
        .onChange(of: selectedPhotos) { _ in
            Task {
                selectedImages.removeAll()

                for item in selectedPhotos {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            let image = Image(uiImage: uiImage)
                            selectedImages.append(image)
                        }
                    }
                }
            }
        }
    }
}

struct TweetCreateNew_Previews: PreviewProvider {

    static var previews: some View {
        @State var selectedPhotos = [PhotosPickerItem]()
        @State var selectedImages = [Image]()
        VStack {
            Spacer()
            TweetCreateNew(selectedPhotos: $selectedPhotos, selectedImages: $selectedImages)
            Spacer()
        }
        .padding()
        .background(.black)
    }
}
