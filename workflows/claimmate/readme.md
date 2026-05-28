# ClaimMate

## WhatsApp-first AI Claims & Warranty Assistant for Consumers

ClaimMate is a personal AI assistant that helps consumers manage household bills, warranty cards, invoices, and insurance documents, then turns them into an actionable claims and warranty dashboard.

The MVP is currently implemented on Telegram for faster hackathon prototyping, but the final product is designed to be WhatsApp-first, since WhatsApp is the most natural interface for Indian households to share bills, photos, documents, and claim-related messages.

---

## One-Line Pitch

ClaimMate helps consumers recover money from forgotten warranties, returns, and claims by turning every household bill into an AI-managed claim opportunity.

---

## Problem

Consumers lose money because warranty and claim processes are painful.

Common issues:

- Bills and warranty cards get lost.
- People forget return and warranty windows.
- Warranty terms are difficult to understand.
- Claim email IDs and support contacts are hard to find.
- Claim processes are deliberately tedious.
- Consumers often abandon valid claims because follow-up is painful.
- Families accumulate dozens of bills across electronics, appliances, mobiles, accessories, policies, and services, but rarely track them properly.

---

## Solution

ClaimMate allows users to upload bills, warranty cards, invoices, and insurance documents through chat.

The assistant then:

1. Stores the uploaded document.
2. Extracts product, seller, invoice, purchase, warranty, and support details.
3. Classifies the document and product category.
4. Adds the product to a warranty dashboard.
5. Lets users ask for available warranties.
6. Helps initiate a warranty claim when the user faces an issue.
7. Drafts a claim email based on saved product details.
8. Asks for explicit user approval before sending.
9. Sends the approved claim email to the relevant support contact.
10. Keeps the user in CC.
11. Updates claim status for follow-up.

---

## Current MVP Status

The current MVP is a working Telegram-based prototype.

Telegram is used only for quick MVP execution. The intended production experience is WhatsApp-first.

### Working MVP Capabilities

- Telegram bot receives user messages.
- User can upload bill images and documents.
- Uploaded files are routed to a document intake workflow.
- Bill details are extracted using AI/OCR logic.
- Extracted product and warranty details are stored in Google Sheets.
- User can ask the bot to show saved warranties.
- User can initiate a claim for a saved product.
- Bot identifies the relevant product.
- Bot asks for the issue description.
- Bot validates that the issue is not a meaningless greeting like “Hi” or “Hey”.
- Bot creates a claim draft.
- Bot asks for user approval using `SEND` or `CANCEL`.
- User can save their email using `/setemail`.
- Approved claim email workflow is connected for sending claim emails.
- Workflow structure supports human-in-the-loop approval before sending.

---

## Product Vision

ClaimMate will become a WhatsApp-first AI claims operating system for consumers.

The long-term vision is to help users manage:

- Product warranties
- Return windows
- Repair claims
- Replacement claims
- Insurance policies
- Service contracts
- AMC documents
- Purchase records
- Brand/customer support communication
- Follow-ups until resolution

In the future, ClaimMate can become a B2B2C infrastructure layer for:

- Electronics retailers
- Appliance brands
- Insurance companies
- Fintech companies
- Credit card companies
- Consumer marketplaces
- Warranty providers
- Service aggregators

---

## User Journey

### 1. User uploads a bill

The user sends a bill, invoice, warranty card, or policy document to ClaimMate through chat.

Current MVP:

```text
Telegram upload: image / document / PDF
```

Production target:

```text
WhatsApp upload: image / PDF / forwarded invoice
```

### 2. ClaimMate extracts details

The system extracts:

- Product name
- Brand
- Category
- Seller
- Invoice number
- Purchase date
- Purchase amount
- Warranty period
- Warranty expiry date
- Return window
- Support email
- Support phone
- Confidence score

### 3. ClaimMate stores the document

Uploaded files are stored in Google Drive or cloud storage.

The extracted structured data is stored in Google Sheets for the MVP.

### 4. User checks warranties

The user can type:

```text
show my warranties
```

ClaimMate responds with saved products and warranty status.

### 5. User initiates claim

The user can type:

```text
claim EXIDE
```

ClaimMate finds the matching saved product and asks the user to describe the issue.

### 6. User describes issue

Example:

```text
Battery is not holding charge properly.
```

ClaimMate validates the issue and prevents weak inputs like:

```text
Hi
Hey
Ok
Thanks
```

from becoming claim drafts.

### 7. ClaimMate drafts claim

ClaimMate creates:

- Claim ID
- Issue description
- Support email
- Claim email subject
- Claim email body
- Claim status
- User approval status

### 8. User approves

The bot asks:

```text
Reply SEND to send this email, or CANCEL to stop.
```

The email is only sent after explicit approval.

### 9. Claim email is sent

Once approved, ClaimMate sends the claim email to the relevant support email and keeps the user in CC.

### 10. Claim status is updated

The claim status is updated in the backend so follow-ups can be tracked.

---

## MVP Tech Stack

### Chat Interface

- Telegram Bot for MVP
- WhatsApp planned for production

