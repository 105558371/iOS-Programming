import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 16) {
                    HomeHeaderView()
                    SearchBarView()
                    BannerView()
                    CategoryRowView()
                    ProductSectionView()
                }
            }
            .navigationTitle("Cá Cảnh Xinh")
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
