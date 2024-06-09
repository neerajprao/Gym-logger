import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ExerciseListView()
                .navigationTitle("Gym Logger")
        }
    }
}
