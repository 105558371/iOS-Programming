import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = LibraryViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                // User selection
                VStack(alignment: .leading) {
                    Text("Current Library User").font(.headline)
                    Picker(
                        "Select User",
                        selection: $viewModel.selectedUserId
                    ) {
                        ForEach(viewModel.users) { user in
                            Text(user.name).tag(user.userId)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .padding()

                // Resource list
                List {
                    Section("Library Resources") {
                        ForEach(
                            viewModel.filteredResources
                        ) { resource in
                            NavigationLink {
                                ResourceDetailView(
                                    resource: resource,
                                    viewModel: viewModel
                                )
                            } label: {
                                ResourceRowView(
                                    resource: resource
                                )
                            }
                        }
                    }

                    // Borrowing history
                    Section("Borrowing History") {
                        if viewModel.borrowingRecords.isEmpty {
                            Text("No borrowing records yet.").foregroundStyle(.secondary)
                        }
                        else {
                            ForEach(
                                viewModel.borrowingRecords
                            ) { record in
                                VStack(alignment: .leading) {
                                    Text(record.resourceTitle).font(.headline)
                                    Text("Borrower: \(record.borrowerName)")
                                    Text("Status: \(record.status.rawValue)")
                                    Text(
                                        "Due: \(record.dueDate.formatted(date:.abbreviated, time: .omitted))"
                                    )
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                    }
                }
                .searchable(text: $viewModel.searchText)
            }
            .navigationTitle("University Library")
        }
        .alert(
            "Library Notification",
            isPresented: $viewModel.showAlert
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.message)
        }
    }
}
