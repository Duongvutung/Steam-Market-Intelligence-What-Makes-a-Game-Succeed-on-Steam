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