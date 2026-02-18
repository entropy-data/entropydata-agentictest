# Test: Entropy Data End-to-End Test Suite

Use the Playwright MCP browser tools to test the Entropy Data application at `https://demo.entropy-data.com`.
Run in headless mode at **1920x1080 desktop resolution** (no mobile or tablet viewports). At the end, generate an HTML test report.

## Goal

**Find at least 20 bugs.** A bug is any of the following:
- A JavaScript error (console error, uncaught exception)
- A failed network request (HTTP 4xx/5xx responses, timeouts, CORS errors)
- A functional bug (broken button, form that doesn't submit, missing data, incorrect behavior, dead link, feature that doesn't work as expected)

**Do NOT report visual bugs. Ignore all visual issues (layout, styling, alignment, colors, fonts, spacing).**

Run Tests 1-3 first, then continue with exploratory testing. **Do not stop until you have found 20 distinct bugs.** If after Tests 1-3 you have fewer than 20 bugs, keep exploring new areas of the application and testing new use cases until you reach 20. There is no upper limit on the number of exploratory tests you may run.

## Pre-Test: Determine Starting Bug Number and Verify Existing Bugs

Before running any tests:

0. **Ensure the `bugs/` directory exists** — run `mkdir -p bugs` using Bash.
1. **List existing bug files** in the `bugs/` folder (e.g., `bug-01.html`, `bug-02.html`, ...) and **determine the highest existing bug number**. If no bug files exist, the starting number is `bug-01.html`. All new bugs must use numbers that continue incrementing from the highest existing number (e.g., if `bug-07.html` is the highest, the next new bug should be `bug-08.html`).
2. **For each existing bug file**, read the bug report and attempt to reproduce it:
   - Navigate to the URL listed in the bug report
   - Follow the steps to reproduce
   - Take a screenshot and check whether the bug still exists
3. **If a bug is fixed**, delete its file from the `bugs/` folder using Bash `rm bugs/bug-XX.html`. Note: this will leave gaps in the numbering — that is expected. Do not renumber existing bug files.
4. **If a bug still exists**, keep the file as-is.
5. After verification, confirm the highest remaining bug number. New bugs start from the next number after that. (For example, if `bug-03.html` was deleted but `bug-07.html` still exists, the next new bug is `bug-08.html`.)

## Setup

1. **Verify the application is reachable**
   - Navigate to `https://demo.entropy-data.com` and confirm the page loads
   - If the site is unreachable (network error, timeout, or HTTP error), take a screenshot, write it to the report, and stop the test suite — do not proceed with further tests

2. **Enable JavaScript error monitoring**
   - Before navigating, use the Playwright MCP console/log monitoring tool (e.g., `browser_console_messages` or equivalent) throughout the test to capture console output
   - After each navigation and interaction, check for JavaScript errors (console errors, uncaught exceptions) and failed network requests
   - Record all errors with their message, source, and the step during which they occurred

3. **Bug tracking**
   - Track bugs by writing each bug file immediately when found (to the `bugs/` folder)
   - After each test step, check your bug count by counting the bug files you have written so far in this session plus any pre-existing bugs
   - **After each test step** (not just after complete tests): if you have found 20 bugs, proceed directly to report generation — do not finish the current test

## Test 1: Search Orders Data Product and Request Access

1. **Navigate to Entropy Data**
   - Open the browser and go to `https://demo.entropy-data.com`
   - Take a screenshot to confirm the page loaded
   - Check console for JS errors

2. **Search for the Orders data product**
   - Find the search input field on the page
   - Type "orders" into the search field and submit the search
   - Take a screenshot of the search results
   - Verify that at least one data product appears in the results
   - Check console for JS errors

3. **Open the data product**
   - Click on the first data product result that relates to orders
   - Take a screenshot of the data product detail page
   - Identify the available output ports listed on the page
   - Check console for JS errors

4. **Request access to an output port**
   - Find an output port on the data product detail page
   - Click the "Request Access" button (or similar) for that output port
   - Fill in the purpose/justification field with: "Automated testing of access request workflow"
   - Submit the access request form
   - Take a screenshot of the confirmation or result
   - Check console for JS errors

