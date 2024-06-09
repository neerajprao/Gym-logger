import SwiftUI

struct CalendarView: View {
    @Binding var selectedDate: Date
    @Binding var exercises: [ExerciseEntry]

    var body: some View {
        VStack {
            DatePicker("Select Date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            List {
                ForEach(filteredExercises) { exercise in
                    NavigationLink(destination: EditExerciseView(exercise: exercise, exercises: $exercises)) {
                        ExerciseRowView(exercise: exercise)
                            .padding(.vertical, 4)
                    }
                }
            }
        }
        .navigationTitle("Calendar")
    }

    private var filteredExercises: [ExerciseEntry] {
        exercises.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
}
