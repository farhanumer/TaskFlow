import Foundation

public struct TaskItem: Identifiable, Equatable, Sendable {
    public let id: UUID
    public var title: String
    public var isDone: Bool
    public var category: TaskCategory
    public var isFavorite: Bool

    public init(id: UUID = UUID(), title: String, isDone: Bool = false, category: TaskCategory = .personal, isFavorite: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
        self.category = category
        self.isFavorite = isFavorite
    }
}

extension TaskItem {
    public static let samples: [TaskItem] = [
        TaskItem(title: "Prepare demo script", isDone: true, category: .work),
        TaskItem(title: "Scaffold sample app", isDone: true, category: .work),
        TaskItem(title: "Wire up Linear issue workflow", category: .work, isFavorite: true),
        TaskItem(title: "Record walkthrough", category: .work),
        TaskItem(title: "Morning run", isDone: true, category: .health),
        TaskItem(title: "Meditate 10 minutes", category: .health),
        TaskItem(title: "Read SwiftUI docs", category: .learning),
        TaskItem(title: "Finish online course module", category: .learning),
        TaskItem(title: "Plan weekend trip", category: .personal, isFavorite: true),
        TaskItem(title: "Call parents", isDone: true, category: .personal),
    ]
}
