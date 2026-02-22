import SwiftUI

struct ActiveBrewView: View {
    @State var viewModel: BrewSessionViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var showEndConfirm = false
    @State private var showLogSheet = false
    @State private var didFireCompletionHaptic = false

    private let successHaptic = UINotificationFeedbackGenerator()
    private let mediumHaptic = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()

            if viewModel.isComplete {
                completionOverlay
            } else {
                VStack(spacing: 0) {
                    stepProgressBar
                    temperatureRow
                    Spacer()
                    mainContent
                    Spacer()
                    actionButtons
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.startCurrentStep()
        }
        .onChange(of: viewModel.stepTimedOut) { _, timedOut in
            if timedOut { successHaptic.notificationOccurred(.success) }
        }
        .onChange(of: viewModel.isComplete) { _, complete in
            if complete && !didFireCompletionHaptic {
                didFireCompletionHaptic = true
                successHaptic.notificationOccurred(.success)
            }
        }
        .sheet(isPresented: $showLogSheet) {
            LogBrewView(
                recipe: viewModel.recipe,
                coffeeGrams: viewModel.coffeeGrams,
                waterMl: viewModel.waterMl,
                onSaved: { dismiss() }
            )
        }
        .confirmationDialog("End this brew?", isPresented: $showEndConfirm, titleVisibility: .visible) {
            Button("End Brew", role: .destructive) { viewModel.endBrew() }
            Button("Cancel", role: .cancel) {}
        }
    }

    // MARK: – Step progress bar

    private var stepProgressBar: some View {
        HStack(spacing: 6) {
            ForEach(0..<viewModel.steps.count, id: \.self) { i in
                Capsule()
                    .fill(i <= viewModel.currentStepIndex ? Color.brown : Color.secondary.opacity(0.25))
                    .frame(height: 4)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.currentStepIndex)
            }
        }
        .padding(.top, 8)
    }

    // MARK: – Persistent temperature row

    @ViewBuilder
    private var temperatureRow: some View {
        if let temp = viewModel.recipe.waterTemperatureCelsius {
            HStack(spacing: 4) {
                Image(systemName: "thermometer.medium")
                Text("\(temp)°C")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
            .padding(.top, 6)
        }
    }

    // MARK: – Main content

    private var mainContent: some View {
        VStack(spacing: 20) {
            if let step = viewModel.currentStep {
                Text("Step \(viewModel.stepProgress)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(step.name)
                    .font(.largeTitle.bold())
                    .multilineTextAlignment(.center)

                if let pour = step.pourAmountMl {
                    HStack(spacing: 6) {
                        Image(systemName: "drop.fill")
                        Text(String(format: "Pour: %.0fml", pour))
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 8)
                    .background(.brown, in: Capsule())
                }

                ScrollView {
                    Text(step.description)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .frame(maxHeight: 100)

                timerView(for: step)
            }
        }
    }

    @ViewBuilder
    private func timerView(for step: BrewStep) -> some View {
        if step.isOpenEnded {
            Text("Tap when ready")
                .font(.title3)
                .foregroundStyle(.secondary)
                .padding(.top, 8)
        } else {
            ZStack {
                Circle()
                    .stroke(Color.secondary.opacity(0.2), lineWidth: 10)
                    .frame(width: 160, height: 160)

                Circle()
                    .trim(from: 0, to: viewModel.progressFraction)
                    .stroke(
                        viewModel.isPaused ? Color.secondary : Color.brown,
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .frame(width: 160, height: 160)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1), value: viewModel.progressFraction)

                VStack(spacing: 2) {
                    Text(TimeFormatter.format(viewModel.remainingSeconds))
                        .font(.system(size: 42, weight: .bold, design: .rounded))
                        .monospacedDigit()
                    if viewModel.isPaused {
                        Text("Paused")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    } else if viewModel.stepTimedOut {
                        Text("Done!")
                            .font(.caption)
                            .foregroundStyle(.brown)
                    }
                }
            }
            .padding(.top, 8)
        }
    }

    // MARK: – Action buttons

    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
                mediumHaptic.impactOccurred()
                viewModel.advanceStep()
            } label: {
                let isLast = viewModel.currentStepIndex == viewModel.steps.count - 1
                Label(isLast ? "Finish Brew" : "Next Step",
                      systemImage: isLast ? "checkmark" : "arrow.right")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(.brown)

            if let step = viewModel.currentStep, !step.isOpenEnded, !viewModel.stepTimedOut {
                Button {
                    if viewModel.isPaused {
                        viewModel.resume()
                    } else {
                        viewModel.pause()
                    }
                } label: {
                    Label(
                        viewModel.isPaused ? "Resume" : "Pause",
                        systemImage: viewModel.isPaused ? "play.fill" : "pause.fill"
                    )
                    .font(.subheadline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                }
                .buttonStyle(.bordered)
                .tint(.brown)
            }

            Button("End Brew", role: .destructive) {
                showEndConfirm = true
            }
            .font(.subheadline)
            .foregroundStyle(.secondary)
        }
        .padding(.bottom, 8)
    }

    // MARK: – Completion overlay

    private var completionOverlay: some View {
        VStack(spacing: 28) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 72))
                .foregroundStyle(.brown)

            VStack(spacing: 8) {
                Text("Brew Complete!")
                    .font(.largeTitle.bold())
                Text("Total time: \(TimeFormatter.format(viewModel.totalElapsedSeconds))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            VStack(spacing: 14) {
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

                Button("Done") { dismiss() }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 32)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

// MARK: – TimeFormatter

enum TimeFormatter {
    static func format(_ seconds: Int) -> String {
        let m = seconds / 60
        let s = seconds % 60
        return String(format: "%d:%02d", m, s)
    }
}

#Preview {
    ActiveBrewView(
        viewModel: BrewSessionViewModel(recipe: RecipeLibrary.classicV60, coffeeGrams: 15)
    )
}
