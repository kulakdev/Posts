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
            VStack {
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
                .aspectRatio(CGSize(width: 3, height: 1), contentMode: .fit)
                .zIndex(1.0)
            }

            VStack(alignment: .leading) {
                HStack(alignment: .bottom) {
                    AsyncImage(
                        url: URL(string: userData.pfpLink),
                        content: { phase in
                            if let image = phase.image {
                                image.resizable()
                                    .scaledToFill()
                            } else if phase.error != nil {
                                Color.red
                            } else {
                                PlaceholderImageLoading(type: .profilePic)
                            }
                        }
                    )
                    .aspectRatio(CGSize(width: 1, height: 1), contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding(.top, 150.0)
                    Spacer()
                }
                HStack {
                    Text("\(userData.username)")
                        .font(.body)
                        .bold()
                    Image(systemName: "checkmark.seal.fill")
                    Spacer()
                }
                Text("\(userData.handle)")
                Text("This is a text for bio. I should probably add it to the database too in the future")
                HStack {
                    Image(systemName: "mappin")
                    Text("Location")
                    Image(systemName: "link")
                    Text("website.com")
                        .foregroundColor(.blue)
                }
            }
            .zIndex(2.0)
        }
    }
}

struct TweetBio_Previews: PreviewProvider {
    static var previews: some View {
        let userDataDict: [String: Any] = [
            "username": "Beebon Busk",
            "handle": "@beebonbusk",
            "verified": true,
            "pfpLink": "https://images.pexels.com/photos/5792641/pexels-photo-5792641.jpeg",
            "bgLink": "https://plus.unsplash.com/premium_photo-1693881702158-092b00136f76"
        ]
        let userData = UserData(from: userDataDict)

        return TweetBio(userData: userData)
    }
}
