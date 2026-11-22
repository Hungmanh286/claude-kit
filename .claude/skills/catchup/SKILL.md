---
name: catchup
description: Nạp lại bối cảnh project khi bắt đầu phiên mới, từ docs/PROGRESS.md và trạng thái git.
disable-model-invocation: true
allowed-tools: Bash(git status *), Bash(git log *), Bash(cat docs/PROGRESS.md)
---
## Trạng thái git
!`git status --short 2>/dev/null | head -30`
!`git log --oneline -10 2>/dev/null || echo "(chưa có commit)"`

## docs/PROGRESS.md
!`cat docs/PROGRESS.md 2>/dev/null || echo "(KHÔNG CÓ FILE)"`

Nếu phần trên là "(KHÔNG CÓ FILE)": báo project chưa được bootstrap, gợi ý tôi chạy /bootstrap, rồi dừng.

Nếu có:
1. Tóm tắt cho tôi trong tối đa 5 dòng: đang ở đâu, bước tiếp theo là gì.
2. Nếu git cho thấy có thay đổi chưa được ghi trong PROGRESS.md, chỉ ra.
3. Liệt kê điểm chưa rõ cần tôi xác nhận.
Chưa sửa code. Chỉ đọc thêm file khác (ARCHITECTURE.md, code) khi cần để trả lời mục 1-3.
