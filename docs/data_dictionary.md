# Từ điển dữ liệu

## Phạm vi

Dữ liệu nguồn gồm 71.429 bản ghi và 21 cột.
Không phát hiện Null bằng pandas. Một số trường sử dụng
danh sách rỗng hoặc giá trị 0 để biểu diễn thông tin chưa có.

| Cột | Kiểu nguồn | Ý nghĩa và quy tắc sử dụng |
|---|---|---|
| steam_appid | int64 | Mã định danh sản phẩm. Không thiếu, không trùng; dùng làm khóa. |
| name | object | Tên sản phẩm; giữ ký tự Unicode. |
| developers | object | Chuỗi danh sách đơn vị phát triển. Tách mảng, chuẩn hóa khoảng trắng, bỏ phần tử rỗng và trùng. |
| publishers | object | Chuỗi danh sách đơn vị phát hành. Xử lý tương tự developers. |
| categories | object | Chuỗi danh sách tính năng hoặc phân loại. Tách mảng, bỏ phần tử rỗng và trùng sau chuẩn hóa. |
| genres | object | Chuỗi danh sách nhãn, gồm thể loại game và các loại nhãn khác. Dùng quy tắc đã ghi trong audit để xác định phạm vi sản phẩm. |
| required_age | int64 | Trùng hoàn toàn với metacritic trong nguồn. Không sử dụng để phân tích độ tuổi. |
| n_achievements | int64 | Số achievements được ghi nhận. Không có giá trị âm; giữ giá trị cực đoan và ưu tiên trung vị. |
| platforms | object | Chuỗi danh sách hệ điều hành hỗ trợ. Tách mảng, chuẩn hóa và loại phần tử trùng. |
| is_released | bool | Cờ trạng thái phát hành. Phân tích sau phát hành dùng nhóm True. |
| release_date | object | Ngày dạng YYYY-MM-DD hoặc YYYY-MM-DD HH:MM:SS; nhóm chưa phát hành ghi Not Released. Chuyển thành datetime trong dữ liệu xử lý. |
| additional_content | object | Chuỗi danh sách tên nội dung bổ sung. Giữ tên trùng vì chưa có mã định danh để xác minh từng mục. |
| total_reviews | int64 | Tổng review; đã xác nhận bằng total_positive + total_negative. Giữ giá trị 0 khi phân tích độ phủ. |
| total_positive | int64 | Số review tích cực. Không phát hiện giá trị âm. |
| total_negative | int64 | Số review tiêu cực. Không phát hiện giá trị âm. |
| review_score | float64 | Mã phân loại có thứ tự. Mã 0 đi cùng nhãn chưa có review hoặc 1–9 review. Không tính trung bình mã điểm. |
| review_score_desc | object | Nhãn đánh giá hoặc thông báo số review khi chưa có nhãn tổng hợp. Dùng cùng review_score để diễn giải. |
| positive_percentual | float64 | Phần trăm tích cực trên thang 0–100. Với sản phẩm có review, sai lệch tối đa so với tỷ lệ tính lại là 0,05 điểm phần trăm. Phân tích sử dụng positive_ratio tính từ số review. |
| metacritic | int64 | Trường điểm mang tên Metacritic, phạm vi quan sát 0–97. Tạm xem 0 là chưa có điểm sử dụng được; ý nghĩa và nguồn gốc cần xác minh thêm. |
| is_free | bool | Cờ miễn phí được ghi nhận. Dùng phân nhóm mô hình, đồng thời kiểm tra độ nhạy với các bản ghi bất nhất về giá. |
| price_initial (USD) | float64 | Giá USD theo tên trường nguồn. Chưa xác minh được thời điểm giá hoặc liệu đây có phải giá ra mắt. Không có giá âm; giá 0 được phân biệt với cờ is_free. |

## Biến và quy tắc phân tích

| Biến hoặc quy tắc | Định nghĩa |
|---|---|
| positive_ratio | total_positive / total_reviews, thang 0–1; để thiếu khi total_reviews = 0. |
| Ngưỡng xếp hạng tỷ lệ | Chỉ xếp hạng khi total_reviews >= 50. |
| release_year | Năm trích xuất từ ngày đã chuyển đổi. |
| Dải giá | Giá bằng 0; Low (>0–5); Mid (>5–15); High (>15–30); Premium (>30), đơn vị USD. |
| Mẫu game chính | Đã phát hành, có nhãn thuộc game_labels và không có nhãn thuộc non_game_labels; hiện gồm 56.788 sản phẩm. |
| Nhóm ngoài mẫu chính | Giữ cờ riêng cho phần mềm/video, nhãn giao thoa và chưa xác định. |
| So sánh Free/Paid | Phân nhóm theo is_free; đối chiếu kết quả khi loại các bản ghi bất nhất giữa cờ và giá. |

## Giới hạn cần giữ trong báo cáo

- Review được sử dụng làm chỉ số đại diện cho độ phủ và
  sự đón nhận; dữ liệu chưa cung cấp doanh thu hoặc số người chơi.
- Ý nghĩa giá trị 0 của metacritic và nguồn gốc trường điểm cần được xác minh thêm.
- Cách phân loại sản phẩm dựa trên nhãn có thể gây sai lệch phạm vi mẫu.
- Ngày phát hành lớn nhất là 23/01/2025; số liệu năm 2025 không đại diện cho một năm đầy đủ.