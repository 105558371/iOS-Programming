import SwiftUI

struct CategoryRowView: View {
    let categories: [ProductCategory] = [
        ProductCategory(name: "Cá cảnh", iconName: "fish.fill"),
        ProductCategory(name: "Cây thủy sinh", iconName: "leaf.fill"),
        ProductCategory(name: "Phụ kiện bể", iconName: "shippingbox.fill"),
        ProductCategory(name: "Thiết bị lọc", iconName: "cylinder.fill")
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(categories) { category in
                    VStack(spacing: 8) {
                        Image(systemName: category.iconName)
                            .font(.title2)
                            .foregroundColor(.blue)
                            .frame(width: 56, height: 56)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        
                        Text(category.name)
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
