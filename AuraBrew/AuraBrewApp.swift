import SwiftUI
import SwiftData

@main
struct AuraBrewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: BrewLog.self)
    }
}
