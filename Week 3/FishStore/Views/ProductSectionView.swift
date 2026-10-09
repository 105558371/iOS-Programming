import SwiftUI

struct ProductSectionView: View {
    let sampleProducts: [Product] = [
        Product(name: "Cá Bảy Màu Red Neon", categoryId: UUID(), price: 25000, imageName: "fish_1", description: "Cá bảy màu khỏe mạnh", stock: 50),
        Product(name: "Cá Betta Halfmoon", categoryId: UUID(), price: 85000, imageName: "fish_2", description: "Cá betta vây xòe đẹp", stock: 20),
        Product(name: "Thức Ăn Cho Cá 100g", categoryId: UUID(), price: 45000, imageName: "food_1", description: "Dinh dưỡng cao", stock: 100),
        Product(name: "Lọc Vi Sinh Mini", categoryId: UUID(), price: 60000, imageName: "filter_1", description: "Lọc vi sinh cho bể nhỏ", stock: 15)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Sản phẩm nổi bật")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Button("Xem tất cả") {}
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            .padding(.horizontal)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                ForEach(sampleProducts) { product in
                    ProductCardView(product: product)
                }
            }
            .padding(.horizontal)
        }
    }
}
