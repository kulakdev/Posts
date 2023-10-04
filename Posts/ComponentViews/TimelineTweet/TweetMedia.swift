//
//  TweetMedia.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI

struct TweetMedia: View {
    var media: String?
    var body: some View {
        if let unwrappedLink = media {
            AsyncImage(url: URL(string: unwrappedLink)) { phase in
                switch phase {
                case .empty:
                    PlaceholderImageLoading()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

struct TweetMedia_Previews: PreviewProvider {
    static var previews: some View {
        let media = URL(string: "https://google.com")
        TweetMedia(media: "pog")
    }
}
