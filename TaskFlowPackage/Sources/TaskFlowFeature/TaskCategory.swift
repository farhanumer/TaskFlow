import SwiftUI

public enum TaskCategory: String, CaseIterable, Identifiable, Sendable, Hashable {
    case work
    case personal
    case health
    case learning

    public var id: String { rawValue }

    public var title: String {
        switch self {
        case .work: return "Work"
        case .personal: return "Personal"
        case .health: return "Health"
        case .learning: return "Learning"
        }
    }

    public var symbolName: String {
        switch self {
        case .work: return "briefcase.fill"
        case .personal: return "house.fill"
        case .health: return "heart.fill"
        case .learning: return "book.fill"
        }
    }

    public var imageName: String {
        "Category-\(title)"
    }

    public var tint: Color {
        switch self {
        case .work: return .blue
        case .personal: return .orange
        case .health: return .pink
        case .learning: return .green
        }
    }
}
