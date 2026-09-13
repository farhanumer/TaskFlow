import SwiftUI

struct CategoriesView: View {
    @Binding var tasks: [TaskItem]

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(TaskCategory.allCases) { category in
                        NavigationLink(value: category) {
                            CategoryCard(category: category, tasks: tasksFor(category))
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Categories")
            .navigationDestination(for: TaskCategory.self) { category in
                CategoryDetailView(category: category, tasks: $tasks)
            }
        }
    }

    private func tasksFor(_ category: TaskCategory) -> [TaskItem] {
        tasks.filter { $0.category == category }
    }
}

private struct CategoryCard: View {
    let category: TaskCategory
    let tasks: [TaskItem]

    private var completedCount: Int {
        tasks.filter(\.isDone).count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Image(category.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 100)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(alignment: .topTrailing) {
                    Image(systemName: category.symbolName)
                        .foregroundStyle(.white)
                        .padding(8)
                        .background(.ultraThinMaterial, in: Circle())
                        .padding(8)
                }

            Text(category.title)
                .font(.headline)

            Text("\(completedCount)/\(tasks.count) done")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(10)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

#Preview {
    CategoriesView(tasks: .constant(TaskItem.samples))
}
