import SwiftUI

struct ResourceDetailView: View {
    let resource: LibraryResource
    @ObservedObject var viewModel: LibraryViewModel

    // Determine resource type
    var resourceType: String {
        if resource is PrintedBook {
            return "Printed Book"
        }
        else if resource is AcademicJournal {
            return "Academic Journal"
        }
        else if resource is DigitalMaterial {
            return "Digital Material"
        }
        return "Unknown"
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {

                // Title
                Text(resource.title).font(.largeTitle).bold()
                Text(resourceType).font(.title3).foregroundStyle(.secondary)
                Divider()

                // General information
                Group {
                    detailRow(
                        title: "Resource ID",
                        value: resource.id
                    )
                    detailRow(
                        title: "Publication Year",
                        value: String(resource.publicationYear)
                    )
                    detailRow(
                        title: "Availability",
                        value: resource.availabilityDescription
                    )
                }
                Divider()

                // Book information
                if let book = resource as? PrintedBook {
                    Group {
                        Text("Book Information").font(.headline)
                        detailRow(
                            title: "Author",
                            value: book.author
                        )
                        detailRow(
                            title: "ISBN",
                            value: book.isbn
                        )
                        detailRow(
                            title: "Borrowing Period",
                            value: "\(book.borrowingPeriod) days"
                        )
                        detailRow(
                            title: "Refundable Deposit",
                            value: String(format: "$%.2f", book.deposit)
                        )
                        detailRow(
                            title: "Daily Late Fee",
                            value: String(format: "$%.2f", book.dailyLateFee)
                        )
                    }
                }

                // Journal information
                if let journal = resource as? AcademicJournal {
                    Group {
                        Text("Journal Information").font(.headline)
                        detailRow(
                            title: "Volume",
                            value: String(journal.volume)
                        )
                        detailRow(
                            title: "Issue",
                            value: String(journal.issue)
                        )
                        detailRow(
                            title: "Borrowable",
                            value: journal.isBorrowable ? "Yes" : "No"
                        )
                    }
                }

                // Digital material information
                if let material = resource as? DigitalMaterial {
                    Group {
                        Text("Digital Material Information").font(.headline)
                        detailRow(
                            title: "Platform",
                            value: material.platform
                        )
                        detailRow(
                            title: "Expiration Date",
                            value: material.expirationDate.formatted(date: .abbreviated, time: .omitted)
                        )
                        detailRow(
                            title: "Maximum Users",
                            value: String(material.maxSimultaneousUsers)
                        )
                        detailRow(
                            title: "Active Users",
                            value: String(material.activeUsers)
                        )
                        detailRow(
                            title: "Access Fee",
                            value: String(format: "$%.2f", material.accessFee)
                        )
                    }
                }
                Divider()

                // Action buttons
                Text("Library Actions").font(.headline)
                
                if viewModel.hasActiveBorrowing(
                    resourceId: resource.id
                ) {
                    Button {
                        viewModel.returnResource(
                            resourceId: resource.id
                        )
                    } label: {
                        Label(
                            "Return / End Access",
                            systemImage: "arrow.uturn.backward"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                }
                else {
                    Button {
                        viewModel.borrowResource(
                            resourceId: resource.id
                        )
                    } label: {
                        Label(
                            "Borrow / Request Access",
                            systemImage: "book.fill"
                        )
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
        }
        .navigationTitle("Resource Details")
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "Library Notification",
            isPresented: $viewModel.showAlert
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.message)
        }
    }

    // Reusable detail row
    func detailRow(
        title: String,
        value: String
    ) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .multilineTextAlignment(.trailing)
        }
        .font(.body)
    }
}
