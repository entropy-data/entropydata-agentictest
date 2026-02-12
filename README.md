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
- An Anthropic API key

### Running Tests Locally

```bash
export ANTHROPIC_API_KEY="your-api-key-here"
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

The CI pipeline requires one secret: **`ANTHROPIC_API_KEY`**.

#### Step-by-step

1. **Get an Anthropic API key**
   - Go to [console.anthropic.com](https://console.anthropic.com/)
   - Sign in or create an account
   - Navigate to **API Keys** in the sidebar
   - Click **Create Key**, give it a name (e.g. `entropy-e2e-tests`), and copy the key

2. **Add the secret to your GitHub repository**
   - Go to your repository on GitHub
   - Navigate to **Settings** > **Secrets and variables** > **Actions**
   - Click **New repository secret**
   - Name: `ANTHROPIC_API_KEY`
   - Value: paste your Anthropic API key
   - Click **Add secret**

That's it. The workflow will pick up the secret automatically on the next run.

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
└── README.md
```
