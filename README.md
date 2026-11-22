# claude-kit

Bộ khung Claude Code: quy tắc làm việc (`CLAUDE.md`), skill `/bootstrap`,
`/catchup`, `/handoff`, `/explain-diff` và subagent `reviewer`.

Kit **chỉ được bật trong một thư mục bạn chọn**, không ghi gì vào `~/.claude`.

## Cài trên server

```bash
git clone <url-repo> ~/claude-kit
~/claude-kit/install.sh ~/work        # thay ~/work bằng thư mục của bạn
source ~/.bashrc                      # dùng zsh thì: source ~/.zshrc
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

- Trong lúc làm, Claude tự gọi subagent `reviewer` sau mỗi bước implement đáng kể
  (review chạy trong context riêng, chỉ ~15 dòng kết quả quay về phiên chính).
- Gõ `/context` bất cứ lúc nào để xem cái gì đang chiếm context.

## Project Python dùng uv

Nếu project quản lý bằng [uv](https://docs.astral.sh/uv/) thì tạo khung uv trước
(để có `pyproject.toml`), rồi mới chạy `/bootstrap`:

```bash
cd ~/work/du-an-moi
uv init          # bỏ qua nếu đã có pyproject.toml / uv.lock
claude
/bootstrap
```

`/bootstrap` đọc `pyproject.toml` và thấy `uv.lock` trong thư mục, nên sẽ ghi
lệnh uv vào mục "Lệnh" trong `CLAUDE.md` của project, ví dụ:

| Việc                     | Lệnh uv                  | Thay cho                          |
|--------------------------|--------------------------|-----------------------------------|
| Cài đặt                  | `uv sync`                | `pip install -r requirements.txt` |
| Chạy                     | `uv run python main.py`  | `python main.py`                  |
| Test                     | `uv run pytest`          | `pytest`                          |
| Thêm thư viện            | `uv add <tên>`           | `pip install <tên>`               |
| Thêm thư viện chỉ cho dev | `uv add --dev <tên>`    | (ghi tay vào requirements-dev)    |

Lưu ý:
- `uv run` tự dùng `.venv` của project, nên không cần `source .venv/bin/activate`.
- Commit cả `pyproject.toml` và `uv.lock`, đưa `.venv/` vào `.gitignore`.
- Nếu Claude vẫn dùng `pip`, kiểm tra mục "Lệnh" trong `CLAUDE.md` của project
  đã ghi lệnh uv chưa.

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

Khi viết skill có lệnh `` !`...` `` (chạy trước, kết quả chèn vào prompt):
- Khai báo lệnh trong `allowed-tools`, nếu không skill bị huỷ khi chạy ngoài auto mode.
- Lệnh có thể lỗi (vd `git diff HEAD` khi repo chưa có commit) phải thêm
  `|| echo "..."`, vì lệnh thoát với mã ≥ 2 sẽ huỷ cả skill.
