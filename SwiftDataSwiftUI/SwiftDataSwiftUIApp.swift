//

import SwiftUI
import SwiftData

@main
struct SwiftDataSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Book.self])
        }
    }
}
