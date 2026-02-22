import Foundation
import Observation

@Observable
final class BrewSessionViewModel {

    private(set) var recipe: Recipe
    private(set) var currentStepIndex: Int = 0
    private(set) var elapsedSeconds: Int = 0
    private(set) var isRunning: Bool = false
    private(set) var isComplete: Bool = false
    private(set) var totalElapsedSeconds: Int = 0
    private(set) var isPaused: Bool = false

    private var timer: Timer?

    // Scaled steps using the custom coffee amount chosen in RecipeDetailView
    let steps: [BrewStep]
    let coffeeGrams: Double
    var waterMl: Double { coffeeGrams * recipe.defaultRatio }

    init(recipe: Recipe, coffeeGrams: Double) {
        self.recipe = recipe
        self.coffeeGrams = coffeeGrams
        self.steps = recipe.scaledSteps(coffeeGrams: coffeeGrams)
    }

    // MARK: – Derived Properties

    var currentStep: BrewStep? {
        guard currentStepIndex < steps.count else { return nil }
        return steps[currentStepIndex]
    }

    var remainingSeconds: Int {
        guard let step = currentStep, !step.isOpenEnded else { return 0 }
        return max(0, step.durationSeconds - elapsedSeconds)
    }

    var progressFraction: Double {
        guard let step = currentStep, !step.isOpenEnded, step.durationSeconds > 0 else { return 0 }
        return min(1.0, Double(elapsedSeconds) / Double(step.durationSeconds))
    }

    var stepProgress: String { "\(currentStepIndex + 1) of \(steps.count)" }

    var stepTimedOut: Bool {
        guard let step = currentStep, !step.isOpenEnded else { return false }
        return elapsedSeconds >= step.durationSeconds
    }

    // MARK: – Control

    func startCurrentStep() {
        guard let step = currentStep else { return }
        elapsedSeconds = 0
        isRunning = true
        isPaused = false

        if !step.isOpenEnded {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                self?.tick()
            }
        }
    }

    func pause() {
        guard isRunning, !isPaused else { return }
        stopTimer()
        isRunning = false
        isPaused = true
    }

    func resume() {
        guard isPaused, let step = currentStep, !step.isOpenEnded else { return }
        isRunning = true
        isPaused = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
    }

    func advanceStep() {
        stopTimer()
        let nextIndex = currentStepIndex + 1
        if nextIndex >= steps.count {
            isComplete = true
            isRunning = false
        } else {
            currentStepIndex = nextIndex
            startCurrentStep()
        }
    }

    func endBrew() {
        stopTimer()
        isComplete = true
        isRunning = false
    }

    // MARK: – Private

    private func tick() {
        guard let step = currentStep else { return }
        elapsedSeconds += 1
        totalElapsedSeconds += 1
        if elapsedSeconds >= step.durationSeconds {
            stopTimer()
            isRunning = false
            // View observes stepTimedOut to fire haptic and show Next prompt
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
