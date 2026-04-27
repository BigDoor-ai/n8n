# 🚀 Skincare AI Ad Generator (n8n Workflow)

An automated AI-powered workflow that generates **premium skincare ad creatives**—including scripts, scenes, prompts, and voiceovers—using n8n, OpenAI, and various media generation tools.

Built for **D2C brands, agencies, and AI consultants** who want to achieve scalable, high-quality ad content creation.

---

## 🧠 What This Does

This workflow takes product input and automatically performs the following steps:

1. **Generates** a high-converting ad script.
2. **Breaks** the script into cinematic scenes.
3. **Creates** precise video generation prompts.
4. **Generates** professional voiceover audio.
5. **Uploads** all assets to Google Drive.
6. **Prepares** content for external video tools (Fal / HeyGen).

---

## ⚙️ Key Features

* **🎬 Scene-based generation:** Supports Test mode (1 scene) and Full mode (5 scenes).
* **🧑‍🎤 Controlled consistency:** Intelligent scene prompting to maintain model consistency.
* **🎙️ Premium voiceovers:** Conversion-focused scripts optimized for audio.
* **☁️ Google Drive integration:** Automated asset organization and cloud storage.
* **📩 Notification system:** Real-time updates via Telegram/WhatsApp after uploads.
* **🔁 Modular workflow:** Highly extendable nodes for future customization.

---

## 🏗️ Tech Stack

* **n8n:** Workflow orchestration (self-hosted recommended).
* **OpenAI:** GPT models for script and prompt generation.
* **Google Drive API:** Asset storage.
* **Fal AI / HeyGen:** (Optional) Video generation providers.
* **JavaScript:** Custom logic implemented within n8n nodes.

---

## 📂 Workflow Structure

`Form Input` → `Normalize Inputs` → `Fetch Product Data` → `AI Creative Brain (Script + Scenes)` → `Split Scenes` → `Generate Video (Fal AI)` → `Download Video` → `Upload to Google Drive` → `Notification (Telegram/WhatsApp)` → `Voiceover Generation` → `Upload Voiceover` → `Final Output`

---

## 🔑 Setup Instructions

### 1. Import Workflow
* Open your n8n instance.
* Go to **Workflows** → **Import from File**.
* Upload the JSON file provided in this repository.

### 2. Configure Credentials

#### OpenAI
Add your API key in the **HTTP Request** node or the OpenAI node:
`Authorization: Bearer YOUR_OPENAI_API_KEY`

> ⚠️ **Security Warning:** Ensure you rotate your key if it has ever been exposed publicly.

#### Google Drive
* Connect your Google account in the credentials node.
* Ensure the service account or user account has write permissions for the destination folder.

#### (Optional) Fal AI / Video Tools
* Add your provider credentials if you plan to utilize automated video generation.

---

## 📝 Input Fields

Provide the following via the trigger form:
* **Product URL**
* **Product Details** (optional)
* **Product Image URL**
* **Brand Name**
* **Target Audience**
* **CTA** (Call to Action)
* **Ad Style**
* **Generation Mode** (Test / Full)

---

## 🎛️ Modes

| Mode | Output | Description |
| :--- | :--- | :--- |
| **test** | 1 scene | Fast and cheap for testing prompt logic. |
| **full** | 5 scenes | Generates a complete, multi-scene ad campaign. |

---

## 📦 Output

Each generated scene produces the following data structure:

```json
{
  "scene_number": 1,
  "scene_title": "Hook",
  "duration": 5,
  "video_prompt": "...",
  "voiceover_text": "...",
  "drive_url": "..."
}
```

---

## 🧪 Testing Strategy

1.  Start with **Test Mode (1 scene)**.
2.  Verify:
    * Script quality and brand voice.
    * Video generation output.
    * Google Drive file organization.
3.  Once stable, switch to **Full Mode (5 scenes)**.

---

## ⚠️ Common Issues

* **Invalid JSON from AI:** Ensure the system prompt explicitly enforces strict JSON output format.
* **OpenAI Errors:** Verify your API key usage limits and model name settings.
* **Google Drive Upload Failure:** Reconnect credentials and verify folder ID permissions.
* **High Fal AI Cost:** Always verify the workflow logic using 1-scene mode first.

---

## 🚀 Future Improvements

* Full video stitching (FFmpeg automation).
* Advanced avatar/model consistency layer.
* Multi-language support for international ads.
* Direct API publishing to Instagram/YouTube.

---

## 💼 Use Cases

* Skincare & Beauty D2C Brands.
* Performance Marketing Agencies.
* AI Automation Freelancers.
* Content Creators & Influencers.

---

## 📌 Notes

* This is an **MVP workflow**—feel free to fork and customize it to your specific needs.
* Always keep your API keys stored securely in n8n credentials.

---

## 👤 Author

**Built by BigDoor AI** *AI Automation • Content Systems • Sales Workflows* [viisesh@bigdoor.ai](mailto:viisesh@bigdoor.ai)
