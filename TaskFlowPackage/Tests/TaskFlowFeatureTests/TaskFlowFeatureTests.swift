import Testing
@testable import TaskFlowFeature

@Test func taskItemDefaultsToNotDoneAndPersonalCategory() async throws {
    let task = TaskItem(title: "Buy milk")
    #expect(task.isDone == false)
    #expect(task.title == "Buy milk")
    #expect(task.category == .personal)
}

@Test func taskItemDefaultsToNotFavorite() async throws {
    let task = TaskItem(title: "x")
    #expect(task.isFavorite == false)
}

@Test func samplesAreNotEmpty() async throws {
    #expect(!TaskItem.samples.isEmpty)
}

@Test func allCategoriesHaveDistinctSymbolsAndImageNames() async throws {
    let symbols = Set(TaskCategory.allCases.map(\.symbolName))
    let imageNames = Set(TaskCategory.allCases.map(\.imageName))
    #expect(symbols.count == TaskCategory.allCases.count)
    #expect(imageNames.count == TaskCategory.allCases.count)
}
