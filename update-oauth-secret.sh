#!/usr/bin/env bash
set -euo pipefail

REPO="entropy-data/entropydata-agentictest"
KEYCHAIN_SERVICE="Claude Code-credentials"
CREDS_FILE="$HOME/.claude/.credentials.json"

echo "=== Update Claude Code OAuth Secret ==="
echo ""

# Read credentials: macOS Keychain first, then filesystem fallback
if [[ "$(uname)" == "Darwin" ]]; then
  CREDS=$(security find-generic-password -s "$KEYCHAIN_SERVICE" -w 2>/dev/null || true)
fi

if [[ -z "${CREDS:-}" ]] && [[ -f "$CREDS_FILE" ]]; then
  CREDS=$(cat "$CREDS_FILE")
fi

if [[ -z "${CREDS:-}" ]]; then
  echo "ERROR: No Claude credentials found."
  echo "Searched: macOS Keychain ('$KEYCHAIN_SERVICE') and $CREDS_FILE"
  echo "Run 'claude login' first to authenticate with your Max plan."
  exit 1
fi

# Extract OAuth token from credentials
OAUTH_TOKEN=$(echo "$CREDS" | python3 -c "
import sys, json
d = json.load(sys.stdin)

# Navigate into claudeAiOauth if present
oauth = d.get('claudeAiOauth', d)
if isinstance(oauth, str):
    print(oauth)
    sys.exit(0)

# Look for the access token within the oauth object
for key in ('accessToken', 'access_token', 'oauthToken', 'token'):
    if key in oauth:
        print(oauth[key])
        sys.exit(0)

# If none matched, dump keys for debugging
top_keys = list(d.keys())
oauth_keys = list(oauth.keys()) if isinstance(oauth, dict) else []
print(f'top-level keys: {top_keys}, oauth keys: {oauth_keys}', file=sys.stderr)
sys.exit(1)
" 2>&1)

if [[ "$OAUTH_TOKEN" == top-level* ]] || [[ -z "$OAUTH_TOKEN" ]]; then
  echo "ERROR: Could not extract OAuth token from credentials."
  echo "$OAUTH_TOKEN"
  exit 1
fi

echo "OAuth token found (${#OAUTH_TOKEN} chars)"
echo "Setting secret CLAUDE_CODE_OAUTH_TOKEN on $REPO..."
echo ""

gh secret set CLAUDE_CODE_OAUTH_TOKEN --repo "$REPO" --body "$OAUTH_TOKEN"

echo ""
echo "Done. Secret CLAUDE_CODE_OAUTH_TOKEN updated on $REPO."
echo "Note: OAuth tokens expire after ~1 day. Re-run this script to refresh."
