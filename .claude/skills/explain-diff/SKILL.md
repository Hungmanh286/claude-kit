---
name: explain-diff
description: Giải thích các thay đổi code chưa commit để tôi hiểu trước khi commit. Dùng khi tôi muốn review, hiểu code vừa viết, hoặc hỏi "giải thích thay đổi".
allowed-tools: Bash(git status *), Bash(git diff *)
---
## File đã đổi (`??` = file mới chưa `git add`)
!`git status --short --untracked-files=all 2>/dev/null | head -40`

## Thống kê so với commit gần nhất
!`git diff HEAD --stat 2>/dev/null || echo "(chưa có commit nào: mọi file ở danh sách trên đều là mới)"`

## Nội dung diff (bỏ lockfile, tối đa 400 dòng)
!`git diff HEAD -- . ':!*.lock' ':!package-lock.json' ':!pnpm-lock.yaml' 2>/dev/null | head -400`

## Cách đọc phần trên
- Cả 3 phần đều trống: báo tôi không có thay đổi nào rồi dừng.
- File `??` không có trong diff: đọc trực tiếp file đó.
- Diff đủ 400 dòng (có thể bị cắt): dựa vào phần thống kê, chỉ đọc thêm các file quan trọng nhất.
- Lockfile: không đọc; chỉ nói thư viện nào được thêm/đổi (xem pyproject.toml, package.json...).

Giải thích cho tôi:
- Từng file: thay đổi gì, vì sao cần.
- Luồng chạy sau thay đổi (dữ liệu đi qua những đâu).
- 2-3 chỗ dễ lỗi nhất và cách test chúng.
- Khái niệm nào tôi nên tìm hiểu thêm để tự viết được đoạn này.
