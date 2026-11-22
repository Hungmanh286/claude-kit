# Hướng dẫn sử dụng claude-kit

> File này chỉ để người đọc. Claude Code **không** nạp nó vào phiên làm việc:
> kit chỉ nạp `CLAUDE.md` và các thư mục trong `.claude/`. Sửa hay xoá file này
> không ảnh hưởng gì tới kit.

## 0. Chạy ở đâu: terminal hay Claude Code?

| Lệnh | Chạy ở đâu |
|---|---|
| `git clone ...`, `git -C ... pull` | Terminal |
| `install.sh ...` | Terminal |
| `source ~/.bashrc` / `source ~/.zshrc` | Terminal |
| `claude-kit update`, `claude-kit version` | Terminal |
| `claude` (mở Claude Code) | Terminal |
| `/bootstrap`, `/catchup`, `/handoff`, `/explain-diff`, `/clear`, `/context` | **Trong** Claude Code (sau khi gõ `claude`) |

Không chạy các lệnh terminal bên trong Claude Code (dạng `! lệnh`):
- `! source ~/.bashrc` chạy trong một shell con riêng, terminal của bạn không nhận được gì.
- Cập nhật kit xong vẫn phải mở phiên Claude mới mới nhận thay đổi, nên làm ở terminal
  trước khi gõ `claude` là gọn nhất.

---

## 1. Cài trên server mới

Cần có sẵn: `git`, Claude Code đã đăng nhập. Nếu repo GitHub để private thì phải
đăng nhập git trước (ví dụ `gh auth login`).

```bash
git clone https://github.com/Hungmanh286/claude-kit.git ~/claude-kit
~/claude-kit/install.sh ~/work        # ~/work = thư mục muốn bật kit
source ~/.bashrc                      # dùng zsh thì: source ~/.zshrc
claude-kit version                    # kiểm tra
```

`claude-kit version` phải in ra commit hiện tại và dòng `Bật cho thư mục: .../work`.

Bắt đầu một project:

```bash
cd ~/work/du-an-moi
claude
```
```
/bootstrap
```

---

## 2. Server đã cài từ trước khi có lệnh `claude-kit` (làm 1 lần)

Bản cài cũ chưa có lệnh `claude-kit`, nên lần này phải làm tay:

```bash
git -C ~/claude-kit pull --ff-only
~/claude-kit/install.sh ~/work        # đúng thư mục như lúc cài
source ~/.bashrc                      # dùng zsh thì: source ~/.zshrc
claude-kit version
```

Không nhớ đã cài cho thư mục nào:

```bash
grep "claude-kit chỉ bật" ~/.bashrc ~/.zshrc 2>/dev/null
```

Từ đây trở đi chỉ cần `claude-kit update` (mục 3).

---

## 3. Cập nhật kit

### 3.1. Trên máy sửa kit

Sửa file trong repo → commit → `git push`.

### 3.2. Trên mỗi server

1. Trong Claude Code: `/handoff` (lưu tiến độ), rồi thoát (`/exit` hoặc Ctrl+D).
2. Terminal: `claude-kit update`
3. Terminal: `claude`
4. Trong Claude Code: `/catchup`

### 3.3. Đọc kết quả của `claude-kit update`

| Thông báo | Ý nghĩa / việc cần làm |
|---|---|
| `✓ Đã là bản mới nhất` | Không có gì mới. |
| `Thay đổi mới:` + danh sách commit | Đã cập nhật. Mở phiên `claude` mới. |
| `⚠ install.sh đã thay đổi, cần cài lại` | Chạy đúng câu lệnh nó in ra, rồi mở terminal mới. |
| `✗ Có file trong kit bị sửa tay` | Kit không được cập nhật. Xem mục 6. |

`claude-kit update` chỉ cập nhật thẳng (`git pull --ff-only`): không bao giờ tự tạo
merge commit hay ghi đè file bạn đã sửa.

---

## 4. Một phiên làm việc

```
/catchup → làm việc → /explain-diff → commit → /handoff → /clear
```

| Lệnh | Khi nào | Làm gì |
|---|---|---|
| `/bootstrap` | Project mới / chưa có `CLAUDE.md`, `docs/PROGRESS.md` | Tạo khung: `CLAUDE.md`, `docs/PROGRESS.md`, `docs/ARCHITECTURE.md`, `docs/decisions/` |
| `/catchup` | Đầu phiên | Đọc `docs/PROGRESS.md` + git, tóm tắt đang ở đâu, bước tiếp theo |
| `/explain-diff` | Trước khi commit | Giải thích thay đổi chưa commit: từng file, luồng chạy, chỗ dễ lỗi |
| `/handoff` | Cuối phiên | Ghi đè `docs/PROGRESS.md` để phiên sau tiếp tục được |
| `/clear` | Sau `/handoff` | Xoá context, bắt đầu phiên sạch |
| `/context` | Bất cứ lúc nào | Xem cái gì đang chiếm context |

Subagent `reviewer` được Claude tự gọi sau mỗi bước implement đáng kể. Nó review
trong context riêng, chỉ khoảng 15 dòng kết quả quay về phiên chính.

---

## 5. Đổi thư mục / gỡ

```bash
~/claude-kit/install.sh ~/thu-muc-khac   # bật kit cho thư mục khác
~/claude-kit/install.sh --uninstall      # gỡ hẳn
```

Sau đó mở terminal mới (hoặc `source` file rc).

---

## 6. Xử lý sự cố

| Triệu chứng | Nguyên nhân | Cách xử lý |
|---|---|---|
| `claude-kit: command not found` | Chưa `source` file rc, hoặc bản cài cũ | `source ~/.bashrc`; nếu vẫn lỗi, làm lại mục 2 |
| Gõ `/catchup` không có lệnh | Đang đứng ngoài thư mục đã bật kit | `claude-kit version` xem dòng "Bật cho thư mục", `cd` vào đó rồi gõ `claude` |
| `✗ Có file trong kit bị sửa tay` | Có người sửa file trong `~/claude-kit` trên server | `git -C ~/claude-kit status` xem file nào; bỏ thay đổi: `git -C ~/claude-kit checkout -- <file>`; rồi `claude-kit update` lại |
| Cập nhật xong mà Claude vẫn làm theo cách cũ | Phiên Claude đang mở từ trước khi cập nhật | Thoát, gõ `claude` mở phiên mới |
| `git pull` hỏi mật khẩu / lỗi quyền | Repo private, server chưa đăng nhập GitHub | `gh auth login` hoặc dùng SSH key |
