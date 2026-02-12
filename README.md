# Entropy Data - Agentic E2E Tests

End-to-end test suite for the [Entropy Data](https://demo.entropy-data.com) platform, powered by Claude Code and Playwright MCP.

## How It Works

Claude Code acts as an AI test agent that drives a headless browser via Playwright MCP to execute end-to-end test scenarios defined in `prompt.md`. After execution, it generates an HTML report with screenshots, test results, JavaScript error monitoring, and visual bug detection.

### Test Scenarios

1. **Search & Request Access** - Search for the "orders" data product and request access to an output port
2. **Create Data Contract** - Create a data contract via the editor UI
3. **Databricks Data Product** - Add a data product from Databricks via the wizard

## Local Setup

### Prerequisites

- [Node.js](https://nodejs.org/) v22+
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) (`npm install -g @anthropic-ai/claude-code`)
- A Claude Max/Pro subscription (or an Anthropic API key)

### Running Tests Locally

```bash
# Authenticate with your Claude Max/Pro plan
claude login

# Then run the tests
chmod +x run-test.sh
./run-test.sh
```

The test report will be generated at `report.html` and opened automatically.

## CI/CD Setup (GitHub Actions)

The workflow at `.github/workflows/e2e-tests.yml` runs the tests:

- On every push to `main`
- On every pull request targeting `main`
- Daily at 06:00 UTC (scheduled)
- Manually via workflow dispatch

### Configuring GitHub Secrets

The CI pipeline requires one secret: **`CLAUDE_CODE_OAUTH_TOKEN`** (from your Claude Max/Pro subscription).

#### Automatic setup (recommended)

A helper script is included that reads your local Claude credentials and uploads the OAuth token as a GitHub secret:

```bash
# Make sure you're logged in to both Claude and GitHub CLI
claude login
gh auth login

# Push the token to GitHub
./update-oauth-secret.sh
```

**Important**: OAuth tokens expire after ~1 day. Re-run `./update-oauth-secret.sh` to refresh the token before scheduled CI runs.

#### Manual setup

1. **Log in to Claude Code** locally: `claude login`
2. **Find your OAuth token**:
   - macOS: stored in Keychain under `claude-code-credentials`
   - Linux: stored in `~/.claude/.credentials.json` (the `oauthToken` field)
3. **Add the secret to GitHub**:
   - Go to your repository on GitHub
   - Navigate to **Settings** > **Secrets and variables** > **Actions**
   - Click **New repository secret**
   - Name: `CLAUDE_CODE_OAUTH_TOKEN`
   - Value: paste your OAuth token
   - Click **Add secret**

### CI Artifacts

Each workflow run produces the following artifacts (available for 30 days):

| Artifact | Description |
|----------|-------------|
| `e2e-test-report` | The full HTML test report with embedded screenshots |
| `e2e-test-screenshots` | Individual screenshot files from each test step |
| `e2e-test-log` | Raw console output from the test run |

### CI Output

Test results are printed directly in the GitHub Actions log so you can see pass/fail status, JavaScript errors, and visual bugs without downloading the HTML report.

## Project Structure

```
.
├── .github/workflows/e2e-tests.yml   # CI workflow
├── .claude/settings.local.json        # Claude Code permission settings
├── mcp-config.json                    # Playwright MCP server config
├── prompt.md                          # Test scenario definitions
├── run-test.sh                        # Test runner script
├── update-oauth-secret.sh             # Push OAuth token to GitHub secrets
└── README.md
```
