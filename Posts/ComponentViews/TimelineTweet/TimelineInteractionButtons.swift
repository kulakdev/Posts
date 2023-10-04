//
//  TimelineInteractionButtons.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI
import Resolver

struct TimelineInteractionButtons: View {
    let postData: FetchedPostData
    var body: some View {
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
}
