import SwiftUI
import SwiftData

struct CalculatorView: View {
    @State private var viewModel = CalculatorViewModel()
    @State private var showLogSheet = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    resultCard
                    coffeeCard
                    ratioCard
                    unitCard

                    Button {
                        showLogSheet = true
                    } label: {
                        Label("Log This Brew", systemImage: "square.and.pencil")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.brown)
                }
                .padding()
            }
            .background(Color(.systemBackground))
            .navigationTitle("Calculator")
            .sheet(isPresented: $showLogSheet) {
                LogBrewView(coffeeGrams: viewModel.coffeeGrams, waterMl: viewModel.waterMl)
            }
        }
    }

    // MARK: – Result Card

    private var resultCard: some View {
        HStack(spacing: 0) {
            metricBox(label: "Coffee", value: viewModel.coffeeDisplay, icon: "scalemass.fill")
            Divider().frame(height: 50)
            metricBox(label: "Water", value: viewModel.waterDisplay, icon: "drop.fill")
            Divider().frame(height: 50)
            metricBox(label: "Ratio", value: viewModel.ratioDisplay, icon: "equal.circle.fill")
        }
        .padding()
        .notionCard()
    }

    private func metricBox(label: String, value: String, icon: String) -> some View {
        VStack(spacing: 6) {
            Image(systemName: icon).foregroundStyle(.brown)
            Text(value).font(.headline).monospacedDigit()
            Text(label).font(.caption).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: – Coffee Card

    private var coffeeCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Coffee").font(.headline)
            HStack {
                Text("Amount:").foregroundStyle(.secondary)
                Spacer()
                Text(viewModel.coffeeDisplay).fontWeight(.semibold)
            }
            Slider(value: $viewModel.coffeeGrams, in: 5...50, step: 0.5).tint(.brown)
        }
        .padding()
        .notionCard()
    }

    // MARK: – Ratio Card

    private var ratioCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Ratio").font(.headline)
            HStack {
                Text("Water : Coffee").foregroundStyle(.secondary)
                Spacer()
                Text(viewModel.ratioDisplay).fontWeight(.semibold)
            }
            Slider(value: $viewModel.ratio, in: 10...20, step: 0.5).tint(.brown)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(CalculatorViewModel.ratioPresets, id: \.value) { preset in
                        Button {
                            viewModel.ratio = preset.value
                        } label: {
                            Text(preset.label)
                                .font(.caption2)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(
                                    viewModel.ratio == preset.value ? Color.brown : Color.brown.opacity(0.1),
                                    in: Capsule()
                                )
                                .foregroundStyle(viewModel.ratio == preset.value ? Color.white : Color.brown)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
        }
        .padding()
        .notionCard()
    }

    // MARK: – Unit Card

    private var unitCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Display Unit").font(.headline)
            Picker("Unit", selection: $viewModel.unit) {
                ForEach(CalculatorViewModel.Unit.allCases, id: \.self) { u in
                    Text(u.rawValue).tag(u)
                }
            }
            .pickerStyle(.segmented)
        }
        .padding()
        .notionCard()
    }
}

#Preview {
    CalculatorView()
        .modelContainer(for: BrewLog.self, inMemory: true)
}
