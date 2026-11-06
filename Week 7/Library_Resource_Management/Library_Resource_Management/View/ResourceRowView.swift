import SwiftUI

struct ResourceRowView: View {
    let resource: LibraryResource
    
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
        return "Unknown Resource"
    }

    var resourceIcon: String {
        if resource is PrintedBook {
            return "book.closed"
        }
        else if resource is AcademicJournal {
            return "doc.text"
        }
        else if resource is DigitalMaterial {
            return "laptopcomputer"
        }
        return "questionmark.circle"
    }

    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: resourceIcon)
                .font(.system(size: 30))
                .foregroundStyle(.blue)
                .frame(width: 45)
            VStack(alignment: .leading, spacing: 5) {
                Text(resource.title).font(.headline)
                Text(resourceType)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(resource.availabilityDescription)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 5)
    }
}
