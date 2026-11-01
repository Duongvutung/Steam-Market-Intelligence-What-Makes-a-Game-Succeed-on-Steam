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