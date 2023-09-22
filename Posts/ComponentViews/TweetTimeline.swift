//
//  TweetTimeline.swift
//  Posts
//
//  Created by Constantine Kulak on 13.09.2023.
//

import SwiftUI

struct TweetTimeline: View {
    let postData: FetchedPostData
    func formattedTime(time: String) -> String {
        print(time)
        let formatter = ISO8601DateFormatter()
        let convertedTime = formatter.date(from: time)
        let difference = convertedTime?.timeIntervalSinceNow
        let absSeconds = abs(difference ?? -503667.3709640503)

            if absSeconds < 60 {
                return "\(Int(absSeconds)) seconds ago"
            } else if absSeconds < 3600 {
                let minutes = Int(absSeconds / 60)
                return "\(minutes) minute\(minutes == 1 ? "" : "s") ago"
            } else if absSeconds < 86400 {
                let hours = Int(absSeconds / 3600)
                return "\(hours) hour\(hours == 1 ? "" : "s") ago"
            } else if absSeconds < 604800 {
                let days = Int(absSeconds / 86400)
                return "\(days) day\(days == 1 ? "" : "s") ago"
            } else if absSeconds < 2419200 {
                let weeks = Int(absSeconds / 604800)
                return "\(weeks) week\(weeks == 1 ? "" : "s") ago"
            } else if absSeconds < 29030400 {
                let months = Int(absSeconds / 2419200)
                return "\(months) month\(months == 1 ? "" : "s") ago"
            } else {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM.dd.yyyy"
                let dateString = formatter.string(from: Date())
                return dateString
            }

    }
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(
                url: URL(string: postData.pfpLink),
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
            .frame(width: 42, height: 42)
            .clipShape(Circle())
            VStack(alignment: .leading) {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(spacing: 0) {
                            Text(postData.authorName)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .padding(.horizontal, 3.0)

                        }
                        Text("\(postData.authorHandle) • \(formattedTime(time: postData.datePosted))")
                            .font(.footnote)
                    }
                    .padding(.bottom, 2.0)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                Text("\(postData.text)")
                    .padding(.bottom, 1.0)
                if postData.media?.isEmpty == false {
                    AsyncImage(url: URL(string: postData.media ?? ""),
                               content: { phase in
                        if let image = phase.image {
                            image.resizable()
                                .scaledToFill()
                        } else if phase.error != nil {
                            Color.red
                        } else {
                            PlaceholderImageLoading()
                        }
                    })
                        .frame(width: 300, height: 150)
                        .cornerRadius(10)
                }
                HStack(alignment: .center) {
                    HStack {
                        Image(systemName: "message")
                        Text("\(postData.publicMetrics.replyCount)")
                    }
                    Spacer()
                    HStack {
                        Image(systemName: "arrow.2.squarepath")
                        Text("\(postData.publicMetrics.retweetCount)")
                    }
                    Spacer()
                    HStack {
                        Button {
                            print("like")
                        } label: {
                            Image(systemName: "heart")
                            Text("\(postData.publicMetrics.likeCount)")
                        }
                    }
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                }
                .font(.subheadline)
            }
            Spacer()
        }
        .padding(.vertical)
    }
}

 struct TweetTimeline_Previews: PreviewProvider {
    static var previews: some View {
        TweetTimeline(postData: FetchedPostData())
    }
 }
