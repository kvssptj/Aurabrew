import Foundation

enum CaffeineCalculator {
    /// Approximate caffeine yield in mg per gram of coffee, by method.
    static func caffeine(for log: BrewLog) -> Double {
        let mgPerGram: Double
        switch log.brewMethodEnum {
        case .v60:          mgPerGram = 12   // ~12mg/g — typical pour-over extraction
        case .aeropress:    mgPerGram = 15   // ~15mg/g — higher extraction
        case .frenchPress:  mgPerGram = 10   // ~10mg/g — coarser grind, full immersion
        case nil:           mgPerGram = 12   // default if method not recognised
        }
        return log.coffeeGrams * mgPerGram
    }
}
