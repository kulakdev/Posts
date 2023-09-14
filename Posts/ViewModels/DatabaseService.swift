import Foundation
import FirebaseCore
import FirebaseDatabase
import FirebaseDatabaseSwift

class DatabaseService: ObservableObject {
    var dbref: DatabaseReference

    init() {
        dbref = Database.database().reference()
    }
}
