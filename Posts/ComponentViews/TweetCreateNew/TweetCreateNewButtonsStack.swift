//
//  TweetCreateNewButtonsStack.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI
import PhotosUI

struct TweetCreateNewButtonsStack: View {
    @Binding var selectedPhoto: [PhotosPickerItem]
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

struct TweetCreateNewButtonsStack_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedPhoto = [PhotosPickerItem]()
        TweetCreateNewButtonsStack(selectedPhoto: $selectedPhoto)
    }
}
