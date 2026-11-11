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

## 6. Kiểm toán giá và cờ miễn phí

Không phát hiện giá âm trong trường price_initial (USD).
Giá dao động từ 0 đến 999,98 USD; trung bình đạt 6,53 USD,
trong khi trung vị là 2,99 USD. Chênh lệch giữa trung bình
và trung vị cho thấy phân phối giá lệch về phía các giá trị cao.

Trong nhóm đã phát hành, 740 game có is_free = False nhưng
giá bằng 0; 3 game có is_free = True nhưng giá dương. Do đó, không thể sử dụng điều kiện giá bằng 0 để thay thế
hoàn toàn cho cờ miễn phí.

Các trường hợp bất thường nhất được giữ nguyên để kiểm tra. Giá cao không nên coi là lỗi và chỉ là 1 điểm lưu ý và chưa bị loại khỏi dữ liệu. Việc phân nhóm theo mô hình miễn phí/trả phí cần được phân biệt với phân nhóm theo giá niêm yết.

Trong 58.041 sản phẩm đã phát hành, 743 bản ghi (1,28%) có
thông tin giá và cờ miễn phí không nhất quán. Cụ thể, 740 bản ghi có is_free = False và giá bằng 0, còn 3 bản ghi có
is_free = True và giá dương.

Phân tích mô hình miễn phí và trả phí sẽ phân nhóm theo
is_free như được ghi nhận trong dữ liệu. Phân tích dải giá
sẽ dùng price_initial (USD) và gọi riêng nhóm 0 USD là
“Giá bằng 0”. Khi so sánh hai mô hình, kết quả sẽ được
đối chiếu giữa mẫu đầy đủ và mẫu loại 743 bản ghi bất nhất.

Trong nhóm đã phát hành, mức giá cao nhất là 999,98 USD,
cao hơn mức cao thứ 2 tới 699,99 USD. Một số tên sản phẩm trong nhóm giá cao gợi ý khả năng bộ dữ liệu có cả phần mềm. Các mức giá này được giữ lại trong kiểm toán. Phạm vi
sản phẩm cần được xác định trước khi diễn giải phân phối
giá của thị trường game.

## 7. Phạm vi sản phẩm phân tích

Trong 58.041 sản phẩm đã phát hành, 56.788 sản phẩm có ít nhất
một nhãn game và không có nhãn phần mềm/video thuộc danh sách
kiểm tra. Có 707 sản phẩm chỉ mang nhãn phần mềm/video,
158 sản phẩm mang cả hai nhóm nhãn và 388 sản phẩm chưa được
xác định bằng các danh sách này.

Mẫu phân tích chính được giới hạn ở 56.788 sản phẩm thuộc
nhóm nhãn game, tương đương 97,84% số sản phẩm đã phát hành.
Ba nhóm còn lại được giữ trong dữ liệu xử lý và có cờ phân
nhóm để truy vết.

Quy tắc nhận diện dựa trên các nhãn hiện có trong trường
genres. Một số nhãn như Indie, Casual và Simulation xuất hiện
cùng nhãn phần mềm, cho thấy khả năng phân loại sản phẩm bằng
genre còn hạn chế. Do đó, phạm vi nghiên cứu được hiểu là
mẫu game xác định theo quy tắc nhãn của project.

Danh sách nhãn được lưu trong notebook tại game_labels và
non_game_labels. Các thay đổi đối với hai danh sách cần được
ghi nhận và đánh giá lại số lượng sản phẩm trong từng nhóm.

## 8. Cấu trúc các trường dạng danh sách

Trên toàn bộ 71.429 bản ghi, sáu trường dạng danh sách đều
chuyển đổi thành công và chỉ chứa phần tử kiểu chuỗi.

Phát hiện phần tử rỗng tại 1 bản ghi developers và 6 bản ghi
publishers. Phần tử trùng xuất hiện tại 53 bản ghi developers,
13 bản ghi publishers, 67 bản ghi categories và 8 bản ghi
additional_content. Các số liệu phản ánh số bản ghi gặp từng
vấn đề; một bản ghi có thể được tính ở nhiều nhóm kiểm tra.

Đối với developers, publishers, categories, genres và platforms,
quy trình làm sạch sẽ loại khoảng trắng đầu/cuối, bỏ phần tử
rỗng và loại phần tử trùng sau chuẩn hóa. Thứ tự xuất hiện đầu
tiên được giữ lại. Chữ hoa, chữ thường và ký tự Unicode được
bảo toàn.

Đối với additional_content, các tên trùng được giữ lại do
chưa có mã định danh để xác định chúng thuộc cùng một nội
dung bổ sung. Hạn chế này cần được lưu ý khi tính số lượng
nội dung bổ sung theo tên.

Kiểm tra trùng hiện tại dựa trên chuỗi gốc. Số phần tử trùng
sau chuẩn hóa khoảng trắng sẽ được xác định trong log làm sạch.

Trường positive_percentual nằm trong khoảng 0–100 trên toàn bộ
dữ liệu. Với các sản phẩm có review, sai lệch tuyệt đối lớn nhất
so với tỷ lệ tính từ total_positive / total_reviews × 100 là
0,05 điểm phần trăm, phù hợp với khả năng làm tròn.

Toàn bộ 26.812 sản phẩm có tổng review bằng 0 được ghi nhận
positive_percentual = 0. Khi xây dựng biến phân tích, tỷ lệ
tích cực của nhóm này sẽ được biểu diễn bằng giá trị thiếu.
Biến positive_ratio sẽ được tính trực tiếp từ số review và
lưu trên thang 0–1.

### Mã và nhãn đánh giá người dùng

Các giá trị review_score từ 1 đến 9 tương ứng với những
nhãn đánh giá có thứ tự, từ Overwhelmingly Negative đến
Overwhelmingly Positive. Trường này được sử dụng như biến
phân loại có thứ tự; không tính trung bình các mã để đại diện
cho mức độ hài lòng.

Mã 0 xuất hiện cùng nhãn No user reviews và các nhãn ghi nhận
từ 1 đến 9 review. Nhóm này được diễn giải là chưa có nhãn
đánh giá tổng hợp trong dữ liệu.

Phân tích tỷ lệ tích cực sử dụng positive_ratio tính trực tiếp
từ số review. Các bảng xếp hạng áp dụng ngưỡng tối thiểu
50 review đã xác định trong phương pháp.

### Điểm Metacritic

Trường metacritic có giá trị từ 0 đến 97 và không ghi nhận
giá trị ngoài khoảng 0–100. Có 2.523 sản phẩm mang điểm dương,
chiếm khoảng 3,53% toàn bộ dữ liệu; 68.906 sản phẩm có giá trị 0.

Project tạm xem giá trị 0 là chưa có điểm sử dụng được.
Đây là lựa chọn phương pháp cần được đối chiếu với mô tả
nguồn trước khi hoàn thiện data dictionary. Các phân tích
Metacritic chỉ sử dụng điểm dương, báo cáo số quan sát và
giới hạn về độ bao phủ. Kết quả của nhóm có điểm không được
suy rộng trực tiếp cho toàn bộ mẫu nghiên cứu.