5. **Verify the result**
   - Confirm that the access request was submitted successfully (look for a success message, status change, or confirmation)
   - Take a final screenshot as evidence
   - Check console for JS errors

**Bug check: Have you found 20 bugs yet? If yes, skip remaining tests and go to Report Generation.**

## Test 2: Create a Data Contract via the Editor

1. **Navigate to Data Contract creation**
   - From the main page, find and click the navigation link or button to create a new data contract (look for "Data Contracts", "New", "Create", or similar in the navigation/menu)
   - Take a screenshot of the data contract editor page
   - Check console for JS errors

2. **Fill in the data contract form**
   - Use the new editor UI to fill in the data contract fields:
     - Name/Title: "Test Orders Contract"
     - Version: "1.0.0"
     - Description: "Automated test data contract for orders data"
     - Fill in any other required fields that the editor presents (schema, terms, SLA, etc.) with reasonable test values
   - Take a screenshot showing the filled form
   - Check console for JS errors

3. **Save the data contract**
   - Click the Save button to save the data contract
   - Take a screenshot of the result (success message, saved contract view, etc.)
   - Verify the contract was saved successfully
   - Check console for JS errors

**Bug check: Have you found 20 bugs yet? If yes, skip remaining tests and go to Report Generation.**

## Test 3: Add a Data Product from Databricks via the Wizard

1. **Navigate to Data Product creation**
   - From the main page, find and click the navigation link or button to create/add a new data product (look for "Add Data Product", "New", "Create", or similar)
   - Take a screenshot of the creation wizard
   - Check console for JS errors

2. **Select Databricks as the source**
   - In the wizard, select Databricks as the data source type
   - Take a screenshot showing the Databricks option selected
   - Check console for JS errors

3. **Fill in the Databricks data product details**
   - Fill in required fields with test values:
     - Name: "Test Databricks Product"
     - Description: "Automated test data product from Databricks"
     - Fill in any Databricks-specific connection/configuration fields the wizard presents with reasonable test values
   - Take a screenshot of the filled wizard
   - Check console for JS errors

4. **Complete the wizard**
   - Click through the wizard steps, filling in any additional required fields
   - Submit/save the data product
   - Take a screenshot of the final result
   - Verify the data product was created
   - Check console for JS errors

**Bug check: Have you found 20 bugs yet? If yes, go to Report Generation. If no, continue with exploratory testing below.**

## Exploratory Testing (Continue Until 20 Bugs Found)

You have not yet found 20 bugs. Continue exploring the application and testing new use cases until you reach a total of 20 bugs.

**How to explore:**
1. Navigate around the application — open menus, sidebars, navigation links, settings, and any other areas visible in the UI
2. Take a screenshot of the main areas you discover
3. Based on what you see, pick a use case to test that exercises a different part of the application than what you have already tested
4. **Vary your choices** — pick use cases that differ from the scripted tests (Tests 1-3) and from exploratory tests you have already run in this session. Aim for broad coverage across different features.

**For each exploratory test:**
- Give it a descriptive name (e.g., "Test 4: [Your chosen use case]")
- Document what you are testing and why you chose it
- Interact with the feature: click buttons, fill forms, navigate pages, trigger actions
- Take screenshots at each step
- Check console for JS errors after each step
- Record the result (PASS/FAIL) with notes on what happened
- **After each exploratory test, check your bug count. Stop exploring once you have found 20 bugs total.**

**Examples of things you might test** (do NOT always pick these — explore and find your own):
- Filtering or sorting data products
- Navigating to a data contract detail page and reviewing its contents
- Editing an existing data product or data contract
- Testing pagination if there are lists
- Exploring settings or profile pages
- Testing breadcrumb navigation
- Searching for nonexistent terms and verifying the "no results" state behaves correctly (e.g., no JS errors, clear messaging)
- Testing any dialogs, modals, or tooltips you encounter
- Verifying links and navigation flows
- Trying edge cases in forms (empty submissions, very long text, special characters)
- Testing browser back/forward navigation
- Checking loading states and spinners

