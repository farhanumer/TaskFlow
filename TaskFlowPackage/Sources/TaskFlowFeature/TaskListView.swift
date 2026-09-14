import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [TaskItem]
    @State private var newTaskTitle: String = ""
    @State private var newTaskCategory: TaskCategory = .personal
    @State private var showFavoritesOnly = false

    private var visibleTasks: [TaskItem] {
        showFavoritesOnly ? tasks.filter(\.isFavorite) : tasks
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        TextField("Add a task", text: $newTaskTitle)
                            .textFieldStyle(.roundedBorder)

                        Menu {
                            Picker("Category", selection: $newTaskCategory) {
                                ForEach(TaskCategory.allCases) { category in
                                    Label(category.title, systemImage: category.symbolName)
                                        .tag(category)
                                }
                            }
                        } label: {
                            Image(systemName: newTaskCategory.symbolName)
                                .foregroundStyle(newTaskCategory.tint)
                        }

                        Button {
                            addTask()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                        .disabled(newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    }
                }

                Section("Tasks") {
                    ForEach(visibleTasks) { task in
                        HStack {
                            Button {
                                toggle(task)
                            } label: {
                                Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(task.isDone ? .green : .secondary)
                            }
                            .buttonStyle(.plain)

                            Button {
                                toggleFavorite(task)
                            } label: {
                                Image(systemName: task.isFavorite ? "star.fill" : "star")
                                    .foregroundStyle(task.isFavorite ? .yellow : .secondary)
                            }
                            .buttonStyle(.plain)
                            .accessibilityIdentifier("task-row-favorite-\(task.id)")

                            Image(systemName: task.category.symbolName)
                                .foregroundStyle(task.category.tint)
                                .frame(width: 20)

                            Text(task.title)
                                .strikethrough(task.isDone)
                                .foregroundStyle(task.isDone ? .secondary : .primary)
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .navigationTitle("TaskFlow")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFavoritesOnly.toggle()
                    } label: {
                        Image(systemName: showFavoritesOnly ? "star.fill" : "star")
                    }
                    .accessibilityIdentifier("tasks-favorites-filter-toggle")
                }
            }
        }
    }

    private func addTask() {
        let trimmed = newTaskTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        tasks.append(TaskItem(title: trimmed, category: newTaskCategory))
        newTaskTitle = ""
    }

    private func toggle(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isDone.toggle()
    }

    private func toggleFavorite(_ task: TaskItem) {
        guard let index = tasks.firstIndex(where: { $0.id == task.id }) else { return }
        tasks[index].isFavorite.toggle()
    }

    private func deleteTasks(at offsets: IndexSet) {
        let idsToDelete = offsets.map { visibleTasks[$0].id }
        tasks.removeAll { idsToDelete.contains($0.id) }
    }
}

#Preview {
    TaskListView(tasks: .constant(TaskItem.samples))
}
