# Telegram Food Label Analyzer (n8n)
Test this on https://t.me/Readlabelsbot

An n8n workflow that lets a user send a photo of a packaged food label to a Telegram bot and receive:

- a plain-language nutrition assessment
- a health score
- key positives and concerns
- a pie chart showing the relative split across:
  - sugar
  - saturated fat
  - unhealthy oil
  - harmful preservatives
  - healthy components
- optional persistence to Google Sheets

## What it does

The workflow:

1. Receives an image from Telegram
2. Sends the image to OpenAI for label extraction and structured analysis
3. Parses the model response into a normalized JSON object
4. Generates a pie chart with QuickChart
5. Saves product data to Google Sheets
6. Sends the analysis and chart back to Telegram

## Workflow architecture

- **Telegram Trigger**: accepts incoming messages
- **IF Has Photo?**: checks whether the message contains an image
- **Telegram Get File**: downloads the image from Telegram
- **Code - Build OpenAI Payload**: converts the binary image to base64 and builds the OpenAI request payload
- **HTTP - OpenAI Analyze**: sends the request to the OpenAI Responses API
- **Code - Parse Analysis**: validates and normalizes the model output, then builds the chart URL
- **Google Sheets - Append Or Update**: stores product analysis in a sheet
- **Telegram - Send Analysis**: sends text analysis
- **Telegram - Send Chart**: sends the pie chart image
- **IF verdict == Not a food product**: skips the chart for non-food inputs

## Google Sheet structure

Create a sheet with these headers in row 1:

```text
product_id
product_name
brand_name
ingredients_text
nutrition_text
health_score
verdict
summary
good_points
concerning_points
risk_sugar
risk_saturated_fat
risk_unhealthy_oil
risk_harmful_preservatives
risk_healthy_components
created_at
updated_at
```

## Required services

- n8n
- Telegram Bot API
- OpenAI API
- Google Sheets API / OAuth credential
- QuickChart (used via URL, no dedicated credential required)

## Before you import

This repository contains a sanitized workflow export. You must reconfigure the following in your own n8n instance:

- Telegram credentials
- OpenAI API key
- Google Sheets credentials
- Google Sheet ID and sheet name
- any node references that differ after import

## Sensitive information removed

The shared workflow export has had the following removed or replaced:

- OpenAI API key
- Google Sheets credential identifiers
- Telegram credential identifiers
- webhook IDs
- instance IDs
- direct sheet URL identifiers

If you are publishing a workflow publicly, **always rotate any exposed key before publishing**.

## How to import

1. Open n8n
2. Import the JSON workflow file
3. Reconnect credentials
4. Update the Google Sheet target
5. Test with a food label image in Telegram

## Known limitations

- OCR and analysis depend on image quality
- product matching is basic unless enhanced
- percentages in the pie chart are relative assessment splits, not lab-measured composition percentages
- non-food labels are intentionally rejected

## Credits

Built in n8n using Telegram, OpenAI, Google Sheets, and QuickChart.
