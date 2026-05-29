import React from 'react';
import { createRoot } from 'react-dom/client';
import {
  ArrowRight,
  Bot,
  Check,
  CircleCheck,
  Clock3,
  CloudUpload,
  Edit3,
  FileCheck2,
  FileText,
  FolderOpen,
  LockKeyhole,
  Mail,
  MessageCircle,
  Play,
  Send,
  ShieldCheck,
  Sparkles,
  WalletCards,
  Zap
} from 'lucide-react';
import './styles.css';

const telegramUrl = import.meta.env.VITE_TELEGRAM_BOT_URL?.trim() || '#';
const telegramConfigured = telegramUrl !== '#';
const botCtaLabel = telegramConfigured
  ? 'Open Telegram Bot'
  : 'Open Telegram Bot - Telegram URL not configured';

function TelegramCta({ className = '', children = 'Open Telegram Bot' }) {
  return (
    <a className={`btn btn-primary ${className}`} href={telegramUrl} aria-label={botCtaLabel}>
      <Send size={18} strokeWidth={2.4} />
      <span>{children}</span>
    </a>
  );
}

function Logo() {
  return (
    <a className="logo" href="#top" aria-label="ClaimMate home">
      <span className="logo-mark" aria-hidden="true">
        <Bot size={22} strokeWidth={2.6} />
      </span>
      <span>ClaimMate</span>
    </a>
  );
}

function Header() {
  return (
    <header className="site-header">
      <nav className="nav-shell" aria-label="Main navigation">
        <Logo />
        <div className="nav-links">
          <a href="#how">How it works</a>
          <a href="#warranties">Warranties</a>
          <a href="#claims">Claims</a>
          <a href="#faq">FAQ</a>
        </div>
        <TelegramCta className="nav-cta">Open Bot</TelegramCta>
      </nav>
    </header>
  );
}

function ReceiptArt() {
  return (
    <div className="paper-stack" aria-hidden="true">
      <div className="paper-card paper-card-large">
        <span className="store-name">Croma</span>
        <span>TAX INVOICE</span>
        <i />
        <i />
        <i />
        <i />
        <strong>Samsung TV</strong>
      </div>
      <div className="paper-card warranty-card">
        <span>SAMSUNG</span>
        <strong>WARRANTY CARD</strong>
        <i />
        <i />
        <i />
      </div>
    </div>
  );
}

function PhonePreview() {
  return (
    <div className="hero-visual" aria-label="ClaimMate chat preview">
      <ReceiptArt />
      <div className="phone-shell">
        <div className="phone-top">
          <span className="phone-notch" />
        </div>
        <div className="chat-header">
          <span className="chat-avatar">
            <Bot size={18} strokeWidth={2.6} />
          </span>
          <div>
            <strong>ClaimMate</strong>
            <small>bot</small>
          </div>
          <CircleCheck className="chat-verified" size={18} />
        </div>
        <div className="chat-thread">
          <div className="bubble bubble-user">
            <span>Here's my Samsung TV bill</span>
            <div className="bill-thumb">
              <FileText size={20} />
              <strong>Reliance Digital</strong>
              <i />
              <i />
              <i />
            </div>
          </div>
          <div className="bubble bubble-bot">
            <span>Thanks. I extracted the details.</span>
            <dl>
              <div>
                <dt>Product</dt>
                <dd>Samsung 55" 4K UHD TV</dd>
              </div>
              <div>
                <dt>Invoice Date</dt>
                <dd>12 May 2024</dd>
              </div>
              <div>
                <dt>Warranty Expires</dt>
                <dd className="green">11 May 2026</dd>
              </div>
              <div>
                <dt>Claim Status</dt>
                <dd className="green">Claim-ready</dd>
              </div>
            </dl>
          </div>
          <div className="bubble bubble-bot bubble-question">
            Would you like me to draft a claim email to Samsung?
            <div className="chat-actions">
              <button>Yes, draft it</button>
              <button>Not now</button>
            </div>
          </div>
        </div>
        <div className="chat-input">
          <button>Menu</button>
          <span>Message</span>
          <Send size={15} />
        </div>
      </div>
    </div>
  );
}

