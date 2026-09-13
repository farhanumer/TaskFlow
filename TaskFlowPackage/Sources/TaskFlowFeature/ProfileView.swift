import SwiftUI

struct ProfileView: View {
    let tasks: [TaskItem]

    @State private var dailyRemindersEnabled = true
    @State private var soundEffectsEnabled = false
    @State private var appearance: Appearance = .system

    enum Appearance: String, CaseIterable, Identifiable {
        case system
        case light
        case dark

        var id: String { rawValue }
        var title: String { rawValue.capitalized }
    }

    private var completedCount: Int {
        tasks.filter(\.isDone).count
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 16) {
                        Image("Avatar")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 64, height: 64)
                            .clipShape(Circle())

                        VStack(alignment: .leading) {
                            Text("Alex Rivera")
                                .font(.headline)
                            Text("\(completedCount) of \(tasks.count) tasks completed")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Preferences") {
                    Toggle("Daily reminders", isOn: $dailyRemindersEnabled)
                    Toggle("Sound effects", isOn: $soundEffectsEnabled)
                    Picker("Appearance", selection: $appearance) {
                        ForEach(Appearance.allCases) { option in
                            Text(option.title).tag(option)
                        }
                    }
                }

                Section("About") {
                    Image("AboutCover")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 120)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .listRowInsets(EdgeInsets())

                    Text("TaskFlow helps you organize work, personal errands, health habits, and learning goals in one simple, focused app.")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView(tasks: TaskItem.samples)
}
