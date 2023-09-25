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
                Button {

                } label: {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .padding()
                        .padding(.leading, 5.0)
                }
                Spacer()
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
                Divider()
                    .background(.black)
                    .frame(height: 2.0)
            }
            .padding(.bottom, 10.0)
            HStack(alignment: .top) {
                Image(systemName: "figure.fall.circle")
                    .resizable()
                    .frame(width: 48, height: 48)
                    .foregroundColor(Color.teal)
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding([.horizontal, .bottom], 7.0)
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
                    Button {
                    } label: {
                        HStack {
                            Image(systemName: "globe.asia.australia.fill")
                                .resizable()
                                .frame(width: 12.0, height: 12.0)
                            Text("Everyone can reply")
                                .bold()
                                .font(.footnote)
                        }
                    }
                    Divider()
                    HStack {
//                        HStack(spacing: 15) {
                            PhotosPicker(selection: $selectedPhoto,
                                         matching: .images, photoLibrary: .shared()) {
                                Image(systemName: "photo")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .border(.purple)
                            }
                            Button {
                            } label: {
                                HStack {
                                    Text("GIF")
                                        .font(.system(size: 10))
                                        .bold()
                                        .frame(width: 20, height: 20)
                                        .border(.blue)
                                }
                            }
                            Button {

                            } label: {
                                Image(systemName: "align.horizontal.left")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            Button {
                            } label: {
                                Image(systemName: "face.smiling")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                            }
                            Button {

                            } label: {
                                Image(systemName: "calendar.badge.clock")
                            }
//                        }
                        Spacer()
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
                    .padding(.bottom, 5.0)
                }
                .padding(.trailing)
            }
        }
        .background(colorScheme == .dark ? Color.black : Color.white)
        .cornerRadius(15)
//        .overlay(
//            RoundedRectangle(cornerRadius: 15)
//                .inset(by: 1)
//                .stroke(.blue, lineWidth: 2)
//        )
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
        .background(.black)
    }
}