function Hero() {
  return (
    <section className="hero section" id="top">
      <div className="hero-copy">
        <h1>ClaimMate</h1>
        <p>
          Stop losing money to forgotten warranties and abandoned claims. Send your bill to
          ClaimMate and let AI track, remind, and draft the claim for you.
        </p>
        <div className="hero-actions">
          <TelegramCta />
          <a className="btn btn-secondary" href="#how">
            <Play size={17} strokeWidth={2.5} />
            <span>See how it works</span>
          </a>
        </div>
        <div className="trust-row" aria-label="ClaimMate trust signals">
          <span>
            <ShieldCheck size={19} />
            Secure & private
          </span>
          <span>
            <Zap size={19} />
            AI that understands Indian bills
          </span>
          <span>
            <Check size={19} />
            You approve, we send
          </span>
        </div>
      </div>
      <PhonePreview />
    </section>
  );
}

const steps = [
  {
    icon: CloudUpload,
    title: 'Upload bill',
    text: 'Send a bill, invoice, warranty card, or product document on Telegram.'
  },
  {
    icon: FileCheck2,
    title: 'AI extracts warranty',
    text: 'ClaimMate reads the details, tracks expiry, and keeps your record ready.'
  },
  {
    icon: Mail,
    title: 'Approve claim email',
    text: 'When something breaks, review the draft and choose when to send.'
  }
];

const valueItems = [
  {
    icon: FolderOpen,
    title: 'Saved documents',
    text: 'Never search for bills again.'
  },
  {
    icon: ShieldCheck,
    title: 'Warranty status',
    text: "Know what's active and what's expiring."
  },
  {
    icon: Edit3,
    title: 'Drafts in seconds',
    text: 'AI writes the claim. You stay in control.'
  },
  {
    icon: LockKeyhole,
    title: 'Explicit approval',
    text: 'No email is sent without your approval.'
  }
];

function HowItWorks() {
  return (
    <section className="section section-tight" id="how">
      <p className="center-note">Trusted by Indian households to never miss a claim again.</p>
      <h2>How it works</h2>
      <div className="steps-grid">
        {steps.map((step, index) => {
          const Icon = step.icon;
          return (
            <article className="step-item" key={step.title}>
              <span className="step-icon">
                <Icon size={31} strokeWidth={1.9} />
              </span>
              <div className="step-title">
                <span>{index + 1}</span>
                <h3>{step.title}</h3>
              </div>
              <p>{step.text}</p>
            </article>
          );
        })}
      </div>
      <div className="value-strip">
        {valueItems.map((item) => {
          const Icon = item.icon;
          return (
            <div className="value-item" key={item.title}>
              <Icon size={38} strokeWidth={1.8} />
              <div>
                <strong>{item.title}</strong>
                <span>{item.text}</span>
              </div>
            </div>
          );
        })}
      </div>
    </section>
  );
}

const products = [
  ['Samsung 55" 4K UHD TV', 'Samsung', '12 May 2024', '11 May 2026', 'Active'],
  ['OnePlus 11R 5G', 'OnePlus', '28 Aug 2023', '27 Aug 2025', 'Active'],
  ['LG 7.5kg Front Load', 'LG', '10 Nov 2023', '09 Nov 2025', 'Expiring Soon'],
  ['Dell Inspiron 3520', 'Dell', '15 Feb 2023', '14 Feb 2025', 'Expired']
];

