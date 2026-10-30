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

Từ kết quả chạy thực tế trên toàn bộ 71,429 game:
- **Game có đúng 0 review:** 26,817 game (chiếm 37.54% toàn sàn) -> Hơn 1/3 số game đưa lên Steam gần như không có bất kỳ tương tác nào.
- **Game đạt chuẩn >= 50 reviews:** 11,568 game (chỉ chiếm 16.20%) -> Số game đủ dữ liệu tin cậy để đánh giá chất lượng là rất ít.
- **Game nhiều review nhất:** 1,279,700 reviews.
- **Trung vị (Median) = 2.0 reviews** trong khi **Trung bình (Mean) = 410.2 reviews**.

## 3. Kiểm toán Phân phối Giá tiền (`price_initial (USD)`)
Từ kết quả kiểm tra thực tế:
- **Tỷ lệ Free vs Trả phí:**
  - Game Miễn phí ($0.00): 22,434 game (chiếm 31.41%)
  - Game Trả phí (> $0.00): 48,995 game (chiếm 68.59%)
- **Mức giá ngoại lệ:** Thấp nhất $0.00, cao nhất $999.98 (ngoại lệ cực đoan).
- **Độ lệch giá:** 
  - Trung vị (Median) = $2.99
  - Trung bình (Mean) = $6.53
  - Giá trung bình bị thổi phồng bởi một số ít sản phẩm có giá cực đoan. Hơn 50% tựa game trên Steam có giá từ $2.99 trở xuống.
- **Chiến lược giá phổ biến (Top 5):** 
  1. $0.00 (22,434 game - Free-to-Play)
  2. $4.99 (6,752 game)
  3. $9.99 (5,956 game)
  4. $0.99 (5,618 game)
  5. $1.99 (4,195 game)
  -> 100% các mức giá thương mại phổ biến nhất đều sử dụng định giá tâm lý đuôi `.99`.

### Quyết định kỹ thuật:
- Áp dụng phân dải giá chuẩn theo Từ điển Metric: `Free (=0)`, `Low (>0-5)`, `Mid (>5-15)`, `High (>15-30)`, `Premium (>30)`.
- Các game có giá cực đoan (> $200) sẽ được xem xét và xử lý ở bước làm sạch (Phase 1/Phase 3) để tránh bóp méo biểu đồ.

## 4. Kiểm toán Toàn bộ 6 Cột Dạng Mảng (Array Fields Audit)
Kiểm tra thực tế hiện tượng mảng rỗng `[]` trên toàn bộ 71,429 dòng:

| Tên cột mảng | Số game rỗng `[]` | Tỷ lệ rỗng (%) | Số game có dữ liệu | Tỷ lệ có dữ liệu (%) | Đánh giá & Hướng xử lý |
| :--- | :---: | :---: | :---: | :---: | :--- |
| `genres` | 223 | 0.31% | 71,206 | 99.69% | Rất đầy đủ. 223 game thiếu sẽ gán nhãn `'Unknown'` ở bước làm sạch. |
| `categories` | 558 | 0.78% | 70,871 | 99.22% | Tỷ lệ phủ cao, phục vụ phân tích tính năng (Single-player, Co-op). |
| `platforms` | 0 | 0.00% | 71,429 | 100.00% | 100% đầy đủ. Windows chiếm lên với 76.84% game. |
| `developers` | 200 | 0.28% | 71,229 | 99.72% | Rất đầy đủ, phục vụ tốt BQ11 (xếp hạng nhà phát triển). |
| `publishers` | 493 | 0.69% | 70,936 | 99.31% | Đầy đủ, phục vụ đánh giá năng lực phát hành ở BQ11. |
| `additional_content` | 64,266 | 89.97% | 7,163 | 10.03% | Gần 90% game không có DLC. DLC chỉ tập trung ở 10% thiểu số. |

### Phát hiện về Nền tảng (Platforms - Phục vụ BQ3):
- Game chỉ chạy Windows: 54,889 game (76.84%).
- Game hỗ trợ trọn vẹn cả 3 hệ (Windows + Mac + Linux): 7,362 game (10.31%).
- Game chỉ chạy Mac: 21 game (thị phần cực kỳ nhỏ).

### Quyết định kỹ thuật:
- Sử dụng hàm tách mảng an toàn (`ast.literal_eval` + `.explode()`) ở Phase 2 và Phase 3 để chuẩn hóa thành các bảng quan hệ 3NF riêng biệt: `game_genres`, `game_categories`, `game_platforms`, `game_developers`, `game_publishers`.
- Cột `platforms` sẽ được phân nhóm thành 3 nhóm chuẩn: `Chỉ Windows`, `Windows + 1 hệ khác`, và `Cả 3 hệ (Win+Mac+Linux)` theo đúng Từ điển Metric trang 12.

## 5. Kiểm toán Ngày phát hành (`release_date`) & Trạng thái Ra mắt (`is_released`)
- **Tình trạng phát hành (`is_released`):**
  - Game đã phát hành chính thức (`True`): 58,041 game (chiếm 81.26%).
  - Game chưa phát hành / Sắp ra mắt (`False`): 13,388 game (chiếm 18.74%).
- **Kiểm tra định dạng ngày (`release_date`):**
  - Các game chưa phát hành được gán nhãn chuỗi `'Not Released'`.
  - Toàn bộ 58,041 game đã ra mắt đều lưu theo chuẩn ISO `YYYY-MM-DD`. Khi dùng `pd.to_datetime(..., format='mixed', errors='coerce')`, tỷ lệ nhận diện thành công đạt 100% trên tập game đã phát hành.
- **Khảo sát xu hướng phát hành theo thời gian (Sơ bộ BQ1):**
  - Dải năm phát hành: Từ 1997 đến 2025.
  - Top 5 năm phát hành nhiều nhất: 2024 (9,693 game), 2023 (7,903 game), 2021 (7,627 game), 2019 (6,082 game), 2020 (5,093 game).
  - Tốc độ đưa game lên Steam bùng nổ kỷ lục vào giai đoạn 2023–2024.

### Quyết định kỹ thuật:
- Sử dụng `format='mixed'` để chuẩn hóa `release_date`, trích xuất cột `release_year` dạng số nguyên.
- Các dòng `'Not Released'` sẽ mang giá trị `NaT` (hoặc `NULL` trong SQL) và có cờ `is_released = 0`.
- Khi phân tích xu hướng năm (BQ1), chỉ tập trung vào nhóm game đã phát hành chính thức (`is_released == 1`).