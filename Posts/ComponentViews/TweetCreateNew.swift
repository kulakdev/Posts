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
    @Binding var selectedPhoto: PhotosPickerItem?
    @State private var emptyTextWarning: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            HStack {
                CrossButton()
                Spacer()
                DEBUGSendToStorage(storageViewModel: storageViewModel, selectedPhoto: $selectedPhoto)
                Divider()
                    .background(.black)
                    .frame(height: 2.0)
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
                        Divider()

                        TweetCreateNewButtons(selectedPhoto: $selectedPhoto)
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
    }
}

struct TweetCreateNewTweetButton: View {
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var databaseViewModel: DatabaseViewModel
    @Binding var emptyTextWarning: Bool
    var body: some View {
        Button(
            action: {
                if appStateManager.newTweetText != "" {
                    Task {
                        await databaseViewModel.makeNewPost()
                    }
                } else {
                    emptyTextWarning = true
                }
            }, label: {
                Text("Tweet")
                    .padding(.horizontal)
                    .padding(.vertical, 10.0)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(18)
            }
        )
    }
}
struct TEMPProfilePicture: View {
    var body: some View {
        Image(systemName: "figure.fall.circle")
            .resizable()
            .frame(width: 48, height: 48)
            .foregroundColor(Color.teal)
            .background(Color.white)
            .clipShape(Circle())
            .padding([.horizontal, .bottom], 7.0)
    }
}
struct CrossButton: View {
    var body: some View {
        Button {

        } label: {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 16, height: 16)
                .padding()
                .padding(.leading, 5.0)
        }
    }
}

struct TweetCreateNewButtons: View {
    @Binding var selectedPhoto: PhotosPickerItem?
    var body: some View {
        HStack(spacing: 10) {
            PhotosPicker(selection: $selectedPhoto,
                         matching: .images, photoLibrary: .shared()) {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Button {
                print("GIF button clicked")
            } label: {
                HStack {
                    Text("GIF")
                        .font(.system(size: 10))
                        .bold()
                        .frame(width: 24, height: 24)
                        .border(.blue)
                }
            }
            Button {
                print("Weird ident button clicked")
            } label: {
                Image(systemName: "align.horizontal.left")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Button {
                print("Smiley button clicked")
            } label: {
                Image(systemName: "face.smiling")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            Button {
                print("Calendar button clicked")
            } label: {
                Image(systemName: "calendar.badge.clock")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }

    }
}

struct DEBUGSendToStorage: View {
    @ObservedObject var storageViewModel: StorageViewModel
    @Binding var selectedPhoto: PhotosPickerItem?
    var body: some View {
        Button {
            if selectedPhoto != nil {
                storageViewModel.uploadData(photo: selectedPhoto!)
            }
            print("Le button was clicked")

        } label: {
            Text("Upload photo to the Storage")
                .padding()
                .border(.purple)
        }
    }
}

struct TweetCreateNew_Previews: PreviewProvider {

    static var previews: some View {
        @State var selectedPhoto: PhotosPickerItem?
        VStack {
            Spacer()
            TweetCreateNew(selectedPhoto: $selectedPhoto)
            Spacer()
        }
        .padding()
        .background(.black)
    }
}
