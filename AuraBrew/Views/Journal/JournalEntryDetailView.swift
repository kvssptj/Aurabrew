import SwiftUI

struct JournalEntryDetailView: View {
    let log: BrewLog

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Stats card
                HStack(spacing: 0) {
                    statBox(label: "Coffee", value: "\(Int(log.coffeeGrams))g", icon: "scalemass.fill")
                    Divider().frame(height: 50)
                    statBox(label: "Water", value: "\(Int(log.waterMl))ml", icon: "drop.fill")
                    Divider().frame(height: 50)
                    statBox(label: "Ratio", value: log.ratio, icon: "equal.circle.fill")
                }
                .padding()
                .notionCard()

                // Details card
                infoCard(title: "Details") {
                    infoRow(label: "Method", value: log.brewMethod)
                    if !log.coffeeName.isEmpty {
                        infoRow(label: "Coffee Bean", value: log.coffeeName)
                    }
                    if !log.grindSize.isEmpty {
                        infoRow(label: "Grind Size", value: log.grindSize)
                    }
                    infoRow(label: "Date", value: log.date.formatted(date: .long, time: .shortened))
                }

                infoCard(title: "Rating") {
                    StarDisplay(rating: log.rating)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                if !log.notes.isEmpty {
                    infoCard(title: "Notes") {
                        Text(log.notes)
                            .font(.body)
                            .foregroundStyle(.primary)
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .navigationTitle(log.recipeName)
        .navigationBarTitleDisplayMode(.large)
    }

    private func statBox(label: String, value: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon).foregroundStyle(.brown)
            Text(value).font(.headline).monospacedDigit()
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private func infoCard<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.headline)
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .notionCard()
    }

    private func infoRow(label: String, value: String) -> some View {
        HStack {
            Text(label).foregroundStyle(.secondary)
            Spacer()
            Text(value).fontWeight(.medium)
        }
        .font(.subheadline)
    }
}

#Preview {
    NavigationStack {
        JournalEntryDetailView(log: BrewLog(
            recipeName: "Classic V60",
            brewMethod: "V60",
            coffeeGrams: 15,
            waterMl: 250,
            coffeeName: "Ethiopia Yirgacheffe",
            grindSize: "Medium-fine",
            notes: "Bright and fruity with a clean finish.",
            rating: 4
        ))
    }
}
