import Foundation

class AppStateManager: ObservableObject {
    @Published var isLoggedIn: Page = .notLoggedIn

    enum Page {
        case loggedIn
        case notLoggedIn
    }

}
