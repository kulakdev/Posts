import Foundation

class AppStateManager: ObservableObject {
    @Published var isLoggedIn: Page = .notLoggedIn
    @Published var newTweetText: String = ""
    @Published var newTweetMedia: String = ""
    @Published var newTweetDate: String = ""

    enum Page {
        case loggedIn
        case notLoggedIn
    }

}
