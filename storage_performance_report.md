# Báo cáo Đánh đổi Hiệu năng & Dung lượng lưu trữ (Storage & Performance Trade-off)

## 1. Kết quả đo lường dung lượng
- **Trước khi tạo Index:** Dung lượng `Index_Size_KB` là 0 KB.
- **Sau khi tạo các Index:** Dung lượng `Index_Size_KB` tăng lên tương ứng với số lượng Index được tạo.

## 2. Phân tích sự đánh đổi (Trade-off)
- **Ưu điểm (Read Performance):** Giúp các truy vấn tìm kiếm (`SELECT`) chạy nhanh hơn rất nhiều, giảm số lượng hàng phải duyệt (`rows`) từ hàng chục nghìn xuống còn 1.
- **Nhược điểm (Write & Storage Cost):** 
  - Chiếm thêm dung lượng bộ nhớ/đĩa cứng để lưu trữ các bảng chỉ mục.
  - Làm chậm các thao tác ghi dữ liệu (`INSERT`, `UPDATE`, `DELETE`) vì MySQL phải cập nhật lại danh sách Index mỗi khi dữ liệu thay đổi.

## 3. Lý do xóa các Index không cần thiết
- Xóa các Index trùng lặp hoặc ít khi dùng trong truy vấn `WHERE` để tiết kiệm tài nguyên bộ nhớ.
- Tối ưu tốc độ ghi cho hệ thống đối với các bảng có tần suất cập nhật dữ liệu cao.