import SwiftUI

struct AddExerciseView: View {
    @Binding var exercises: [ExerciseEntry]

    @State private var exerciseName = ""
    @State private var weightInput = ""
    @State private var selectedUnit = WeightUnit.kg
    @State private var exerciseDate = Date()

    var body: some View {
        Form {
            TextField("Exercise Name", text: $exerciseName)
            TextField("Weight", text: $weightInput)
                .keyboardType(.numberPad)
            Picker("Unit", selection: $selectedUnit) {
                ForEach(WeightUnit.allCases, id: \.self) { unit in
                    Text(unit.rawValue)
                }
            }
            DatePicker("Date", selection: $exerciseDate, displayedComponents: .date)
            Button("Save") {
                saveExercise()
            }
        }
        .navigationTitle("Add Exercise")
    }

    private func saveExercise() {
        guard let weight = Double(weightInput) else { return }
        let exercise = ExerciseEntry(name: exerciseName, weight: weight, unit: selectedUnit, date: exerciseDate)
        exercises.append(exercise)
        exerciseName = ""
        weightInput = ""
    }
}
