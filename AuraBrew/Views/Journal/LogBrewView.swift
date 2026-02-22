import SwiftUI
import SwiftData

struct LogBrewView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    // Pre-populated from brew session or calculator
    private let preRecipeName: String
    private let preMethod: String
    private let preCoffeeGrams: Double
    private let preWaterMl: Double
    private let onSaved: (() -> Void)?

    @State private var recipeName: String
    @State private var brewMethod: String
    @State private var coffeeGrams: Double
    @State private var waterMl: Double
    @State private var coffeeName: String = ""
    @State private var grindSize: String = ""
    @State private var notes: String = ""
    @State private var rating: Int = 3

    // Init from active brew session
    init(recipe: Recipe, coffeeGrams: Double, waterMl: Double, onSaved: (() -> Void)? = nil) {
        self.preRecipeName = recipe.name
        self.preMethod = recipe.method.rawValue
        self.preCoffeeGrams = coffeeGrams
        self.preWaterMl = waterMl
        self.onSaved = onSaved
        _recipeName = State(initialValue: recipe.name)
        _brewMethod = State(initialValue: recipe.method.rawValue)
        _coffeeGrams = State(initialValue: coffeeGrams)
        _waterMl = State(initialValue: waterMl)
    }

    // Init from calculator (no recipe context)
    init(coffeeGrams: Double, waterMl: Double, onSaved: (() -> Void)? = nil) {
        self.preRecipeName = ""
        self.preMethod = BrewMethod.v60.rawValue
        self.preCoffeeGrams = coffeeGrams
        self.preWaterMl = waterMl
        self.onSaved = onSaved
        _recipeName = State(initialValue: "")
        _brewMethod = State(initialValue: BrewMethod.v60.rawValue)
        _coffeeGrams = State(initialValue: coffeeGrams)
        _waterMl = State(initialValue: waterMl)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("Brew Info") {
                    LabeledContent("Recipe") {
                        Text(recipeName.isEmpty ? "Custom" : recipeName)
                            .foregroundStyle(.secondary)
                    }

                    Picker("Method", selection: $brewMethod) {
                        ForEach(BrewMethod.allCases, id: \.rawValue) { m in
                            Text(m.displayName).tag(m.rawValue)
                        }
                    }
                }

                Section("Amounts") {
                    HStack {
                        Text("Coffee")
                        Spacer()
                        TextField("grams", value: $coffeeGrams, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        Text("g").foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Water")
                        Spacer()
                        TextField("ml", value: $waterMl, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                        Text("ml").foregroundStyle(.secondary)
                    }
                    LabeledContent("Ratio") {
                        Text(coffeeGrams > 0 ? String(format: "1 : %.1f", waterMl / coffeeGrams) : "—")
                            .foregroundStyle(.secondary)
                    }
                }

                Section("Details") {
                    TextField("Coffee bean name", text: $coffeeName)
                    TextField("Grind size", text: $grindSize)
                }

                Section("Rating") {
                    StarRatingPicker(rating: $rating)
                }

                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(minHeight: 80)
                }
            }
            .navigationTitle("Log Brew")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .fontWeight(.semibold)
                }
            }
        }
    }

    private func save() {
        let log = BrewLog(
            recipeName: recipeName.isEmpty ? "Custom" : recipeName,
            brewMethod: brewMethod,
            coffeeGrams: coffeeGrams,
            waterMl: waterMl,
            coffeeName: coffeeName,
            grindSize: grindSize,
            notes: notes,
            rating: rating
        )
        modelContext.insert(log)
        onSaved?()
        dismiss()
    }
}

// MARK: – Star Rating Picker

struct StarRatingPicker: View {
    @Binding var rating: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(1...5, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundStyle(star <= rating ? .yellow : .secondary)
                    .font(.title2)
                    .onTapGesture { rating = star }
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    LogBrewView(recipe: RecipeLibrary.classicV60, coffeeGrams: 15, waterMl: 250)
        .modelContainer(for: BrewLog.self, inMemory: true)
}
