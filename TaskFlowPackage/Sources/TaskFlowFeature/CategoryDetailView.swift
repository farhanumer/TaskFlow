import SwiftUI

struct CategoryDetailView: View {
    let category: TaskCategory
    @Binding var tasks: [TaskItem]

    private var filteredIndices: [Int] {
        tasks.indices.filter { tasks[$0].category == category }
    }

    private var progress: Double {
        let items = tasks.filter { $0.category == category }
        guard !items.isEmpty else { return 0 }
        return Double(items.filter(\.isDone).count) / Double(items.count)
    }

    var body: some View {
        List {
            Section {
                Image(category.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 160)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)

                VStack(alignment: .leading, spacing: 6) {
                    ProgressView(value: progress)
                        .tint(category.tint)
                    Text("\(Int(progress * 100))% complete")
                        .font(.caption)
                        .foregroundStyle(.secondary)
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

                        Text(tasks[index].title)
                            .strikethrough(tasks[index].isDone)
                    }
                }
            }
        }
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CategoryDetailView(category: .work, tasks: .constant(TaskItem.samples))
}