### Automation Engine

- n8n self-hosted workflow automation

### AI / Extraction

- AI-based document understanding
- OCR/vision extraction for bill and warranty documents
- Structured data normalization

### Storage

- Google Drive for uploaded document storage
- Google Sheets as MVP database

### Email

- Gmail integration for approved claim emails

### Human-in-the-Loop

- User approval required before claim email is sent

---

## Core Workflows

### Workflow 00: Telegram Chat Router

Main router workflow.

Responsibilities:

- Receives Telegram messages.
- Normalizes text, documents, and photos.
- Detects user intent.
- Routes messages to the right branch.
- Handles `/start`, help, warranty lookup, claim request, issue capture, approval, cancellation, and email capture.
- Calls document intake workflow when a file is uploaded.
- Calls approved claim email workflow after user approval.

### Workflow 01: Document Intake

Document processing workflow.

Responsibilities:

- Receives uploaded file details from Workflow 00.
- Downloads the Telegram file.
- Uploads the file to Google Drive.
- Extracts bill/warranty details.
- Normalizes extracted data.
- Appends document records.
- Appends product/warranty records.
- Replies to the user with extracted summary.

### Workflow 04: Send Approved Claim Email

Email sending workflow.

Responsibilities:

- Receives approved claim payload from Workflow 00.
- Fetches claim details.
- Fetches user email.
- Fetches product details.
- Sends claim email via Gmail.
- CCs the user.
- Updates claim status.
- Sends final Telegram confirmation.

---

## Google Sheets MVP Database

The MVP uses a Google Sheet as a lightweight database.

### Main Tabs

#### 1. `Users`

Stores user profile details.

Typical columns:

```text
User_ID
Telegram_ID
Name
Email
Phone
Consent_Status
Created_At
Last_Updated
```

#### 2. `Documents`

Stores uploaded document records.

Typical columns:

```text
Document_ID
User_ID
Telegram_File_ID
File_Name
File_Type
Google_Drive_Link
Document_Type
OCR_Text
Processing_Status
Upload_Date
Notes
```

#### 3. `Products`

Stores extracted product and warranty information.

Typical columns:

```text
Product_ID
User_ID
Document_ID
Product_Name
Brand
Category
Seller
Invoice_Number
Purchase_Date
Purchase_Amount
Warranty_Period_Months
Warranty_Expiry_Date
Return_Window_Days
Return_Expiry_Date
Support_Email
Support_Phone
Warranty_Status
Confidence_Score
User_Confirmed
Created_At
Last_Updated
```

#### 4. `Claims`

Stores warranty claim drafts and statuses.

Typical columns:

```text
Claim_ID
User_ID
Product_ID
Issue_Description
Claim_Email_To
Claim_Email_CC
Claim_Email_Subject
Claim_Email_Body
Claim_Status
User_Approval_Status
Email_Sent_At
Followup_Date
Last_Followup_At
Next_Action
Notes
```

#### 5. `Conversation_State`

Stores active chat state.

Typical columns:

```text
State_ID
User_ID
Chat_ID
Current_Intent
Current_Step
Related_Product_ID
Related_Claim_ID
Last_User_Message
Bot_Waiting_For
Created_At
Last_Updated
```

---

## Supported MVP Commands

### Start / Help

```text
/start
help
what can you do
```

### Upload Guidance

```text
how to upload bill
what format
can I send PDF
```

### Warranty Lookup

```text
show my warranties
my warranties
my products
```

### Claim Initiation

```text
claim PRODUCT NAME
claim exide
raise warranty claim
```

### Email Capture

```text
/setemail user@example.com
my email is user@example.com
```

### Claim Approval

```text
SEND
approve
yes send
```

### Claim Cancellation

```text
CANCEL
stop
do not send
```

---

## Example Demo Flow

### Step 1: User starts bot

```text
/start
```

Bot replies with features and upload instructions.

### Step 2: User uploads bill

User uploads a bill image or invoice.

Bot processes the document and extracts product/warranty details.

### Step 3: User checks warranties

```text
show my warranties
```

Bot replies with active warranty list.

### Step 4: User starts claim

```text
claim exide
```

Bot identifies the matching product.

### Step 5: Bot asks issue

```text
Please describe the issue in one sentence.
Example: Battery is not holding charge properly.
```

### Step 6: User describes issue

```text
Battery is not holding charge properly.
```

### Step 7: Bot creates claim draft

Bot replies:

```text
Claim draft created.

Reply SEND to send this email, or CANCEL to stop.
```

### Step 8: User approves

```text
SEND
```

### Step 9: Claim email is sent

ClaimMate sends the claim email and updates the claim status.

---

## Current Limitations

This is an MVP, not a full production system.

Current limitations:

- Telegram is used for MVP instead of WhatsApp.
- Google Sheets is used as a database.
- PDF support depends on the document extraction workflow.
- Image bill extraction is more reliable than PDF extraction in the current MVP.
- Follow-up automation is still basic.
- Claim coverage is estimated and not guaranteed.
- Claim approval depends on brand/customer support response.
- User authentication and encryption need to be strengthened before production.
- Duplicate document and duplicate claim detection need improvement.
- WhatsApp Business API integration is planned but not completed in the current MVP.

