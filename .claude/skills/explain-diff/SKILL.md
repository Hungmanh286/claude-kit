---
name: explain-diff
description: Giải thích các thay đổi code chưa commit để tôi hiểu trước khi commit. Dùng khi tôi muốn review, hiểu code vừa viết, hoặc hỏi "giải thích thay đổi".
---
## Thay đổi chưa commit
!`git diff HEAD --stat 2>/dev/null`
!`git diff HEAD 2>/dev/null | head -800`

Nếu phần trên trống (ví dụ repo chưa có commit), tự chạy `git status` và `git diff` để xem.
Nếu diff bị cắt vì quá dài, dựa vào --stat và đọc trực tiếp các file quan trọng nhất.

Giải thích cho tôi:
- Từng file: thay đổi gì, vì sao cần.
- Luồng chạy sau thay đổi (dữ liệu đi qua những đâu).
- 2-3 chỗ dễ lỗi nhất và cách test chúng.
- Khái niệm nào tôi nên tìm hiểu thêm để tự viết được đoạn này.
