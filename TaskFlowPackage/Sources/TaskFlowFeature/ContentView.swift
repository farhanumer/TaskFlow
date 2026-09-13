import SwiftUI

public struct ContentView: View {
    @State private var tasks: [TaskItem]

    public init(tasks: [TaskItem] = TaskItem.samples) {
        _tasks = State(initialValue: tasks)
    }

    public var body: some View {
        TabView {
            TaskListView(tasks: $tasks)
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }

            CategoriesView(tasks: $tasks)
                .tabItem {
                    Label("Categories", systemImage: "square.grid.2x2.fill")
                }

            ProfileView(tasks: tasks)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    ContentView()
}
