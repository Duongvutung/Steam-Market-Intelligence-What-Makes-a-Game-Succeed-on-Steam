# Báo cáo Kiểm toán Dữ liệu (Data Audit Report) - Phase 0

## 1. Thông tin quy mô & Khóa chính
- **Tập dữ liệu:** Steam Games Dataset 2025 (Kaggle)
- **Tổng số dòng:** 71,429 dòng
- **Tổng số cột:** 21 cột
- **Kiểm tra trùng lặp `steam_appid`:** 0 dòng trùng (100% Unique - Dùng làm Primary Key)

## 2. Danh sách cột và Tỷ lệ khuyết thiếu sơ bộ
- File gồm 21 cột với các trường thông tin chính: định danh (`steam_appid`, `name`), nhà phát triển/phát hành, phân loại (`genres`, `categories`), nền tảng (`platforms`), giá và lượt đánh giá.
- `df.isnull()` hiển thị 0% Null trên toàn bộ 21 cột, tuy nhiên dữ liệu thiếu thực tế được lưu dưới dạng:
  - Mảng rỗng: `'[]'` (ví dụ ở cột `additional_content`, `genres`...)
  - Giá trị mặc định: `0` (ở các cột `total_reviews`, `total_positive`, `total_negative`)
  - Nhãn placeholder: `'No user reviews'` ở cột `review_score_desc`
- Các cột phân loại (`developers`, `publishers`, `categories`, `genres`, `platforms`) đều lưu dưới dạng chuỗi biểu diễn mảng Python (`"['A', 'B']"`), cần xử lý bóc tách (flatten/explode) ở các phase tiếp theo.