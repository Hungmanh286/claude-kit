# claude-kit

Bộ khung Claude Code: quy tắc làm việc (`CLAUDE.md`), skill `/bootstrap`,
`/catchup`, `/handoff`, `/explain-diff` và subagent `reviewer`.

Kit **chỉ được bật trong một thư mục bạn chọn**, không ghi gì vào `~/.claude`.

## Cài trên server

```bash
git clone <url-repo> ~/claude-kit
~/claude-kit/install.sh ~/work        # thay ~/work bằng thư mục của bạn
source ~/.bashrc
```

Khi gõ `claude` trong `~/work` hoặc thư mục con, hàm shell tự chạy
`claude --add-dir ~/claude-kit` kèm biến
`CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1`, nên Claude nạp:

- `.claude/skills/*` và `.claude/agents/*` của kit
- `CLAUDE.md` của kit (quy tắc chung)

Ngoài thư mục đó, `claude` chạy như bình thường.

## Dùng

```bash
cd ~/work/du-an-moi && claude
/bootstrap
```

Mỗi phiên: `/catchup` → làm việc → `/explain-diff` → commit → `/handoff` → `/clear`

## Đổi thư mục / gỡ

```bash
~/claude-kit/install.sh ~/thu-muc-khac   # thay thư mục
~/claude-kit/install.sh --uninstall      # gỡ hẳn
```

## Cập nhật

Sửa trong repo, commit, push; máy khác `git pull`. Không cần cài lại.
Mở phiên Claude Code mới để nhận thay đổi.

## Cấu trúc

```
CLAUDE.md                     quy tắc chung
.claude/skills/<tên>/SKILL.md mỗi thư mục là một lệnh /<tên>
.claude/agents/*.md           subagent
install.sh                    bật kit cho 1 thư mục
```
