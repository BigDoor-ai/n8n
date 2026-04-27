# 💄 AI Makeup Analysis & Product Recommendation Bot (n8n Workflow)

An end-to-end AI-powered workflow that turns a simple selfie into a **personalized makeup analysis + product recommendation engine** — delivered directly via chat (Telegram / WhatsApp ready).

Built using **n8n, OpenAI, and Google Sheets**, this system is designed for **beauty brands, D2C stores, and AI consultants**.

---

## 🚀 What This Does

This workflow allows users to:

1. 📸 Send a selfie via chat  
2. 🧠 Get AI-powered makeup analysis (skin tone, undertone, features)  
3. 🖼️ Receive a **premium infographic report**  
4. 🛍️ Get **personalized product recommendations** from a brand’s catalog  
5. 🔗 Click direct purchase links  

All inside a chat interface.

---

## 🧠 Core Capabilities

- AI Face Analysis (Makeup suitability)
- Infographic Generation (Dermatology-grade visual report)
- Product Matching Engine (based on tone, undertone, shades)
- Chat-based UX (Telegram / WhatsApp adaptable)
- Google Sheets as Product Database

---

## 🏗️ Workflow Architecture
User (Telegram / WhatsApp)
↓
Trigger (Message Received)
↓
Image Extraction
↓
OpenAI Analysis (Structured JSON Output)
↓
Parse + Normalize Data
↓
Infographic Prompt Builder
↓
OpenAI Image Generation
↓
Send Infographic to User
↓
Fetch Products (Google Sheets)
↓
Match Products (Scoring Logic)
↓
Send Recommendations with Links


---

## ⚙️ Tech Stack

- **n8n** (Self-hosted workflow automation)
- **OpenAI APIs**
  - `gpt-5.5` → Makeup analysis (structured JSON)
  - `gpt-image-1` → Infographic generation
- **Telegram Bot API** (for chat interface)
- **Google Sheets** (product database)
- **JavaScript (Code Nodes)** for logic + scoring

---

## 📊 Product Matching Logic

Each product is scored based on:

- Skin tone match → +30
- Undertone match → +30
- Shade family match → +20
- Lip/blush family match → +20
- Finish match → +10

Top products are ranked and grouped into:

- Foundation
- Blush
- Lips (Everyday + Glam)
- Eyes
- Brows

---

## 📁 Google Sheets Structure

Sheet Name: `Products`

Expected columns:

- `Title`
- `Variant Price`
- `Product URL`
- `skin_tone`
- `undertone`
- `shade_family`
- `finish`
- `match_category` (foundation / blush / lip / eyes / brow)
- `priority_score`
- `Status` (active / inactive)

---

## 🔑 Setup Instructions

### 1. Clone Repository
git clone <your-repo-url>


---

### 2. Import Workflow in n8n

- Open n8n
- Go to **Workflows → Import**
- Paste JSON from:

👉 :contentReference[oaicite:0]{index=0}

---

### 3. Configure Credentials

Set up the following in n8n:

- OpenAI API Key
- Telegram Bot API
- Google Sheets OAuth

---

### 4. Update Sheet ID

In **Get Products node**, replace:
documentId: YOUR_GOOGLE_SHEET_ID


---

### 5. Activate Workflow

- Switch workflow to **Active**
- Send a selfie to your bot
- Watch the system do its thing

---

## 💬 Chat Flow

### If NO image:
"Please share a clear front face selfie for makeup analysis"

### If image received:
"Your analysis is complete. Infographic is being generated..."


### Final Output:
- Infographic image
- Personalized recommendations
- Purchase links

---

## 🧪 Testing

- Use Telegram bot (recommended for testing)
- Replace with WhatsApp API for production
- Ensure image is high quality (front-facing)

---

## ⚠️ Notes

- AI recommendations are **assistive**, not absolute
- Always verify shades before purchase
- No medical or dermatological diagnosis is performed

---

## 📈 Use Cases

- D2C Makeup Brands
- Beauty Clinics
- E-commerce Stores
- AI Consultants selling automation
- WhatsApp Commerce funnels

---

## 🔮 Future Improvements

- WhatsApp native integration
- Skin concern detection (acne, pigmentation)
- Shade swatch preview
- CRM integration (Zoho / HubSpot)
- User profile memory

---

## 🧑‍💻 Author

Built by **BigDoor AI**  
AI Automation for Real-World Businesses
Contact: viisesh@bigdoor.ai

---

## 📜 License

MIT License (or update as required)
