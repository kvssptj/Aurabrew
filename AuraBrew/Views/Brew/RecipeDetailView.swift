import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    @State private var coffeeGrams: Double
    @State private var showActiveBrew = false

    private var waterMl: Double { coffeeGrams * recipe.defaultRatio }
    private var scaledSteps: [BrewStep] { recipe.scaledSteps(coffeeGrams: coffeeGrams) }

    init(recipe: Recipe) {
        self.recipe = recipe
        _coffeeGrams = State(initialValue: recipe.defaultCoffeeGrams)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Header card
                HStack(spacing: 0) {
                    metricBox(label: "Coffee", value: String(format: "%.0fg", coffeeGrams))
                    Divider().frame(height: 44)
                    metricBox(label: "Water", value: String(format: "%.0fml", waterMl))
                    Divider().frame(height: 44)
                    metricBox(label: "Ratio", value: String(format: "1:%.1f", recipe.defaultRatio))
                    if let temp = recipe.waterTemperatureCelsius {
                        Divider().frame(height: 44)
                        metricBox(label: "Water Temp", value: "\(temp)°C")
                    }
                    Spacer()
                    DifficultyBadge(difficulty: recipe.difficulty)
                        .padding(.trailing)
                }
                .padding(.vertical)
                .notionCard()

                // Ratio adjustment
                VStack(alignment: .leading, spacing: 12) {
                    Text("Adjust Amount")
                        .font(.headline)
                    HStack {
                        Text("Coffee:")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Text(String(format: "%.0fg", coffeeGrams))
                            .fontWeight(.semibold)
                    }
                    Slider(value: $coffeeGrams, in: 8...30, step: 0.5)
                        .tint(.brown)
                }
                .padding()
                .notionCard()

                // Steps preview
                VStack(alignment: .leading, spacing: 12) {
                    Text("Steps")
                        .font(.headline)

                    ForEach(Array(scaledSteps.enumerated()), id: \.element.id) { index, step in
                        StepPreviewRow(index: index + 1, step: step)
                        if index < scaledSteps.count - 1 {
                            Divider()
                        }
                    }
                }
                .padding()
                .notionCard()

                // Start button
                Button {
                    showActiveBrew = true
                } label: {
                    Label("Start Brew", systemImage: "play.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .tint(.brown)
                .controlSize(.large)
            }
            .padding()
        }
        .navigationTitle(recipe.name)
        .navigationBarTitleDisplayMode(.large)
        .background(Color(.systemBackground))
        .fullScreenCover(isPresented: $showActiveBrew) {
            ActiveBrewView(
                viewModel: BrewSessionViewModel(recipe: recipe, coffeeGrams: coffeeGrams)
            )
        }
    }

    private func metricBox(label: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3.bold())
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct StepPreviewRow: View {
    let index: Int
    let step: BrewStep

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Text("\(index)")
                .font(.caption.bold())
                .foregroundStyle(.white)
                .frame(width: 24, height: 24)
                .background(.brown, in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(step.name)
                        .font(.subheadline.bold())
                    Spacer()
                    if let pour = step.pourAmountMl {
                        Text(String(format: "%.0fml", pour))
                            .font(.caption)
                            .foregroundStyle(.brown)
                            .padding(.horizontal, 6)
                            .padding(.vertical, 2)
                            .background(.brown.opacity(0.1), in: Capsule())
                    }
                }
                Text(step.isOpenEnded ? "Tap when ready" : TimeFormatter.format(step.durationSeconds))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: RecipeLibrary.classicV60)
    }
}
