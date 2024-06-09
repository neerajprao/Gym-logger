import SwiftUI

struct EditExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    var exercise: ExerciseEntry
    @Binding var exercises: [ExerciseEntry]

    @State private var exerciseName: String
    @State private var weightInput: String
    @State private var selectedUnit: WeightUnit
    @State private var exerciseDate: Date

    init(exercise: ExerciseEntry, exercises: Binding<[ExerciseEntry]>) {
        self.exercise = exercise
        self._exercises = exercises
        self._exerciseName = State(initialValue: exercise.name)
        self._weightInput = State(initialValue: "\(exercise.weight)")
        self._selectedUnit = State(initialValue: exercise.unit)
        self._exerciseDate = State(initialValue: exercise.date)
    }

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
            Button("Save Changes") {
                saveExerciseChanges()
            }
        }
        .navigationTitle("Edit Exercise")
    }

    private func saveExerciseChanges() {
        guard let weight = Double(weightInput) else { return }
        if let index = exercises.firstIndex(where: { $0.id == exercise.id }) {
            exercises[index].name = exerciseName
            exercises[index].weight = weight
            exercises[index].unit = selectedUnit
            exercises[index].date = exerciseDate
        }
        presentationMode.wrappedValue.dismiss()
    }
}