---

## Privacy and Consent

ClaimMate handles sensitive purchase and policy documents.

Production version should include:

- Explicit user consent
- Encrypted document storage
- Secure authentication
- Data deletion controls
- User-controlled document access
- Clear privacy policy
- Audit logs for email sending
- No email sent without user approval

In the MVP, emails are sent only after explicit user approval through the chat.

---

## Why This Matters

Consumers already pay for warranties, return policies, and support coverage. But because bills get lost and claim processes are tedious, much of this value is never recovered.

ClaimMate makes the process simple:

```text
Upload bill → Track warranty → Raise claim → Approve email → Follow up
```

This can help users recover money, save time, and avoid abandoning valid claims.

---

## Target Audience

### Initial Users

- Urban households
- Working professionals
- Families managing multiple purchases
- Consumers buying electronics, appliances, mobiles, accessories, and home products
- Users who often lose bills or forget warranty periods

### Initial Categories

- Electronics
- Appliances
- Mobile phones
- Batteries
- Gadgets
- Home devices

### Future Categories

- Insurance policies
- Credit card purchase protection
- Extended warranties
- Service contracts
- AMC documents
- Travel claims
- Healthcare reimbursement claims

---

## Potential Business Models

### B2C Subscription

Users pay a small monthly or annual fee for warranty and claim management.

### Success Fee

ClaimMate charges a percentage or fixed fee when a claim is successfully resolved.

### B2B2C Partnerships

ClaimMate partners with:

- Retailers
- Electronics brands
- Appliance brands
- Insurers
- Fintech companies
- Credit card companies
- Marketplaces

### White-Labeled Claim Assistant

Brands and retailers can offer ClaimMate as a customer support layer to reduce claim friction.

---

## Future Roadmap

### Phase 1: MVP

- Telegram-based prototype
- Bill upload
- AI extraction
- Warranty dashboard
- Claim draft
- Human approval
- Email sending

### Phase 2: WhatsApp Launch

- WhatsApp Business API integration
- Better document ingestion
- User dashboard
- Claim status tracking
- Automated follow-up reminders

### Phase 3: Consumer App

- Web/mobile dashboard
- Warranty expiry reminders
- Return window reminders
- Multi-user household account
- Policy analysis
- Claim history

### Phase 4: B2B2C Infrastructure

- Retailer integration
- Brand claim API
- Insurance claim workflows
- Fintech and credit card partnerships
- Claim analytics dashboard

---

## Repository Structure

Suggested repository structure:

```text
claimmate-mvp/
├── README.md
├── workflows/
│   ├── claimmate-00-telegram-chat-router.json
│   ├── claimmate-01-telegram-intake.json
│   └── claimmate-04-send-approved-claim-email.json
├── docs/
│   ├── demo-script.md
│   ├── architecture.md
│   ├── google-sheets-schema.md
│   └── mvp-submission-summary.md
├── screenshots/
│   ├── telegram-flow/
│   ├── n8n-workflows/
│   ├── google-sheets-dashboard/
│   └── gmail-claim-email/
└── pitch-deck/
    └── ClaimMate-Pitch-Deck.pdf
```

---

## Demo Assets

Recommended demo assets:

- 4-slide pitch deck PDF
- Demo video / screen recording
- Telegram bot flow screenshots
- n8n workflow screenshots
- Google Sheets dashboard screenshots
- Sample claim email screenshot
- Workflow JSON exports

---

## Demo Script Summary

1. Introduce the problem: consumers lose money because bills and warranties are forgotten.
2. Show bill upload through Telegram.
3. Show AI extraction result.
4. Show saved warranty dashboard.
5. Ask bot to show warranties.
6. Start a claim for one product.
7. Describe issue.
8. Bot creates claim draft.
9. User approves with `SEND`.
10. Claim email is sent and claim status is updated.
11. Explain WhatsApp-first production vision.

---

## Product Name

```text
ClaimMate
```

## Full Product Description

```text
ClaimMate is a WhatsApp-first AI claims and warranty assistant that turns household bills, warranty cards, and insurance documents into an actionable claims dashboard. It helps users track active warranties, initiate claims, approve claim emails, and follow up until resolution.
```

---

## Hackathon MVP Note

This MVP is built on Telegram for speed of development and demonstration.

The final intended product is WhatsApp-first because WhatsApp is the default communication layer for most Indian consumers and households.

---

## Disclaimer

ClaimMate does not guarantee claim approval.

Warranty coverage depends on the actual product terms, seller policy, brand policy, warranty exclusions, and support inspection.

ClaimMate helps users organize documents, understand likely eligibility, initiate claims, and follow up more easily.

---

## Author

Built as a hackathon MVP by:

```text
Vishesh Allahabadi
BigDoor AI Labs / ClaimMate
```

---

## Status

```text
MVP Prototype
```

The product is under active development.
