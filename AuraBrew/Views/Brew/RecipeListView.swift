import SwiftUI

struct RecipeListView: View {
    let method: BrewMethod
    private var recipes: [Recipe] { RecipeLibrary.recipes(for: method) }

    var body: some View {
        List(recipes) { recipe in
            NavigationLink(value: recipe) {
                RecipeRow(recipe: recipe)
            }
            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color(.systemBackground))
        .navigationTitle(method.displayName)
    }
}

private struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(recipe.name)
                    .font(.headline)
                Spacer()
                DifficultyBadge(difficulty: recipe.difficulty)
            }
            HStack(spacing: 16) {
                Label("\(Int(recipe.defaultCoffeeGrams))g", systemImage: "scalemass")
                Label("\(Int(recipe.defaultWaterMl))ml", systemImage: "drop")
                Label("\(recipe.steps.count) steps", systemImage: "list.number")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 4)
    }
}

struct DifficultyBadge: View {
    let difficulty: Difficulty

    var color: Color {
        switch difficulty {
        case .easy: return .green
        case .intermediate: return .orange
        case .advanced: return .red
        }
    }

    var body: some View {
        Text(difficulty.rawValue)
            .font(.caption2)
            .fontWeight(.semibold)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(color.opacity(0.15), in: Capsule())
            .foregroundStyle(color)
    }
}

#Preview {
    NavigationStack {
        RecipeListView(method: .v60)
    }
}
