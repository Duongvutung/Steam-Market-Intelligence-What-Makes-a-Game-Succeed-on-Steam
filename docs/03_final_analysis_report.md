# Steam Market Intelligence: Báo cáo Phân tích Tổng quan Thị trường Game (2025)

## 1. Tổng quan dự án (Project Overview)
Dự án Steam Market Intelligence thực hiện phân tích toàn diện bộ dữ liệu gồm 71,429 tựa game trên nền tảng Steam nhằm giải mã các yếu tố quyết định sự thành công của một tựa game, từ chiến lược định giá, thể loại, cho đến mức độ tương tác của cộng đồng.

## 2. Kiến trúc & Phương pháp luận (Pipeline & Methodology)
* **Quy trình End-to-End chuẩn Data Analyst:**
  * **Phase 1 (Excel):** Kiểm toán dữ liệu (Data Auditing), làm sạch bảng tính, chuẩn hóa workbook 7 sheet gồm cấu trúc bảng, lookup reference và dashboard tương tác KPI.
  * **Phase 2 (SQL):** Xây dựng cơ sở dữ liệu SQLite (`steam_database.db`) và viết toàn bộ các file truy vấn độc lập từ `bq01` đến `bq12` để bóc tách thông tin cốt lõi.
  * **Phase 3 (Python & Visualization):** Tự động hóa trích xuất dữ liệu từ các file `.sql` thông qua module trung gian, sử dụng `Matplotlib` và `Seaborn` để trực quan hóa đa chiều các biểu đồ phân tích.

## 3. Các Insight Chính từ Kết quả Phân tích (Key Insights)
* **Xu hướng thị trường (BQ1):** Số lượng game phát hành mới tăng trưởng mạnh mẽ và bùng nổ từ giai đoạn 2014-2015 trở đi, phản ánh sự hạ thấp rào cản gia nhập thị trường nhưng đi kèm với mức độ cạnh tranh khốc liệt.
* **Phân khúc giá & Mô hình (BQ3 & BQ6):** Phần lớn các tựa game tập trung vào các dải giá thấp hoặc mô hình miễn phí (`Free-to-Play`) nhằm thu hút lượng người dùng lớn, trong khi các game trả phí cao đòi hỏi chất lượng nội dung khắt khe và yêu cầu cao từ cộng đồng.
* **Thể loại & Tương tác (BQ2 & BQ4):** Các thể loại Indie, Action, Casual, và Adventure đóng vai trò áp đảo về số lượng đầu game, tuy nhiên các siêu phẩm bom tấn dẫn dắt tổng lượng review thường thuộc về các nhà phát hành lớn với chiến lược cộng đồng dài hạn.

## 4. Tổng kết & Hướng phát triển
Dự án đã hoàn thiện toàn bộ các mốc từ kiểm toán đến truy vấn cơ sở dữ liệu và trực quan hóa nâng cao, sẵn sàng đóng gói đưa lên GitHub Portfolio chính thức.