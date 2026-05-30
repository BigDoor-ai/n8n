# ClaimMate Flutter Web

Animated Flutter Web microsite and product demo for ClaimMate.

## What this is

This is a separate Flutter Web version of the ClaimMate website. It does not replace the existing React/Vite site in `workflows/claimmate/website`.

## Features

- Premium dark SaaS-style landing page
- Animated phone mockup
- Interactive 7-step claim journey
- Warranty dashboard preview
- AI claim email preview
- Trust, FAQ, and final CTA sections
- Responsive desktop, tablet, and mobile layout
- Telegram bot CTA configured by Dart define

## Run locally

```bash
cd workflows/claimmate/website-flutter
flutter pub get
flutter run -d chrome --dart-define=TELEGRAM_BOT_URL=https://t.me/your_bot
```

## Build

```bash
flutter build web --dart-define=TELEGRAM_BOT_URL=https://t.me/your_bot
```

## Notes

If `TELEGRAM_BOT_URL` is not provided, CTA buttons show a missing URL state instead of opening a broken link.

ClaimMate is an independent product and is not affiliated with any brand or company.
