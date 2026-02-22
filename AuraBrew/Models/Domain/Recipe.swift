import Foundation

enum Difficulty: String, CaseIterable, Codable {
    case easy = "Easy"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var color: String {
        switch self {
        case .easy: return "green"
        case .intermediate: return "orange"
        case .advanced: return "red"
        }
    }
}

struct Recipe: Identifiable, Hashable {
    let id: UUID
    let name: String
    let method: BrewMethod
    let steps: [BrewStep]
    let defaultCoffeeGrams: Double
    let defaultWaterMl: Double
    let difficulty: Difficulty
    let waterTemperatureCelsius: Int?

    var defaultRatio: Double { defaultWaterMl / defaultCoffeeGrams }

    // Hashable by id only
    static func == (lhs: Recipe, rhs: Recipe) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { hasher.combine(id) }

    /// Returns a copy of steps scaled to the given coffee amount,
    /// also patching pour amounts in description text.
    func scaledSteps(coffeeGrams: Double) -> [BrewStep] {
        let factor = coffeeGrams / defaultCoffeeGrams
        return steps.map { step in
            let scaledPour = step.pourAmountMl.map { $0 * factor }
            var description = step.description
            if let original = step.pourAmountMl,
               let scaled = scaledPour,
               abs(factor - 1.0) > 0.001 {
                let originalStr = String(format: "%.0fml", original)
                let scaledStr   = String(format: "%.0fml", scaled)
                description = description.replacingOccurrences(of: originalStr, with: scaledStr)
            }
            return BrewStep(
                id: step.id,
                name: step.name,
                description: description,
                durationSeconds: step.durationSeconds,
                pourAmountMl: scaledPour
            )
        }
    }
}
