import SwiftUI

struct TaskListView: View {
    @Binding var tasks: [TaskItem]
    @State private var newTaskTitle: String = ""
    @State private var newTaskCategory: TaskCategory = .personal
    @State private var showFavoritesOnly: Bool = false

    private var filteredIndices: [Int] {
        tasks.indices.filter { !showFavoritesOnly || tasks[$0].isFavorite }
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
                                tasks[index].isDone.toggle()
                            } label: {
                                Image(systemName: tasks[index].isDone ? "checkmark.circle.fill" : "circle")
                                    .foregroundStyle(tasks[index].isDone ? .green : .secondary)
                            }
                            .buttonStyle(.plain)

                            Image(systemName: tasks[index].category.symbolName)
                                .foregroundStyle(tasks[index].category.tint)
                                .frame(width: 20)

                            Text(tasks[index].title)
                                .strikethrough(tasks[index].isDone)
                                .foregroundStyle(tasks[index].isDone ? .secondary : .primary)

                            Spacer()

                            Button {
                                tasks[index].isFavorite.toggle()
                            } label: {
                                Image(systemName: tasks[index].isFavorite ? "star.fill" : "star")
                                    .foregroundStyle(tasks[index].isFavorite ? .yellow : .secondary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
            }
            .navigationTitle("TaskFlow")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Toggle(isOn: $showFavoritesOnly) {
                        Label("Favorites only", systemImage: showFavoritesOnly ? "star.fill" : "star")
                    }
                    .toggleStyle(.button)
                    .tint(.yellow)
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

    private func deleteTasks(at offsets: IndexSet) {
        let indicesToRemove = offsets.map { filteredIndices[$0] }
        tasks.remove(atOffsets: IndexSet(indicesToRemove))
    }
}

#Preview {
    TaskListView(tasks: .constant(TaskItem.samples))
}
