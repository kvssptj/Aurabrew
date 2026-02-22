import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Brew", systemImage: "drop.fill") {
                BrewHomeView()
            }
            Tab("Calculator", systemImage: "scalemass.fill") {
                CalculatorView()
            }
            Tab("Journal", systemImage: "book.fill") {
                JournalListView()
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: BrewLog.self, inMemory: true)
}
