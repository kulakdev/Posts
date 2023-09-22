import Foundation

class AppStateManager: ObservableObject {
    @Published var isLoggedIn: Page = .notLoggedIn
    @Published var newTweetText: String = ""
    @Published var newTweetMedia: String = ""
    @Published var userData: UserData?

    var formattedCurrentDate: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ" // Customize the date format as needed
            return dateFormatter.string(from: Date())
        }

    enum Page {
        case loggedIn
        case didNotProvideDetails
        case notLoggedIn
    }

}
