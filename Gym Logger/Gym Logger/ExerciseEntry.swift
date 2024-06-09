import Foundation

enum WeightUnit: String, CaseIterable, Identifiable {
    case kg, lbs
    var id: String { self.rawValue }
}

struct ExerciseEntry: Identifiable {
    var id = UUID()
    var name: String
    var weight: Double
    var unit: WeightUnit
    var date: Date
}
