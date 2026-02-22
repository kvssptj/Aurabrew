import SwiftUI
import SwiftData

struct BrewHomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    TodayCaffeineCard()

                    Text("Choose a Method")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top)

                    ForEach(BrewMethod.allCases, id: \.self) { method in
                        NavigationLink(value: method) {
                            MethodCard(method: method)
                        }
                        .buttonStyle(.plain)
                        .padding(.horizontal)
                    }
                }
                .padding(.bottom)
            }
            .background(Color(.systemBackground))
            .navigationTitle("Brew")
            .navigationDestination(for: BrewMethod.self) { method in
                RecipeListView(method: method)
            }
            .navigationDestination(for: Recipe.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }
}

private struct MethodCard: View {
    let method: BrewMethod

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: method.systemImage)
                .font(.system(size: 32))
                .foregroundStyle(.brown)
                .frame(width: 56, height: 56)
                .background(.brown.opacity(0.12), in: RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 4) {
                Text(method.displayName)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(method.description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.footnote.weight(.semibold))
                .foregroundStyle(.tertiary)
        }
        .padding()
        .notionCard()
    }
}

// MARK: – Today's Caffeine Card

private struct TodayCaffeineCard: View {
    @Query(sort: \BrewLog.date, order: .reverse) private var allLogs: [BrewLog]

    private let dailyLimit: Double = 400.0

    private var todayLogs: [BrewLog] {
        allLogs.filter { Calendar.current.isDateInToday($0.date) }
    }

    private var totalCaffeine: Double {
        todayLogs.reduce(0) { $0 + CaffeineCalculator.caffeine(for: $1) }
    }

    private var totalGrams: Double {
        todayLogs.reduce(0) { $0 + $1.coffeeGrams }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Today's Caffeine")
                        .font(.headline)
                    Spacer()
                    Text("FDA limit: 400mg")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                HStack(alignment: .firstTextBaseline, spacing: 4) {
                    Text("~\(Int(totalCaffeine))mg")
                        .font(.title.bold())
                    Text("of 400mg")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                GeometryReader { geo in
                    let fraction = min(1.0, totalCaffeine / dailyLimit)
                    let isOver = totalCaffeine > dailyLimit
                    ZStack(alignment: .leading) {
                        Capsule()
                            .fill(Color(.systemFill))
                            .frame(height: 8)
                        Capsule()
                            .fill(isOver ? Color.red : Color.brown)
                            .frame(width: geo.size.width * fraction, height: 8)
                    }
                }
                .frame(height: 8)

                Text("\(todayLogs.count) brew\(todayLogs.count == 1 ? "" : "s") · \(Int(totalGrams))g coffee")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .notionCard()
            .padding(.horizontal)
            .padding(.top)
    }
}

#Preview {
    BrewHomeView()
        .modelContainer(for: BrewLog.self, inMemory: true)
}
