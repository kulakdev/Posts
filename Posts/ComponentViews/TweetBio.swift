//
//  TweetBio.swift
//  Posts
//
//  Created by Constantine Kulak on 18.09.2023.
//

import SwiftUI

struct TweetBio: View {
    let userData: UserData
    var body: some View {
        ZStack {
            AsyncImage(
                url: URL(string: userData.bgLink),
                content: { phase in
                    if let image = phase.image {
                        image.resizable()
                    } else if phase.error != nil {
                        Color.red
                    } else {
                        PlaceholderImageLoading()
                    }
                }
            )
            .aspectRatio(CGSize(width: 3, height: 1), contentMode: .fill)
//            VStack {
//                HStack {
//                    Circle()
//                        .frame(width: 168, height: 168)
//
////                    Spacer()
////                    Button("subscribed") {print("click!")}
//                }
////                .frame(maxWidth: UIScreen.main.bounds.width)
//                .frame(maxWidth: 350)
//            }
        }
    }
}
