# 📄 PDF Summary Automation (n8n Workflow)

## 🧠 Overview

This workflow automates the process of extracting, summarizing, and storing insights from PDF documents.

Users upload a document via a form, and the system:
- Extracts text from the PDF  
- Generates a structured summary using AI  
- Enhances context using Wikipedia  
- Stores the output in Google Sheets  

---

## 🎯 Use Case

This workflow is useful for:
- Researchers summarizing reports  
- Founders reviewing documents quickly  
- Teams processing large volumes of PDFs  
- Knowledge management systems  

---

## ⚙️ Workflow Breakdown

### 1. Form Submission Trigger
- User uploads a PDF via an n8n form  
- Captures:
  - File (PDF)
  - Submission timestamp  

---

### 2. PDF Text Extraction
- Extracts raw text from the uploaded PDF file  

---

### 3. AI-Based Summarization
- Sends extracted text to OpenAI (GPT-4.1)  
- Generates:
  - Concise summary  
  - Additional contextual insights  

**Prompt Used:**
Summarize the text: {{ $json.text }}

Use Wikipedia to search additional information about the subject and present it under a specific header - WikiKnowHow


---

### 4. Knowledge Enrichment (Wikipedia Tool)
- Fetches additional information from Wikipedia  
- Improves understanding of the topic  

---

### 5. Store Output in Google Sheets
- Appends results to a spreadsheet with:
  - Title (file name)
  - Summary
  - Date added  

---

## 🏗️ Tech Stack

- n8n (workflow automation)  
- OpenAI API (text summarization)  
- Wikipedia API (knowledge enrichment)  
- Google Sheets API (data storage)  

---

## 📊 Output Format

Each processed document generates a row in Google Sheets:

| Title | Summary | Date Added |
|------|--------|------------|
| File Name | AI-generated summary | YYYY-MM-DD |

---

## 🔒 Security Considerations

- API credentials are not included in this repository  
- Sensitive data should be handled via n8n credential manager  
- Avoid uploading confidential documents unless using a secure environment  

---

## 🚀 How to Use

1. Import the workflow JSON into n8n  
2. Configure:
   - OpenAI API credentials  
   - Google Sheets credentials  
3. Activate the workflow  
4. Share the form link  
5. Upload documents for automated summarization  

---

## 🧩 Potential Improvements

- Add email delivery of summaries  
- Enable batch document processing  
- Store outputs in a database instead of Sheets  
- Improve prompt for structured summaries (bullet points, action items)  

---

## 💡 Business Applications

- SaaS tool for document summarization  
- Internal knowledge processing system  
- AI assistant for consultants, analysts, and research teams  

---

## 📁 Workflow File

See the workflow JSON: PDF-RAG-Summary.json (https://github.com/BigDoor-ai/n8n/blob/main/workflows/PDF-RAG-Summary.json)
