//
//  TweetDetails.swift
//  Posts
//
//  Created by Constantine Kulak on 13.09.2023.
//

import SwiftUI

struct TweetDetails: View {
    var body: some View {
            VStack {
                HStack {
                    Image(systemName: "figure.fall.circle")
                        .resizable()
                        .frame(width: 42, height: 42)
                        .foregroundColor(Color.teal)
                        .background(Color.white)
                        .clipShape(Circle())
                    VStack(alignment: .leading) {
                        Text("Beebon Busk")
                            .font(.callout)
                        Text("@beebonbusk")
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                            .autocapitalization(.none)
                            .fontWeight(.light)
                    }
                    Spacer()
                    Button(action: {
                        print("text")
                    }, label: {
                        Text("Following")
                            .font(.footnote)
                            .padding(8)
                            .background(Color.teal)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))

                    })
                }
                .background(Color.white)
                // swiftlint:disable:next line_length
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat.")

                Image("samplePhoto")
                    .resizable()
                    .frame(width: 350, height: 175)
                    .scaledToFit()
                    .cornerRadius(10)
                HStack(alignment: .center) {
                    Group {
                        Image(systemName: "arrowshape.turn.up.left.fill")
                        Image(systemName: "arrow.2.squarepath")
                        Image(systemName: "star.fill")
                        Image(systemName: "ellipsis")
                    }
                    .frame(width: 40)
                    .foregroundColor(Color(red: 0.8049693943, green: 0.8049693943, blue: 0.8049693943))
                    .padding(2)
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text("Retweets")
                            .font(.footnote)
                        Text("439")
                    }
                    VStack(alignment: .leading) {
                        Text("Favorites")
                            .font(.footnote)
                        Text("50")
                    }
                    Image(systemName: "person.circle.fill")
                    Image(systemName: "person.circle.fill")
                    Image(systemName: "person.circle.fill")
                    Image(systemName: "person.circle.fill")
                    Image(systemName: "person.circle.fill")
                    Spacer()
                }
                .padding(7)
                HStack {
                    Text("6:32 PM")
                    Text("-")
                    Text("5 Nov 2014")
                    Spacer()
                }
                .padding(.vertical, 5.0)
                .padding(.horizontal, 7.0)
                .font(.caption2)
            }
            .padding()
    }
}

struct TweetDetails_Previews: PreviewProvider {
    static var previews: some View {
        TweetDetails()
    }
}
