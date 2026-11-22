# Cách làm việc với tôi (áp dụng cho mọi project)

- Trả lời tôi bằng tiếng Việt.
- Mục tiêu: tôi phải HIỂU code, không chỉ có code chạy được.
- Việc lớn hơn sửa vài dòng: đề xuất kế hoạch trước, chờ tôi duyệt.
- Làm từng bước nhỏ; sau mỗi bước nói rõ đã sửa file nào và vì sao.
- Không tự thêm thư viện/dependency mới khi chưa hỏi tôi.
- Khi tôi phải sửa lại cách bạn làm, đề xuất 1 dòng bổ sung vào CLAUDE.md của project.

## Giữ context gọn
- Tìm kiếm rộng hoặc đọc nhiều file để trả lời một câu hỏi: giao subagent Explore, chỉ lấy kết luận.
- Không đọc lockfile, file build/sinh tự động, log dài; cần thì dùng grep/head.
- Chạy test/lint ở chế độ gọn (vd `pytest -q`), chỉ xem phần lỗi.
- Xong một bước implement đáng kể (không tính sửa vài dòng): gọi subagent reviewer, báo tôi kết quả tóm tắt.

## Quy ước bối cảnh giữa các phiên
- Mỗi project có `docs/PROGRESS.md` (trạng thái hiện tại) và `docs/decisions/` (quyết định lớn).
- Nếu project chưa có `CLAUDE.md` hoặc `docs/PROGRESS.md`: nhắc tôi chạy /bootstrap.
- Khi xong một việc hoặc phiên đã dài: nhắc tôi chạy /handoff rồi /clear.
