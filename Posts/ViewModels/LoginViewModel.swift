import Foundation
import FirebaseAuth
import Resolver

class LoginViewModel: ObservableObject {
    @InjectedObject var authService: AuthService
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var hasError = false
    @Published var errorMessage = ""

    func throwError(error: Error) {
        DispatchQueue.main.async {
            self.hasError = true
            self.errorMessage = error.localizedDescription
        }
    }

    func signIn() async {
        do {
            try await authService.signIn(email: email, password: password)
        } catch {
            DispatchQueue.main.async {
                self.hasError = true
                self.errorMessage = error.localizedDescription
            }
        }

    }

    func signUp() async {
        do {
            try await authService.signUp(email: name, password: password)
        } catch {
            DispatchQueue.main.async {
                self.hasError = true
                self.errorMessage = error.localizedDescription
            }
        }
    }

    func signOut() async {
        do {
            try await authService.signOut()
        } catch {
            throwError(error: error)
        }
    }
}
