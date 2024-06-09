import SwiftUI

struct ExerciseRowView: View {
    let exercise: ExerciseEntry

    var body: some View {
        HStack {
            Text(exercise.name)
            Spacer()
            Text("\(exercise.weight) \(exercise.unit)")
        }
    }
}
