//
//  TweetTimeline.swift
//  Posts
//
//  Created by Constantine Kulak on 13.09.2023.
//

import SwiftUI

struct TweetTimeline: View {
    var fetchedPostData: FetchedPostData
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
                url: URL(string: fetchedPostData.pfpLink),
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
                            Text(fetchedPostData.authorName)
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Image(systemName: "checkmark.circle.fill")
                                .resizable()
                                .frame(width: 12, height: 12)
                                .padding(.horizontal, 3.0)

                        }
                        Text("\(fetchedPostData.authorHandle) • \(formattedTime(time: fetchedPostData.datePosted))")
                            .font(.footnote)
                    }
                    .padding(.bottom, 2.0)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                Text("\(fetchedPostData.text)")
                    .padding(.bottom, 1.0
                    )
                // Convert to array to iterate
                ForEach(Array(fetchedPostData.media), id: \.self) { media in
                    if media != "" {
                        TweetMedia(media: media)
                    }
                }
                TimelineInteractionButtons(postData: fetchedPostData)
            }
            Spacer()
        }
        .padding(.vertical)
    }
}

// struct TweetTimeline_Previews: PreviewProvider {
//    static var previews: some View {
//        TweetTimeline(postData: PostData(), fetchedPostData: FetchedPostData())
//    }
// }
