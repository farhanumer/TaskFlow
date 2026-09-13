import Testing
@testable import TaskFlowFeature

@Test func taskItemDefaultsToNotDone() async throws {
    let task = TaskItem(title: "Buy milk")
    #expect(task.isDone == false)
    #expect(task.title == "Buy milk")
}

@Test func samplesAreNotEmpty() async throws {
    #expect(!TaskItem.samples.isEmpty)
}
