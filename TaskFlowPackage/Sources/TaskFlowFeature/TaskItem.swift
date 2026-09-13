import Foundation

public struct TaskItem: Identifiable, Equatable, Sendable {
    public let id: UUID
    public var title: String
    public var isDone: Bool

    public init(id: UUID = UUID(), title: String, isDone: Bool = false) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}

extension TaskItem {
    public static let samples: [TaskItem] = [
        TaskItem(title: "Prepare demo script", isDone: true),
        TaskItem(title: "Scaffold sample app", isDone: true),
        TaskItem(title: "Wire up Linear issue workflow"),
        TaskItem(title: "Record walkthrough"),
    ]
}
