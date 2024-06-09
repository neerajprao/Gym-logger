import SwiftUI

struct ExerciseListView: View {
    @State private var exercises: [ExerciseEntry] = []
    @State private var selectedDate = Date()
    @State private var isCalendarVisible = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        isCalendarVisible.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .padding()
                    }
                    .sheet(isPresented: $isCalendarVisible, content: {
                        CalendarView(selectedDate: $selectedDate, exercises: $exercises)
                    })

                    Spacer()
                }
                .padding()

                List {
                    ForEach(filteredExercises) { exercise in
                        NavigationLink(destination: EditExerciseView(exercise: exercise, exercises: $exercises)) {
                            ExerciseRowView(exercise: exercise)
                                .padding(.vertical, 8)
                        }
                    }
                    .onDelete(perform: deleteExercise)
                }
                .listStyle(InsetGroupedListStyle())
                .navigationTitle("Exercise Log")
                .navigationBarItems(trailing: addButton)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
            }
        }
    }

    private var filteredExercises: [ExerciseEntry] {
        exercises.filter { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }

    private func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }

    private var addButton: some View {
        NavigationLink(destination: AddExerciseView(exercises: $exercises)) {
            Image(systemName: "plus")
        }
    }
}
