#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPT_FILE="$SCRIPT_DIR/prompt.md"
REPORT_FILE="$SCRIPT_DIR/report.html"

echo "=== Entropy Data Playwright Test ==="
echo "Running Claude Code with YOLO mode and Playwright MCP..."
echo ""

cd "$SCRIPT_DIR"

claude -p \
  --dangerously-skip-permissions \
  --mcp-config "$SCRIPT_DIR/mcp-config.json" \
  --verbose \
  "$(cat "$PROMPT_FILE")"

echo ""
if [ -f "$REPORT_FILE" ]; then
  echo "Test report generated: $REPORT_FILE"
  open "$REPORT_FILE" 2>/dev/null || echo "Open $REPORT_FILE in a browser to view the report."
else
  echo "WARNING: No report file was generated."
  exit 1
fi
