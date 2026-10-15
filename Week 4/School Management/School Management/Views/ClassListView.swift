import SwiftUI

struct ClassListView: View {
    @StateObject private var viewModel = ClassManagerViewModel()
    
    var body: some View {
        TabView {
            StudentsView(viewModel: viewModel)
                .tabItem {
                    Label("Students", systemImage: "person.3.fill")
                }
            
            SubjectsView(viewModel: viewModel)
                .tabItem {
                    Label("Subjects", systemImage: "book.fill")
                }
            
            GradesView(viewModel: viewModel)
                .tabItem {
                    Label("Grades & Enroll", systemImage: "square.and.pencil")
                }
            
            StatisticsView(viewModel: viewModel)
                .tabItem {
                    Label("Statistics", systemImage: "chart.bar.xaxis")
                }
        }
    }
}
