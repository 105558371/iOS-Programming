import Foundation

enum OrderStatus: String, CaseIterable {
    case pending = "Chờ xử lý"
    case preparing = "Đang chuẩn bị"
    case shipping = "Đang giao"
    case delivered = "Đã giao"
    case cancelled = "Đã hủy"
}
