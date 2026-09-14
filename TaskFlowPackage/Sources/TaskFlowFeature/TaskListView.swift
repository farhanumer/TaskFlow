import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [TaskItem]
    @State private var newTaskTitle: String = ""
    @State private var newTaskCategory: TaskCategory = .personal
    @State private var showFavoritesOnly = false

    private var filteredIndices: [Int] {
        tasks.indices.filter { showFavoritesOnly ? tasks[$0].isFavorite : true }
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
                    ForEach(filteredIndices, id: \.self) { index in
                        HStack {
                            Button {
                                toggle(tasks[index])
                            } label: {
                                Image(systemName: tasks[index].isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(tasks[index].isDone ? .green : .secondary)
                            }
                            .buttonStyle(.plain)

                            Button {
                                toggleFavorite(tasks[index])
                            } label: {
                                Image(systemName: tasks[index].isFavorite ? "star.fill" : "star")
                                    .foregroundStyle(tasks[index].isFavorite ? .yellow : .secondary)
                            }
                            .buttonStyle(.plain)

                            Image(systemName: tasks[index].category.symbolName)
                                .foregroundStyle(tasks[index].category.tint)
                                .frame(width: 20)

                            Text(tasks[index].title)
                                .strikethrough(tasks[index].isDone)
                                .foregroundStyle(tasks[index].isDone ? .secondary : .primary)
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
                            .foregroundStyle(showFavoritesOnly ? .yellow : .secondary)
                    }
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
        let indices = filteredIndices
        let actualOffsets = IndexSet(offsets.map { indices[$0] })
        tasks.remove(atOffsets: actualOffsets)
    }
}

#Preview {
    TaskListView(tasks: .constant(TaskItem.samples))
}
