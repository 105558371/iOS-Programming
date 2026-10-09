import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 2) {
                    HStack(spacing: 4) {
                        Text("Cá Cảnh Xinh")
                            .font(.headline)
                            .fontWeight(.bold)
                        Image(systemName: "heart")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    Text("Thế giới thủy sinh trong tầm tay")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: {}) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "bell")
                                .font(.title3)
                                .foregroundColor(.blue)
                            
                            Text("3")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                        }
                    }
                    
                    Button(action: {}) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart")
                                .font(.title3)
                                .foregroundColor(.blue)
                            
                            Text("2")
                                .font(.caption2)
                                .bold()
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: 8, y: -8)
                        }
                    }
                }
            }
            
            HStack(spacing: 4) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(.blue)
                Text("Giao đến:")
                    .font(.caption)
                    .foregroundColor(.gray)
                Text("Phường Trấn Biên, Thành phố Đồng Nai")
                    .font(.caption)
                    .fontWeight(.medium)
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundColor(.blue)
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