## Bug Reports

Each bug must be stored as an individual HTML file in the `bugs/` folder (created during Pre-Test). Use the naming convention `bug-XX.html` where XX is a zero-padded incremented number (e.g., `bug-01.html`, `bug-02.html`, ...). **Write each bug file immediately when you find the bug — do not wait until all testing is complete.** New bug numbers must continue from the highest existing bug number in the `bugs/` folder (as determined during the Pre-Test phase). Gaps in numbering from deleted bugs are expected and acceptable.

Each bug report HTML file must be a standalone, styled HTML page containing the following information:

- **Title**: Bug XX: \<Short descriptive title\>
- **Category**: JS Error / Network Error / Functional Bug
- **Severity**: Critical / Major / Minor
- **Found in**: Test name and step number
- **URL**: The page URL where the bug was found
- **Description**: Detailed description of the bug
- **Steps to Reproduce**: Numbered list of steps
- **Expected Behavior**: What should have happened
- **Actual Behavior**: What actually happened
- **Screenshots**: Include ALL relevant screenshots as inline base64-encoded images (read the screenshot files and embed them as `<img src="data:image/png;base64,...">`). If no screenshots are available, state "No screenshots available."
- **Additional Context**: Any extra details — error messages, console output, etc.

Use clean, modern HTML styling (similar to the main report). Write each bug file using the Write tool.

## HTML Report Generation

After writing all bug report files, also create an HTML report file at `report.html` in the current working directory. The report must include:

- A title "Entropy Data - Automated Test Report"
- A timestamp of when the test ran
- **Bug Summary**: A prominent section at the top listing all bugs found. Each bug entry should include:
  - Bug number (matching the `bug-XX.html` file number)
  - Category (JS Error / Network Error / Functional Bug)
  - Severity (Critical / Major / Minor)
  - Description of the bug
  - Steps to reproduce (which test, which step)
  - Screenshot reference if applicable
- **Test Summary**: A summary table with columns: Test, Step, Description, Status (PASS/FAIL/SKIP), Notes — one row per step across all tests
- **JavaScript Errors** section: ALL console errors and uncaught exceptions found during the test, grouped by test and step. Include the error message, source/URL, and line number if available. If no JS errors were found, state "No JavaScript errors detected."
- **Screenshots** section: For each step, include any screenshots taken as inline base64-encoded images (read the screenshot files and embed them). If screenshots are not available, note that in the report.
- Use clean, modern styling (light background, bordered table, green/red/yellow status badges, collapsible sections for screenshots)
- A final overall verdict: how many bugs were found, total tests run, and a summary of application quality

Write this report using the Write tool to `report.html`.

## What NOT to Report as Bugs

The following categories of issues must **not** be reported as bugs. Skip them entirely:

- **Visual bugs** — layout problems, styling issues, alignment, colors, fonts, spacing, overlapping elements, responsive design quirks
- **Accessibility issues** — missing ARIA labels, contrast ratios, screen reader compatibility, tab order, focus indicators, alt text
- **Known false positives** — issues caused by demo/placeholder data (dummy values, sample data, obviously fake content that exists because this is a demo environment). See `false-positives.md` in the memory directory for a list of known false positives.
- **Performance issues** — slow page loads, large bundle sizes, unoptimized images (unless a page completely fails to load)
- **Browser-specific quirks** — issues that only appear due to headless mode or specific browser behavior, not application bugs
- **Expected demo limitations** — missing features that are clearly marked as "coming soon", disabled buttons with tooltips explaining why, or intentionally limited demo functionality

## Important Notes
- Take screenshots after each major step for documentation
- If a login page appears, take a screenshot and report what credentials or auth method is required
- If any step fails, take a screenshot of the error and continue with the remaining steps where possible
- If a wizard or form has steps/pages, screenshot each page
- **The primary goal is finding 20 bugs — be thorough and persistent in your testing**
- Count each distinct bug only once, even if it appears in multiple places
