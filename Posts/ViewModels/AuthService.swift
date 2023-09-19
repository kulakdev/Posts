import Foundation
import FirebaseAuth
import Resolver

class AuthService: ObservableObject {
    @InjectedObject var appStateManager: AppStateManager
    private var _currentUser: User?
    var hasError = true
    var handler = Auth.auth().addStateDidChangeListener {_, _ in }

    var currentUser: User {
        return _currentUser ?? User(uid: "", email: "", photoURL: nil)
    }

    init() {
        handler = Auth.auth().addStateDidChangeListener { _, user in
            if let user = user {
                self._currentUser = User(uid: user.uid, email: user.email!, photoURL: user.photoURL)
                self.appStateManager.isLoggedIn = .loggedIn
            } else {
                self._currentUser = nil
                self.appStateManager.isLoggedIn = .notLoggedIn
            }
        }
    }

    func signIn(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }

    func signOut() async throws {
        try Auth.auth().signOut()
    }

    func signUp(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }

    deinit {
        Auth.auth().removeStateDidChangeListener(handler)
    }
}
