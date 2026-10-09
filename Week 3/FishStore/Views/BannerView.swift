import SwiftUI

struct BannerView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(gradient: Gradient(colors: [Color.green.opacity(0.8), Color.blue]), startPoint: .leading, endPoint: .trailing))
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("ƯU ĐÃI THÁNG NÀY")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                    Text("Cá khỏe - Bể đẹp")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Text("Không gian thư giãn\ncho mọi nhà ♡")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                }
                
                Spacer()
                
                VStack {
                    Text("Giảm đến")
                        .font(.caption2)
                        .foregroundColor(.red)
                    Text("30%")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                }
                .padding(10)
                .background(Circle().fill(Color.orange))
            }
            .padding()
        }
        .frame(height: 120)
        .padding(.horizontal)
    }
}
