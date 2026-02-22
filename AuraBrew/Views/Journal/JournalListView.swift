import SwiftUI
import SwiftData

struct JournalListView: View {
    @Query(sort: \BrewLog.date, order: .reverse) private var logs: [BrewLog]
    @Environment(\.modelContext) private var modelContext

    @State private var showLogSheet = false

    var body: some View {
        NavigationStack {
            Group {
                if logs.isEmpty {
                    emptyState
                } else {
                    List {
                        ForEach(logs) { log in
                            NavigationLink(value: log) {
                                JournalRow(log: log)
                            }
                        }
                        .onDelete(perform: deleteLogs)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .background(Color(.systemBackground))
            .navigationTitle("Journal")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showLogSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                if !logs.isEmpty {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
            }
            .navigationDestination(for: BrewLog.self) { log in
                JournalEntryDetailView(log: log)
            }
            .sheet(isPresented: $showLogSheet) {
                LogBrewView(coffeeGrams: 15, waterMl: 250)
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 56))
                .foregroundStyle(.brown.opacity(0.5))
            Text("No Brews Logged")
                .font(.title3.bold())
            Text("After a brew, tap \"Log This Brew\"\nor use the + button to add an entry.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
    }

    private func deleteLogs(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(logs[index])
        }
    }
}

private struct JournalRow: View {
    let log: BrewLog

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(log.recipeName)
                    .font(.headline)
                Spacer()
                StarDisplay(rating: log.rating)
            }
            HStack(spacing: 12) {
                Label(log.brewMethod, systemImage: "cup.and.heat.waves")
                if !log.coffeeName.isEmpty {
                    Label(log.coffeeName, systemImage: "leaf")
                }
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            HStack(spacing: 12) {
                Text(log.date.formatted(date: .abbreviated, time: .shortened))
                Text("·")
                Text("\(Int(log.coffeeGrams))g / \(Int(log.waterMl))ml")
                Text("·")
                Text(log.ratio)
            }
            .font(.caption2)
            .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }
}

struct StarDisplay: View {
    let rating: Int

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundStyle(star <= rating ? .yellow : .secondary.opacity(0.3))
                    .font(.caption)
            }
        }
    }
}

#Preview {
    JournalListView()
        .modelContainer(for: BrewLog.self, inMemory: true)
}
