//
//  TweetCreateNewTweetButton.swift
//  Posts
//
//  Created by Constantine Kulak on 26.09.2023.
//

import SwiftUI
import Resolver

struct TweetCreateNewTweetButton: View {
    @InjectedObject private var appStateManager: AppStateManager
    @InjectedObject private var databaseViewModel: DatabaseViewModel
    @Binding var emptyTextWarning: Bool
    var body: some View {
        Button(
            action: {
                if appStateManager.newTweetText != "" {
                    Task {
                        await databaseViewModel.makeNewPost()
                    }
                } else {
                    emptyTextWarning = true
                }
            }, label: {
                Text("Tweet")
                    .padding(.horizontal)
                    .padding(.vertical, 10.0)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(18)
            }
        )
    }
}

struct TweetCreateNewTweetButton_Previews: PreviewProvider {
    static var previews: some View {
        TweetCreateNewTweetButton(emptyTextWarning: Binding.constant(true))
    }
}
