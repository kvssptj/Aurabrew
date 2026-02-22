import Foundation
import Observation

@Observable
final class CalculatorViewModel {

    enum Unit: String, CaseIterable {
        case ml = "ml"
        case oz = "fl oz"
    }

    var coffeeGrams: Double = 15
    var ratio: Double = 16        // water : coffee
    var unit: Unit = .ml

    // Ratio presets
    static let ratioPresets: [(label: String, value: Double)] = [
        ("Strong (1:12)", 12),
        ("Balanced (1:15)", 15),
        ("Classic (1:16)", 16),
        ("Light (1:18)", 18)
    ]

    var waterMl: Double { coffeeGrams * ratio }

    var waterDisplay: String {
        switch unit {
        case .ml:  return String(format: "%.0f ml", waterMl)
        case .oz:  return String(format: "%.1f fl oz", waterMl / 29.5735)
        }
    }

    var coffeeDisplay: String { String(format: "%.1f g", coffeeGrams) }

    var ratioDisplay: String { String(format: "1 : %.1f", ratio) }
}
