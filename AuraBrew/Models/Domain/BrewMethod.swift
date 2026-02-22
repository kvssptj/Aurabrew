import Foundation

enum BrewMethod: String, CaseIterable, Hashable, Codable {
    case v60 = "V60"
    case aeropress = "AeroPress"
    case frenchPress = "French Press"

    var displayName: String { rawValue }

    var systemImage: String {
        switch self {
        case .v60: return "drop.fill"
        case .aeropress: return "cylinder.fill"
        case .frenchPress: return "mug.fill"
        }
    }

    var description: String {
        switch self {
        case .v60: return "Pour-over brewing with nuanced flavor clarity"
        case .aeropress: return "Versatile immersion brewing, rich and smooth"
        case .frenchPress: return "Full immersion brewing for rich, textured results"
        }
    }
}
