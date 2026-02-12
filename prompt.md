# Test: Entropy Data End-to-End Test Suite

Use the Playwright MCP browser tools to test the Entropy Data application at `https://demo.entropy-data.com`.
Run in headless mode. At the end, generate an HTML test report.

## Setup

1. **Enable JavaScript error monitoring**
   - Before navigating, use `browser_console_messages` tool throughout the test to capture console output
   - After each navigation and interaction, check for JavaScript errors (console errors, uncaught exceptions, failed network requests)
   - Record all JS errors with their message, source, and the step during which they occurred

2. **Visual bug monitoring**
   - After each screenshot, analyze the page for visual bugs: overlapping elements, clipped/truncated text, broken layouts, misaligned components, missing images or icons, z-index issues, elements overflowing containers, inconsistent spacing, broken responsive layout
   - Record any visual bugs found with a description and the step during which they occurred

## Test 1: Search Orders Data Product and Request Access

1. **Navigate to Entropy Data**
   - Open the browser and go to `https://demo.entropy-data.com`
   - Take a screenshot to confirm the page loaded
   - Check console for JS errors and inspect for visual bugs

2. **Search for the Orders data product**
   - Find the search input field on the page
   - Type "orders" into the search field and submit the search
   - Take a screenshot of the search results
   - Verify that at least one data product appears in the results
   - Check console for JS errors and inspect for visual bugs

3. **Open the data product**
   - Click on the first data product result that relates to orders
   - Take a screenshot of the data product detail page
   - Identify the available output ports listed on the page
   - Check console for JS errors and inspect for visual bugs

4. **Request access to an output port**
   - Find an output port on the data product detail page
   - Click the "Request Access" button (or similar) for that output port
   - Fill in the purpose/justification field with: "Automated testing of access request workflow"
   - Submit the access request form
   - Take a screenshot of the confirmation or result
   - Check console for JS errors and inspect for visual bugs

5. **Verify the result**
   - Confirm that the access request was submitted successfully (look for a success message, status change, or confirmation)
   - Take a final screenshot as evidence
   - Check console for JS errors and inspect for visual bugs

## Test 2: Create a Data Contract via the Editor

1. **Navigate to Data Contract creation**
   - From the main page, find and click the navigation link or button to create a new data contract (look for "Data Contracts", "New", "Create", or similar in the navigation/menu)
   - Take a screenshot of the data contract editor page
   - Check console for JS errors and inspect for visual bugs

2. **Fill in the data contract form**
   - Use the new editor UI to fill in the data contract fields:
     - Name/Title: "Test Orders Contract"
     - Version: "1.0.0"
     - Description: "Automated test data contract for orders data"
     - Fill in any other required fields that the editor presents (schema, terms, SLA, etc.) with reasonable test values
   - Take a screenshot showing the filled form
   - Check console for JS errors and inspect for visual bugs

3. **Save the data contract**
   - Click the Save button to save the data contract
   - Take a screenshot of the result (success message, saved contract view, etc.)
   - Verify the contract was saved successfully
   - Check console for JS errors and inspect for visual bugs

## Test 3: Add a Data Product from Databricks via the Wizard

1. **Navigate to Data Product creation**
   - From the main page, find and click the navigation link or button to create/add a new data product (look for "Add Data Product", "New", "Create", or similar)
   - Take a screenshot of the creation wizard
   - Check console for JS errors and inspect for visual bugs

2. **Select Databricks as the source**
   - In the wizard, select Databricks as the data source type
   - Take a screenshot showing the Databricks option selected
   - Check console for JS errors and inspect for visual bugs

3. **Fill in the Databricks data product details**
   - Fill in required fields with test values:
     - Name: "Test Databricks Product"
     - Description: "Automated test data product from Databricks"
     - Fill in any Databricks-specific connection/configuration fields the wizard presents with reasonable test values
   - Take a screenshot of the filled wizard
   - Check console for JS errors and inspect for visual bugs

4. **Complete the wizard**
   - Click through the wizard steps, filling in any additional required fields
   - Submit/save the data product
   - Take a screenshot of the final result
   - Verify the data product was created
   - Check console for JS errors and inspect for visual bugs

## Report Generation

After completing ALL tests (whether they passed or failed), create an HTML report file at `report.html` in the current working directory. The report must include:

- A title "Entropy Data - Automated Test Report"
- A timestamp of when the test ran
- **Test Summary**: A summary table with columns: Test, Step, Description, Status (PASS/FAIL/SKIP), Notes — one row per step across all tests
- **JavaScript Errors** section: ALL console errors and uncaught exceptions found during the test, grouped by test and step. Include the error message, source/URL, and line number if available. If no JS errors were found, state "No JavaScript errors detected."
- **Visual Bugs** section: ALL visual bugs found during the test, grouped by test and step. Include a description of the visual issue and which screenshot shows it. If no visual bugs were found, state "No visual bugs detected."
- **Screenshots** section: For each step, include any screenshots taken as inline base64-encoded images (read the screenshot files and embed them). If screenshots are not available, note that in the report.
- Use clean, modern styling (light background, bordered table, green/red/yellow status badges, collapsible sections for screenshots)
- A final overall verdict: PASS (all tests passed, no JS errors, no visual bugs), PARTIAL (some passed), or FAIL (critical steps failed)

Write this report using the Write tool to `report.html`.

## Important Notes
- Take screenshots after each major step for documentation
- If a login page appears, take a screenshot and report what credentials or auth method is required
- If any step fails, take a screenshot of the error and continue with the remaining steps where possible
- If a wizard or form has steps/pages, screenshot each page
