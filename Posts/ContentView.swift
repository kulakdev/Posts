//
//  ContentView.swift
//  Posts
//
//  Created by Constantine Kulak on 13.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
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
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque interdum rutrum sodales. Nullam mattis fermentum libero, non volutpat.")
                    .padding(5)
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
                .padding(2)
                HStack {
                    Text("6:32 PM")
                    Text("-")
                    Text("5 Nov 2014")
                    Spacer()
                }
                .padding(.vertical, 5.0)
                .font(.caption2)
//                Spacer()
            }
                .frame(width: 350)
            
            Rectangle()
                .frame(width: 2000.0, height: 3.0)
            
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
            .frame(width: 350)
        }
        .padding()
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
