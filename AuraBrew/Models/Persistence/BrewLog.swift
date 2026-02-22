import Foundation
import SwiftData

@Model
final class BrewLog {
    var date: Date
    var recipeName: String
    var brewMethod: String   // rawValue of BrewMethod — enums not SwiftData-safe
    var coffeeGrams: Double
    var waterMl: Double
    var coffeeName: String
    var grindSize: String
    var notes: String
    var rating: Int  // 1–5

    init(
        date: Date = .now,
        recipeName: String,
        brewMethod: String,
        coffeeGrams: Double,
        waterMl: Double,
        coffeeName: String = "",
        grindSize: String = "",
        notes: String = "",
        rating: Int = 3
    ) {
        self.date = date
        self.recipeName = recipeName
        self.brewMethod = brewMethod
        self.coffeeGrams = coffeeGrams
        self.waterMl = waterMl
        self.coffeeName = coffeeName
        self.grindSize = grindSize
        self.notes = notes
        self.rating = rating
    }

    var brewMethodEnum: BrewMethod? { BrewMethod(rawValue: brewMethod) }

    var ratio: String {
        guard coffeeGrams > 0 else { return "—" }
        let r = waterMl / coffeeGrams
        return String(format: "1:%.1f", r)
    }
}
