import SwiftUI

struct PlannerTask: Identifiable {
    let id = UUID()
    var title: String
    var category: String
    var isCompleted: Bool
    var time: String
}

struct ContentView: View {
    @State private var tasks: [PlannerTask] = [
        PlannerTask(title: "iOS Programming homework", category: "Study", isCompleted: true, time: "09:00"),
        PlannerTask(title: "House chore", category: "House", isCompleted: false, time: "17:00"),
        PlannerTask(title: "Practice Piano", category: "Hobbies", isCompleted: false, time: "20:00"),
        PlannerTask(title: "Visit grandma", category: "Family", isCompleted: false, time: "21:00")
    ]
    
    let userName: String = "Tran Phuong Ha"
    let quote: String = "\"Discipline today creates a brighter tomorrow.\""
    let currentDate: String = "Sep 2026"
    let dayOfWeek: String = "Thursday"
    let dayNumber: String = "17"

    var body: some View {
        VStack(spacing: 0) {
            ScrollView {
                VStack(spacing: 20) {
                    
                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading, spacing: 6) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Good Morning,")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    
                                    HStack {
                                        Text(userName)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.blue)
                                        Image(systemName: "leaf.fill")
                                            .foregroundColor(.green)
                                    }
                                }
                                Spacer()
                                Image(systemName: "sun.max.fill")
                                    .font(.title)
                                    .foregroundColor(.orange)
                            }
                            
                            Text(quote)
                                .font(.caption)
                                .italic()
                                .foregroundColor(.secondary)
                        }
                        .padding()
                        .background(Color.blue.opacity(0.08))
                        .cornerRadius(16)
                    }
                    .padding(.horizontal)

                    HStack(spacing: 18) {
                        HStack(spacing: 23) {
                            Image(systemName: "calendar")
                                .font(.title2)
                                .foregroundColor(.blue)
                            
                            VStack(alignment: .leading) {
                                Text(dayOfWeek)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(dayNumber)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text(currentDate)
                                    .font(.caption2)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 4)

                        HStack {
                            Image(systemName: "sparkles")
                                .foregroundColor(.orange)
                            VStack(alignment: .leading, spacing: 2) {
                                Text("New day")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                Text("New opportunities!")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                        }
                        .padding(25)
                        .background(Color.orange.opacity(0.12))
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    HStack {
                        Label("My Tasks", systemImage: "list.bullet.clipboard")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: addNewTask) {
                            HStack(spacing: 4) {
                                Image(systemName: "plus")
                                Text("Add Task")
                            }
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.green)
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 10) {
                        ForEach(tasks.indices, id: \.self) { index in
                            TaskRow(task: $tasks[index])
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            
            Divider()

            HStack {
                Spacer()
                TabButton(icon: "house.fill", title: "Today", isActive: true)
                Spacer()
                TabButton(icon: "chart.bar.fill", title: "Stats", isActive: false)
                Spacer()
                TabButton(icon: "gearshape.fill", title: "Settings", isActive: false)
                Spacer()
            }
            .padding(.top, 8)
            .background(Color(.systemBackground))
        }
    }
    
    private func addNewTask() {
        let newTask = PlannerTask(
            title: "Review Swift Code",
            category: "Study",
            isCompleted: false,
            time: "22:00"
        )
        tasks.append(newTask)
    }
}

struct TaskRow: View {
    @Binding var task: PlannerTask

    var body: some View {
        HStack(spacing: 12) {
            Button(action: { task.isCompleted.toggle() }) {
                Image(systemName: task.isCompleted ? "checkmark.square.fill" : "square")
                    .font(.title3)
                    .foregroundColor(task.isCompleted ? .green : .gray)
            }

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .strikethrough(task.isCompleted, color: .gray)
                    .foregroundColor(task.isCompleted ? .gray : .primary)
                
                Text(task.category)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(categoryColor(for: task.category).opacity(0.15))
                    .foregroundColor(categoryColor(for: task.category))
                    .cornerRadius(6)
            }

            Spacer()

            Text(task.time)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.04), radius: 3, x: 0, y: 2)
    }

    private func categoryColor(for category: String) -> Color {
        switch category {
        case "Study": return .blue
        case "House": return .red
        case "Hobbies": return .indigo
        case "Family": return .green
        default: return .gray
        }
    }
}


struct TabButton: View {
    let icon: String
    let title: String
    let isActive: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
            Text(title)
                .font(.caption2)
        }
        .foregroundColor(isActive ? .teal : .gray)
    }
}

#Preview {
    ContentView()
}
