---
name: bootstrap
description: Khởi tạo bộ khung làm việc cho project (CLAUDE.md, docs/PROGRESS.md, docs/ARCHITECTURE.md, docs/decisions/). Dùng cho project mới hoặc project chưa có các file này.
disable-model-invocation: true
---
# Bootstrap project

## Hiện trạng thư mục
!`ls -la`
!`git log --oneline -5 2>/dev/null || echo "(chưa có git hoặc chưa có commit)"`

## Việc cần làm
KHÔNG sửa code ứng dụng. Chỉ tạo hoặc cập nhật các file dưới đây.

1. **Khám phá.** Xác định stack, lệnh cài đặt/chạy/test/lint, cấu trúc thư mục, entry point
   (đọc README và các file như package.json, pyproject.toml, requirements.txt, go.mod,
   Dockerfile, docker-compose.yml, Makefile). Project lớn thì giao cho subagent Explore.
   Nếu thư mục gần như trống: hỏi tôi định xây gì, dùng stack gì, rồi mới làm tiếp.

2. **CLAUDE.md** ở gốc project theo Mẫu A, dưới 80 dòng.
   - Đã có CLAUDE.md: giữ nội dung cũ, chỉ bổ sung mục còn thiếu.
   - Có AGENTS.md nhưng chưa có CLAUDE.md: tạo CLAUDE.md có dòng đầu tiên là @AGENTS.md
     (không bọc trong dấu backtick), bên dưới chỉ thêm những gì AGENTS.md chưa có.
   - Không lặp lại các quy tắc chung của claude-kit (đã được nạp sẵn trong phiên).
   - Thông tin không chắc chắn thì ghi "TODO: xác nhận", không đoán.

3. **docs/ARCHITECTURE.md** theo Mẫu B, chỉ ghi những gì đọc được từ code, ngắn gọn.

4. **docs/PROGRESS.md** theo Mẫu C, mục "Đang làm" ghi: Vừa khởi tạo khung project.

5. **docs/decisions/README.md**: vài dòng giải thích quy ước đặt tên
   `NNN-ten-quyet-dinh.md` và chép Mẫu D vào.

6. **.gitignore**: thêm dòng `CLAUDE.local.md` nếu chưa có (tạo .gitignore nếu chưa có).

7. **Báo cáo cho tôi**: danh sách file đã tạo/sửa, và tối đa 5 câu hỏi về các mục TODO.

---

## Mẫu A — CLAUDE.md
```markdown
# <Tên project>

## Tổng quan
- Mục đích: <1-2 câu>
- Stack: <ngôn ngữ, framework, DB, hạ tầng>
- Kiến trúc: `docs/ARCHITECTURE.md` (đọc khi cần)
- Tiến độ hiện tại: `docs/PROGRESS.md`

## Lệnh
- Cài đặt: <lệnh>
- Chạy dev: <lệnh>
- Test: <lệnh>
- Lint/format: <lệnh>

## Cấu trúc thư mục chính
- `<thư mục>/`: <vai trò>

## Quy ước code
- <rút ra từ code hiện có>

## Lưu ý riêng
- <cạm bẫy, phần nhạy cảm nên dùng plan mode>
```

## Mẫu B — docs/ARCHITECTURE.md
```markdown
# Kiến trúc

## Thành phần chính
## Luồng chạy chính (request/job đi qua những đâu)
## Dữ liệu và lưu trữ
## Phụ thuộc bên ngoài (API, dịch vụ, queue...)
```

## Mẫu C — docs/PROGRESS.md
```markdown
# Tiến độ (cập nhật: YYYY-MM-DD)

## Đang làm
## Đã xong gần đây
## Quyết định đã chốt
## Vấn đề còn mở
## Bước tiếp theo
```

## Mẫu D — docs/decisions/NNN-ten.md
```markdown
# NNN: <Tên quyết định>
- Ngày:
- Bối cảnh:
- Quyết định:
- Lý do / phương án đã loại:
- Hệ quả:
```
