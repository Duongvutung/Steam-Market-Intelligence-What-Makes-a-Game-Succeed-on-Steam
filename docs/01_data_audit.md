# Câu hỏi 1: Quy mô & Trùng lặp: Ghi rõ tổng số dòng, số cột, số lượng mã game trùng lặp.


Danh sách cột & Kiểu dữ liệu: Đối chiếu tên cột thực tế với bản xem trước trên Kaggle.

Tỷ lệ khuyết thiếu (Missing values): Liệt kê % thiếu từng cột và phân biệt giữa NaN thật với mảng rỗng [].

Định dạng các trường mảng: Xác nhận genres, categories, developers, publishers, platforms đang lưu dạng chuỗi giả mảng ['A', 'B'] hay phân tách bằng dấu phẩy.

Kiểm tra trường Giá (Price): Đơn vị tiền tệ, tỷ lệ game giá = 0 (Free-to-Play), giá trị lớn nhất/nhỏ nhất.

Kiểm tra Ngày phát hành (Release Date): Các định dạng ngày xuất hiện, số lượng dòng chứa chữ "Coming soon", "TBA" hoặc năm tương lai.

Kiểm tra Reviews: Xác nhận tên trường review tích cực / tiêu cực, số lượng game có total_reviews = 0.

Trường sở hữu / Thời gian chơi: Xác nhận có tồn tại trong bản tải về hay không để quyết định giữ hay cắt BQ9.

Độ lệch phân phối (Mean vs. Median): Chỉ ra sự chênh lệch lớn giữa trung bình và trung vị của số lượng review và giá để làm cơ sở dùng Trung vị (Median) cho toàn bộ dự án.

Kiểm tra DLC / Demo / Non-game: Xác nhận cách lọc hoặc việc DLC đã được gộp trong từng dòng game.