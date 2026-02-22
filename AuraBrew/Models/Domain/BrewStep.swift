import Foundation

struct BrewStep: Identifiable, Hashable {
    let id: UUID
    let name: String
    let description: String
    let durationSeconds: Int   // 0 = open-ended
    let pourAmountMl: Double?

    var isOpenEnded: Bool { durationSeconds == 0 }

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        durationSeconds: Int,
        pourAmountMl: Double? = nil
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.durationSeconds = durationSeconds
        self.pourAmountMl = pourAmountMl
    }
}
