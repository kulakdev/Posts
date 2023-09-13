//
//  TweetTimeline.swift
//  Posts
//
//  Created by Constantine Kulak on 13.09.2023.
//

import SwiftUI

struct TweetTimeline: View {
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "figure.fall.circle")
                .resizable()
                .frame(width: 42, height: 42)
                .foregroundColor(Color.teal)
                .background(Color.white)
                .clipShape(Circle())
            VStack(alignment: .leading) {
                HStack(spacing: 0) {
                    Text("Beebon Busk")
                        .font(.subheadline)
                        .fontWeight(.bold)
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .padding(3.0)
                    Text("@beeebon_busk • Mar 6")
                        .font(.footnote)
                    Spacer()
                    Image(systemName: "chevron.down")
                }
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat.")
                    .padding(.bottom, 1.0)
                HStack(alignment: .center) {
                    HStack {
                        Image(systemName: "message")
                        Text("12345")
                    }
                    HStack {
                        Image(systemName: "arrow.2.squarepath")
                        Text("12345")
                    }
                    HStack {
                        Image(systemName: "heart")
                        Text("12345")
                    }
                    Spacer()
                    Image(systemName: "square.and.arrow.up")
                }
                .font(.subheadline)
            }
            Spacer()
        }
    }
}

struct TweetTimeline_Previews: PreviewProvider {
    static var previews: some View {
        TweetTimeline()
    }
}