function DashboardPreview() {
  return (
    <article className="feature-panel" id="warranties">
      <div className="feature-heading">
        <div>
          <h2>Your warranty dashboard</h2>
          <p>All your products. One simple view.</p>
        </div>
        <button className="ghost-action">+ Add New</button>
      </div>
      <div className="tabs" aria-label="Warranty filters">
        <button className="active">All (12)</button>
        <button>Active (8)</button>
        <button>Expiring Soon (2)</button>
        <button>Expired (2)</button>
      </div>
      <div className="product-table" role="table" aria-label="Saved warranties">
        <div className="table-row table-head" role="row">
          <span>Product</span>
          <span>Brand</span>
          <span>Purchase Date</span>
          <span>Warranty Expiry</span>
          <span>Status</span>
        </div>
        {products.map((product) => (
          <div className="table-row" role="row" key={product[0]}>
            <span className="product-name">
              <span className="product-thumb">
                <WalletCards size={17} />
              </span>
              {product[0]}
            </span>
            <span>{product[1]}</span>
            <span>{product[2]}</span>
            <span>{product[3]}</span>
            <span>
              <i className={`status status-${product[4].toLowerCase().replaceAll(' ', '-')}`}>
                {product[4]}
              </i>
            </span>
          </div>
        ))}
      </div>
      <a className="panel-link" href="#claims">
        View all warranties <ArrowRight size={16} />
      </a>
    </article>
  );
}

function ClaimDraftPreview() {
  return (
    <article className="feature-panel" id="claims">
      <div className="feature-heading">
        <div>
          <h2>Claim email, drafted for you</h2>
          <p>We write. You review. You send.</p>
        </div>
      </div>
      <div className="email-preview">
        <label>
          <span>To</span>
          <input readOnly value="support@samsung.com" />
        </label>
        <label>
          <span>Subject</span>
          <input readOnly value="Request for Warranty Claim - Samsung 55&quot; 4K UHD TV" />
        </label>
        <div className="email-body">
          <p>Dear Samsung Support Team,</p>
          <p>I am writing to request a warranty claim for my Samsung 55&quot; 4K UHD TV.</p>
          <strong>Product Details:</strong>
          <ul>
            <li>Model: UASSAU7700KXXL</li>
            <li>Invoice Date: 12 May 2024</li>
            <li>Warranty: 2 Years, valid till 11 May 2026</li>
          </ul>
          <strong>Issue:</strong>
          <p>The TV is not powering on. I have attached the invoice and product photos.</p>
          <p>Please let me know the next steps.</p>
        </div>
        <div className="email-actions">
          <button className="btn btn-secondary btn-small">
            <Edit3 size={16} />
            Edit
          </button>
          <TelegramCta className="btn-small">Approve & Send</TelegramCta>
        </div>
      </div>
    </article>
  );
}

function Features() {
  return (
    <section className="section feature-grid">
      <DashboardPreview />
      <ClaimDraftPreview />
    </section>
  );
}

const faqs = [
  {
    icon: ShieldCheck,
    title: 'Not legal or insurance advice',
    text: 'We help draft emails and track warranties.'
  },
  {
    icon: LockKeyhole,
    title: 'No email sent without approval',
    text: 'You review and approve every email.'
  },
  {
    icon: Send,
    title: 'MVP on Telegram',
    text: 'Start using ClaimMate on Telegram.'
  },
  {
    icon: MessageCircle,
    title: 'WhatsApp coming soon',
    text: "We're working on WhatsApp support."
  },
  {
    icon: CircleCheck,
    title: 'Your data is secure',
    text: "We don't sell your data. Ever."
  },
  {
    icon: Sparkles,
    title: 'Built for India',
    text: 'Understands Indian bills and brands.'
  }
];

function Faq() {
  return (
    <section className="section section-tight faq-section" id="faq">
      <h2>Questions you might have</h2>
      <div className="faq-grid">
        {faqs.map((item) => {
          const Icon = item.icon;
          return (
            <article className="faq-item" key={item.title}>
              <Icon size={34} strokeWidth={1.8} />
              <h3>{item.title}</h3>
              <p>{item.text}</p>
            </article>
          );
        })}
      </div>
    </section>
  );
}

function FinalCta() {
  return (
    <section className="section final-cta" aria-label="Start using ClaimMate">
      <div>
        <h2>Start with your next bill.</h2>
        <p>Upload. Track. Claim. Done.</p>
      </div>
      <TelegramCta />
    </section>
  );
}

function App() {
  return (
    <>
      <Header />
      <main>
        <Hero />
        <HowItWorks />
        <Features />
        <Faq />
        <FinalCta />
      </main>
      <footer>
        ClaimMate is an independent product and is not affiliated with any brand or company.
      </footer>
    </>
  );
}

createRoot(document.getElementById('root')).render(<App />);
