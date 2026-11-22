#!/usr/bin/env bash
# =====================================================================
# claude-kit installer — CHỈ áp dụng trong 1 thư mục bạn chọn.
#
#   ./install.sh <thư-mục-làm-việc>      ví dụ: ./install.sh ~/work
#
# Không ghi gì vào ~/.claude. Script thêm 1 hàm `claude` vào file rc
# của shell: khi bạn gõ `claude` bên trong thư mục đó (hoặc thư mục con),
# nó tự chạy `claude --add-dir <claude-kit>` để nạp skill, agent và
# quy tắc chung. Ở ngoài thư mục đó, `claude` chạy như bình thường.
# Chạy lại để đổi thư mục; chạy với --uninstall để gỡ.
# =====================================================================
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLAUDE_DIR="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"
TS="$(date +%Y%m%d-%H%M%S)"
START="# >>> claude-kit >>>"
END="# <<< claude-kit <<<"

case "$(basename "${SHELL:-bash}")" in
  zsh) RC="$HOME/.zshrc" ;;
  *)   RC="$HOME/.bashrc" ;;
esac

# --- Gỡ bản cài toàn cục cũ (symlink/import trong ~/.claude), nếu có ---
cleanup_global() {
  local f t
  for f in "$CLAUDE_DIR"/skills/* "$CLAUDE_DIR"/agents/*; do
    [ -L "$f" ] || continue
    t="$(readlink "$f")"
    case "$t" in "$KIT_DIR"/*) rm "$f"; echo "• gỡ symlink toàn cục: $f" ;; esac
  done
  local md="$CLAUDE_DIR/CLAUDE.md"
  if [ -f "$md" ] && grep -qE "claude-kit" "$md"; then
    cp "$md" "$md.bak-$TS"
    sed -i '/<!-- claude-kit:start -->/,/<!-- claude-kit:end -->/d' "$md"
    sed -i '/^# claude-kit (quy tắc chung, sửa trong repo)$/d' "$md"
    sed -i "\#^@.*/claude-kit/user/CLAUDE.md\$#d" "$md"
    echo "• gỡ quy tắc claude-kit khỏi $md (backup: $md.bak-$TS)"
  fi
}

remove_block() {
  [ -f "$RC" ] || return 0
  if grep -qF "$START" "$RC"; then
    sed -i "/^$START\$/,/^$END\$/d" "$RC"
  fi
}

cleanup_global

if [ "${1:-}" = "--uninstall" ]; then
  remove_block
  echo "✓ Đã gỡ claude-kit khỏi $RC. Mở terminal mới (hoặc: unset -f claude)."
  exit 0
fi

if [ -z "${1:-}" ]; then
  echo "Cách dùng: $0 <thư-mục-làm-việc>   |   $0 --uninstall" >&2
  exit 1
fi

mkdir -p "$1"
WS="$(cd "$1" && pwd)"

remove_block
touch "$RC"
cat >> "$RC" <<RCEOF
$START
# claude-kit chỉ bật khi chạy claude bên trong: $WS
claude() {
  case "\$PWD/" in
    "$WS/"*)
      CLAUDE_CODE_ADDITIONAL_DIRECTORIES_CLAUDE_MD=1 \\
        command claude --add-dir "$KIT_DIR" "\$@" ;;
    *)
      command claude "\$@" ;;
  esac
}
$END
RCEOF

echo "✓ claude-kit: $KIT_DIR"
echo "✓ Chỉ áp dụng trong: $WS"
echo "✓ Đã thêm hàm claude vào $RC"
echo
echo "Chạy ngay:  source $RC"
echo "Project mới: cd $WS/<project> && claude  →  /bootstrap"
