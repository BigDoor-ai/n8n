# 📊 Talk to Google Sheets using AI (n8n Workflow)

This n8n workflow allows you to **chat with your Google Sheets data in natural language** using an AI agent powered by OpenAI.

Instead of manually filtering, searching, or writing formulas, you can simply ask questions like:

- "What are the top entries?"
- "Show me recent records"
- "Summarize this data"
- "Find trends or patterns"

---

## 🚀 Features

- 💬 Chat interface to interact with your data  
- 🤖 AI Agent powered by OpenAI (`gpt-4.1`)  
- 📊 Direct integration with Google Sheets  
- 🧠 Memory-enabled conversations (context-aware)  
- 🔌 Built entirely in n8n (no backend required)  

---

## 🧩 Workflow Overview

This workflow consists of:

1. **Chat Trigger** – Receives user messages  
2. **AI Agent** – Understands queries and decides actions  
3. **OpenAI Model** – Processes natural language  
4. **Google Sheets Tool** – Fetches data from sheet  
5. **Memory Buffer** – Maintains conversation context  
6. **Chat Node** – Sends response back to user  

---

## 🛠️ Setup Instructions

### 1. Import Workflow
- Open n8n  
- Go to **Workflows → Import**  
- Upload the JSON file  

---

### 2. Configure Credentials

#### OpenAI
- Add your OpenAI API key  
- Select model: `gpt-4.1`  

#### Google Sheets
- Connect your Google account  
- Select your spreadsheet and sheet  

---

### 3. Update Sheet Details
Replace with your own:
- Document ID  
- Sheet Name  

---

### 4. Activate Workflow
- Enable the workflow  
- Start chatting via n8n chat  

---

## 💡 Example Use Cases

- Business analytics  
- CRM data querying  
- E-commerce tracking  
- Inventory insights  
- Internal reporting  

---

## ⚙️ Tech Stack

- n8n  
- OpenAI API  
- Google Sheets API  

---

## 🧠 How It Works

The AI Agent receives a query, fetches relevant data from Google Sheets, and responds in natural language.

Memory allows follow-ups like:
- "What about last week?"
- "Compare this with previous data"

---

## ⚠️ Limitations

- Depends on sheet structure  
- Large datasets may slow performance  
- Output quality depends on data quality  

---

## 🔒 Security Notes

- Do NOT upload API keys to GitHub  
- Use n8n credentials or environment variables  
- Restrict Google Sheets access  

---

## 📌 Future Improvements

- Write/update data in Sheets  
- Multi-sheet support  
- Role-based access  
- Dashboard integration  

---

## 🤝 Contributing

Fork it, improve it, build something useful.

---

## 📬 Contact

Built by Vishesh Allahabadi - BigDoor.ai
