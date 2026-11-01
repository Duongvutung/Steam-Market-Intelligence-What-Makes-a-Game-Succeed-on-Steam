# Kiểm toán dữ liệu Steam

## 1. Quy mô và định danh

- 71.429 bản ghi, 21 cột.
- steam_appid: không thiếu, không trùng. Lựa chọn đây là khoá chính.
- Không phát hiện Null bằng pandas trên toàn bộ 21 cột.
- Chưa kết luận dữ liệu đầy đủ vì có các giá trị rỗng dạng chuỗi.

## 2. Các trường dạng danh sách

| Cột | Danh sách rỗng | Tỷ lệ |
|---|---:|---:|
| developers | 200 | 0,28% |
| publishers | 493 | 0,69% |
| categories | 558 | 0,78% |
| genres | 223 | 0,31% |
| platforms | 0 | 0,00% |
| additional_content | 64.266 | 89,97% |

Quyết định hiện tại:
- Giữ nguyên dữ liệu nguồn.
- Chưa xóa dòng hoặc thay danh sách rỗng.
- Phân biệt thiếu thông tin với trường hợp không có nội dung bổ sung.
- Chưa hoàn thành kiểm tra định dạng danh sách.

## 3. Kiểm toán review

Phạm vi: toàn bộ 71.429 game, gồm cả game chưa phát hành.

- Không có giá trị âm trong total_reviews, total_positive, total_negative.
- Xác định đúng total_reviews = total_positive + total_negative.
- 0 review: 26.812 game.
- 1–49 review: 33.049 game.
- Từ 50 review: 11.568 game.
- Trung bình: 410,25 review; trung vị: 2.00 review.

Diễn giải:
- Phân phối review lệch mạnh; trung bình không đại diện tốt cho mức review của một game điển hình.
- Trung bình 410,25 nhưng trung vị chỉ 2 cho thấy review phân bố rất không đều: những game có lượng review lớn kéo trung bình lên cao. 

Quy tắc cho phân tích sau:
- Giữ game 0 review khi phân tích độ phủ.
- Tỷ lệ tích cực của game 0 review để thiếu, không gán bằng 0%.
- Chỉ xếp hạng tỷ lệ tích cực khi tổng review >= 50.
- Ngưỡng 50 là lựa chọn phương pháp, không phải ngưỡng thành công.
- Phải tách game đã/chưa phát hành trước khi diễn giải độ phủ.

## 4. Review theo trạng thái phát hành

Toàn bộ 13.388 game được ghi nhận chưa phát hành đều có
0 review. Trong nhóm 58.041 game đã phát hành, 13.424 game
không có review, tương đương 23,13%, 11.568 game đạt từ
50 review trở lên, chiếm 19,93%. Trung vị của nhóm đã phát
hành là 5 review, so với 2 review trên toàn bộ dữ liệu.

Kết quả cho thấy việc đưa game chưa phát hành vào mẫu làm
tăng tỷ lệ không có review và giảm trung vị review. Do đó,
các phân tích về độ phủ sau phát hành sẽ giới hạn ở nhóm
is_released = True. Nhóm chưa phát hành vẫn được giữ trong
dữ liệu nguồn và được báo cáo riêng khi cần.

Phân nhóm hiện dựa trên cờ is_released; tính nhất quán với
ngày phát hành cần được kiểm tra trước khi áp dụng bộ lọc.

## 5. Ngày phát hành và tính nhất quán với trạng thái

Trường release_date sử dụng hai định dạng: 28 giá trị dạng
YYYY-MM-DD và 58.013 giá trị dạng YYYY-MM-DD HH:MM:SS.
Sau khi chuyển đổi theo từng định dạng, toàn bộ 58.041 game có is_released = True đều có ngày hợp lệ. Khoảng ngày ghi nhận từ 30/06/1997 đến 23/01/2025.

Toàn bộ 13.388 game có is_released = False mang nhãn
"Not Released". Không phát hiện trường hợp không nhất quán
giữa trạng thái và ngày phát hành theo các điều kiện đã kiểm tra.

Quy tắc xử lý cho bước làm sạch:
- Giữ nguyên release_date trong dữ liệu nguồn.
- Chuyển hai định dạng đã xác định sang kiểu datetime.
- Biểu diễn ngày chưa phát hành bằng NaT, đồng thời giữ cờ
  is_released để phân biệt với ngày không hợp lệ.
- Trích xuất release_year từ ngày đã chuẩn hóa.

Giới hạn:
Khoảng ngày trên phản ánh các giá trị trong bộ dữ liệu,
không xác nhận tính chính xác của từng ngày với nguồn Steam.
Năm 2025 chỉ có ngày phát hành được ghi nhận đến 23/01;
không xem đây là dữ liệu đầy đủ cho cả năm khi so sánh xu hướng.