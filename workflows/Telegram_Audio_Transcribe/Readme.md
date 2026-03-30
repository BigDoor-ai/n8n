# 🎙️ Telegram Audio Transcription & Summarization (n8n Workflow)

## Overview

This project is an automated n8n workflow that captures audio messages from Telegram, transcribes them using OpenAI, generates structured summaries, and delivers the output via Telegram and Notion.

It is designed for users who want to quickly convert voice notes into actionable, organized text without manual effort.

---

## 🚀 Features

- 📥 Automatically listens for incoming Telegram audio messages
- 🎧 Downloads and processes audio files
- 🧠 Transcribes audio using OpenAI
- ✍️ Generates structured summaries using a custom prompt
- 📤 Sends transcription + summary back to Telegram
- 🗂 Stores structured output in Notion for future reference

---

## 🧩 Workflow Architecture

The workflow follows this sequence:

1. **Telegram Trigger**
   - Listens for incoming messages (audio supported)
   
2. **Get File**
   - Fetches the audio file from Telegram servers

3. **Transcribe Audio (OpenAI)**
   - Converts audio into text

4. **Summarization (OpenAI GPT-4)**
   - Generates a structured summary with:
     - Title
     - Summary
     - Main Points
     - Action Items
     - Follow-ups
     - Stories
     - References
     - Arguments
     - Related Topics

5. **Output Distribution**
   - Sends transcription + summary back to Telegram
   - Creates a structured page in Notion

---

## 🛠 Tech Stack

- **n8n** – Workflow automation
- **Telegram Bot API** – Input & output channel
- **OpenAI API** – Transcription & summarization
- **Notion API** – Knowledge storage

---

## 📂 File Reference

Workflow JSON: :contentReference[oaicite:0]{index=0}

---

## ⚙️ Setup Instructions

### 1. Import Workflow
- Open n8n
- Go to **Workflows → Import**
- Paste or upload the provided JSON file

### 2. Configure Credentials

You must configure the following credentials:

- **Telegram API**
  - Create a bot using BotFather
  - Add bot token in n8n

- **OpenAI API**
  - Add your API key
  - Ensure access to:
    - Audio transcription
    - GPT model (used in summarization)

- **Notion API**
  - Create an integration
  - Share target database/page with the integration

---

## 🔐 Security Notes

- All API credentials in the original workflow must be removed before publishing
- Do NOT expose:
  - API keys
  - Webhook URLs
  - Internal IDs
- Replace credentials with environment variables or n8n credential manager

---

## 📌 Customization

You can modify:

- Prompt structure for summarization
- Output format (Telegram / Notion)
- Model selection (GPT-4 → other models)
- Character limits or summary depth

---

## ⚠️ Limitations

- Requires clean audio input for accurate transcription
- Telegram audio format compatibility may vary
- OpenAI usage incurs API costs

---

## 📈 Use Cases

- Meeting notes automation
- Voice journaling
- Content creation (podcasts, ideas)
- Sales call summaries
- Knowledge management

---

## 🤝 Contribution

Feel free to fork this repository and adapt the workflow to your needs. Contributions and improvements are welcome.

---

## 📄 License

This project is provided as-is for educational and automation purposes.
