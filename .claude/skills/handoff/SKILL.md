---
name: handoff
description: Ghi tiến độ phiên hiện tại vào docs/PROGRESS.md để phiên sau tiếp tục được.
disable-model-invocation: true
allowed-tools: Bash(date *)
---
Hôm nay: !`date +%Y-%m-%d`

Cập nhật `docs/PROGRESS.md` (GHI ĐÈ, giữ dưới 60 dòng; tạo mới nếu chưa có) với các mục:
- Đang làm: tính năng gì, đang ở bước nào của kế hoạch.
- Đã xong gần đây: file + 1 dòng giải thích.
- Quyết định đã chốt: mỗi quyết định 1 dòng; đã có file trong `docs/decisions/` thì chỉ ghi link tới file đó.
- Vấn đề còn mở: chỗ chưa chắc, bug chưa sửa.
- Bước tiếp theo: việc cụ thể, theo thứ tự.

Quyết định kiến trúc lớn trong phiên này: tạo file mới trong `docs/decisions/`.
Nếu trong phiên tôi đã phải sửa lại cách bạn làm: đề xuất 1 dòng thêm vào CLAUDE.md
của project và CHỜ tôi duyệt, không tự ghi.

Cuối cùng tóm tắt cho tôi 5 điều quan trọng nhất của phiên này.
