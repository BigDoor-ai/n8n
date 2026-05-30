import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_launcher/url_launcher.dart';

const telegramUrl = String.fromEnvironment('TELEGRAM_BOT_URL');

void main() => runApp(const ClaimMateApp());

class ClaimMateApp extends StatelessWidget {
  const ClaimMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    final base = ThemeData.dark(useMaterial3: true);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ClaimMate',
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: const [
          Breakpoint(start: 0, end: 640, name: MOBILE),
          Breakpoint(start: 641, end: 1024, name: TABLET),
          Breakpoint(start: 1025, end: double.infinity, name: DESKTOP),
        ],
      ),
      theme: base.copyWith(
        scaffoldBackgroundColor: AppColors.bg,
        textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(bodyColor: Colors.white, displayColor: Colors.white),
        colorScheme: const ColorScheme.dark(primary: AppColors.blue, secondary: AppColors.cyan, surface: AppColors.card),
      ),
      home: const HomePage(),
    );
  }
}

class AppColors {
  static const bg = Color(0xff07111f);
  static const card = Color(0x99112335);
  static const border = Color(0x22ffffff);
  static const blue = Color(0xff229ed9);
  static const cyan = Color(0xff22d3ee);
  static const green = Color(0xff34d399);
  static const amber = Color(0xffffc857);
  static const red = Color(0xffff6b6b);
  static const muted = Color(0xff9fb1c7);
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int demoStep = 0;
  final scroll = ScrollController();

  void jumpTo(double y) => scroll.animateTo(y, duration: 650.ms, curve: Curves.easeOutCubic);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GlowBackdrop(),
          CustomScrollView(
            controller: scroll,
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: AppColors.bg.withOpacity(.74),
                surfaceTintColor: Colors.transparent,
                title: const BrandMark(),
                actions: [
                  if (!ResponsiveBreakpoints.of(context).smallerThan(TABLET)) ...[
                    NavButton('How it works', () => jumpTo(780)),
                    NavButton('Demo', () => jumpTo(1320)),
                    NavButton('Warranties', () => jumpTo(2060)),
                    NavButton('Claims', () => jumpTo(2860)),
                    NavButton('FAQ', () => jumpTo(4200)),
                  ],
                  Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: CtaButton(label: 'Open Bot', compact: true),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    HeroSection(step: demoStep, onDemo: () => jumpTo(1320)),
                    HowSection(onStepTap: (i) => setState(() => demoStep = i)),
                    InteractiveDemo(step: demoStep, onStep: (i) => setState(() => demoStep = i)),
                    DashboardSection(),
                    ClaimSection(),
                    WhySection(),
                    TrustSection(),
                    FaqSection(),
                    FinalCta(),
                    const Footer(),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GlowBackdrop extends StatelessWidget {
  const GlowBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(color: AppColors.bg),
      const Positioned(top: -160, left: -120, child: Glow(size: 420, color: AppColors.blue)),
      const Positioned(top: 100, right: -120, child: Glow(size: 360, color: AppColors.cyan)),
      const Positioned(bottom: -180, left: 120, child: Glow(size: 380, color: AppColors.green)),
    ]);
  }
}

class Glow extends StatelessWidget {
  final double size;
  final Color color;
  const Glow({super.key, required this.size, required this.color});
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(.13)),
        child: BackdropFilter(filter: ImageFilter.blur(sigmaX: 90, sigmaY: 90), child: const SizedBox()),
      );
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key});
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
          height: 38,
          width: 38,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), gradient: const LinearGradient(colors: [AppColors.blue, AppColors.cyan])),
          child: const Icon(Icons.verified_user_rounded, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text('ClaimMate', style: GoogleFonts.spaceGrotesk(fontWeight: FontWeight.w800, fontSize: 22)),
      ]);
}

class NavButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const NavButton(this.text, this.onTap, {super.key});
  @override
  Widget build(BuildContext context) => TextButton(onPressed: onTap, child: Text(text, style: const TextStyle(color: AppColors.muted)));
}

class Section extends StatelessWidget {
  final Widget child;
  final double top;
  const Section({super.key, required this.child, this.top = 96});
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.fromLTRB(20, top, 20, 0),
        child: Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 1180), child: child)),
      );
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const GlassCard({super.key, required this.child, this.padding = const EdgeInsets.all(24)});
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.border),
              boxShadow: [BoxShadow(color: AppColors.blue.withOpacity(.08), blurRadius: 40, offset: const Offset(0, 24))],
            ),
            child: child,
          ),
        ),
      );
}

class CtaButton extends StatelessWidget {
  final String label;
  final bool compact;
  const CtaButton({super.key, this.label = 'Open Telegram Bot', this.compact = false});
  Future<void> _open() async {
    if (telegramUrl.trim().isEmpty) return;
    await launchUrl(Uri.parse(telegramUrl), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final disabled = telegramUrl.trim().isEmpty;
    return FilledButton.icon(
      onPressed: disabled ? null : _open,
      icon: const Icon(Icons.send_rounded, size: 18),
      label: Text(disabled ? 'Bot URL missing' : label),
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 24, vertical: compact ? 12 : 18),
        backgroundColor: AppColors.blue,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.white12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  final int step;
  final VoidCallback onDemo;
  const HeroSection({super.key, required this.step, required this.onDemo});

  @override
  Widget build(BuildContext context) {
    final mobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    final copy = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white12)),
        child: const Text('AI warranty tracker + claim assistant', style: TextStyle(color: AppColors.cyan, fontWeight: FontWeight.w700)),
      ),
      const SizedBox(height: 24),
      Text('Never lose a valid warranty claim again.', style: GoogleFonts.spaceGrotesk(fontSize: mobile ? 46 : 72, height: .95, fontWeight: FontWeight.w900)),
      const SizedBox(height: 22),
      const Text('Upload bills. Track warranties. Draft claims. Follow up with AI.', style: TextStyle(fontSize: 20, height: 1.55, color: AppColors.muted)),
      const SizedBox(height: 30),
      Wrap(spacing: 14, runSpacing: 14, children: [
        const CtaButton(),
        OutlinedButton.icon(
          onPressed: onDemo,
          icon: const Icon(Icons.play_arrow_rounded),
          label: const Text('See Demo'),
          style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 18), foregroundColor: Colors.white, side: const BorderSide(color: Colors.white24), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
        )
      ]),
      const SizedBox(height: 26),
      const Wrap(spacing: 12, runSpacing: 12, children: [
        TrustPill(icon: Icons.lock_rounded, text: 'User approval first'),
        TrustPill(icon: Icons.receipt_long_rounded, text: 'Indian invoice friendly'),
        TrustPill(icon: Icons.shield_rounded, text: 'Private by design'),
      ])
    ]).animate().fadeIn(duration: 700.ms).slideY(begin: .12, end: 0);

    final visual = Stack(clipBehavior: Clip.none, children: [
      AnimatedPhone(step: step),
      const Positioned(top: 26, left: -40, child: FloatingTag(icon: Icons.document_scanner_rounded, text: 'Invoice detected')),
      const Positioned(top: 140, right: -38, child: FloatingTag(icon: Icons.verified_rounded, text: 'Warranty active')),
      const Positioned(bottom: 92, left: -34, child: FloatingTag(icon: Icons.edit_document, text: 'Claim email drafted')),
      const Positioned(bottom: 12, right: -24, child: FloatingTag(icon: Icons.how_to_reg_rounded, text: 'Approval required')),
    ]).animate().fadeIn(duration: 800.ms, delay: 150.ms).scale(begin: const Offset(.94, .94));

    return Section(
      top: 76,
      child: mobile ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [copy, const SizedBox(height: 48), Center(child: visual)]) : Row(children: [Expanded(child: copy), const SizedBox(width: 52), Expanded(child: Center(child: visual))]),
    );
  }
}

class TrustPill extends StatelessWidget {
  final IconData icon;
  final String text;
  const TrustPill({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(color: Colors.white.withOpacity(.07), borderRadius: BorderRadius.circular(999), border: Border.all(color: Colors.white12)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 17, color: AppColors.green), const SizedBox(width: 8), Text(text, style: const TextStyle(color: AppColors.muted))]),
      );
}

class FloatingTag extends StatelessWidget {
  final IconData icon;
  final String text;
  const FloatingTag({super.key, required this.icon, required this.text});
  @override
  Widget build(BuildContext context) => GlassCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: AppColors.cyan, size: 18), const SizedBox(width: 8), Text(text, style: const TextStyle(fontWeight: FontWeight.w800))]),
      ).animate(onPlay: (c) => c.repeat(reverse: true)).moveY(begin: -5, end: 5, duration: 2100.ms, curve: Curves.easeInOut);
}

class AnimatedPhone extends StatelessWidget {
  final int step;
  const AnimatedPhone({super.key, required this.step});
  @override
  Widget build(BuildContext context) {
    final messages = [
      ['Here is my Samsung TV bill', 'I found the invoice. Reading product details...'],
      ['What did you extract?', 'Product: Samsung 55 inch TV\nWarranty: active till 11 May 2026'],
      ['Save it for me', 'Done. Added to your warranty dashboard.'],
      ['My TV is not powering on', 'The warranty is active. This issue appears claim-ready.'],
      ['Draft the claim email', 'Draft ready. You can review before sending.'],
      ['Approve and send', 'Approved. Email queued to Samsung support.'],
      ['Track the claim', 'Claim status: follow-up scheduled. I will keep the record updated.'],
    ];
    final pair = messages[step.clamp(0, messages.length - 1)];
    return Container(
      width: 340,
      height: 650,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xff081421), borderRadius: BorderRadius.circular(44), border: Border.all(color: Colors.white24, width: 1.4), boxShadow: [BoxShadow(color: AppColors.cyan.withOpacity(.2), blurRadius: 60)]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(34),
        child: Container(
          color: const Color(0xff0b1828),
          child: Column(children: [
            Container(height: 64, padding: const EdgeInsets.symmetric(horizontal: 18), color: Colors.white.withOpacity(.06), child: const Row(children: [CircleAvatar(backgroundColor: AppColors.blue, child: Icon(Icons.smart_toy_rounded, color: Colors.white)), SizedBox(width: 12), Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [Text('ClaimMate', style: TextStyle(fontWeight: FontWeight.w900)), Text('online', style: TextStyle(color: AppColors.green, fontSize: 12))])])),
            Expanded(
              child: AnimatedSwitcher(
                duration: 450.ms,
                child: Padding(
                  key: ValueKey(step),
                  padding: const EdgeInsets.all(18),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    ChatBubble(text: pair[0], user: true),
                    const SizedBox(height: 14),
                    const BillMiniCard(),
                    const SizedBox(height: 14),
                    ChatBubble(text: pair[1], user: false),
                    const Spacer(),
                    ProgressStatus(step: step),
                  ]).animate().fadeIn(duration: 350.ms).slideX(begin: .08, end: 0),
                ),
              ),
            ),
            Container(margin: const EdgeInsets.all(14), padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12), decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(18)), child: const Row(children: [Text('Message', style: TextStyle(color: AppColors.muted)), Spacer(), Icon(Icons.send_rounded, color: AppColors.blue)])),
          ]),
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool user;
  const ChatBubble({super.key, required this.text, required this.user});
  @override
  Widget build(BuildContext context) => Align(
        alignment: user ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 250),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: user ? AppColors.blue : Colors.white.withOpacity(.09), borderRadius: BorderRadius.circular(18)),
          child: Text(text, style: TextStyle(color: user ? Colors.white : Colors.white.withOpacity(.92), height: 1.35)),
        ),
      );
}

class BillMiniCard extends StatelessWidget {
  const BillMiniCard({super.key});
  @override
  Widget build(BuildContext context) => Align(
        alignment: Alignment.centerRight,
        child: Container(
          width: 190,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.receipt_long_rounded, color: AppColors.blue), SizedBox(height: 10), Text('Reliance Digital', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900)), SizedBox(height: 7), FakeLine(width: 130), FakeLine(width: 100), FakeLine(width: 150)]),
        ),
      );
}

class FakeLine extends StatelessWidget {
  final double width;
  const FakeLine({super.key, required this.width});
  @override
  Widget build(BuildContext context) => Container(margin: const EdgeInsets.only(top: 5), width: width, height: 6, decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)));
}

class ProgressStatus extends StatelessWidget {
  final int step;
  const ProgressStatus({super.key, required this.step});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(color: Colors.white.withOpacity(.07), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Claim pipeline', style: TextStyle(fontWeight: FontWeight.w900)),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: (step + 1) / 7, color: AppColors.green, backgroundColor: Colors.white12, minHeight: 8, borderRadius: BorderRadius.circular(999)),
          const SizedBox(height: 10),
          Text('${step + 1}/7 steps complete', style: const TextStyle(color: AppColors.muted, fontSize: 12)),
        ]),
      );
}

class SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String body;
  const SectionTitle({super.key, required this.eyebrow, required this.title, required this.body});
  @override
  Widget build(BuildContext context) => Column(children: [
        Text(eyebrow.toUpperCase(), style: const TextStyle(color: AppColors.cyan, fontWeight: FontWeight.w900, letterSpacing: 1.6)),
        const SizedBox(height: 12),
        Text(title, textAlign: TextAlign.center, style: GoogleFonts.spaceGrotesk(fontSize: ResponsiveBreakpoints.of(context).smallerThan(TABLET) ? 34 : 48, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        ConstrainedBox(constraints: const BoxConstraints(maxWidth: 680), child: Text(body, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, fontSize: 17, height: 1.55))),
      ]);
}

class HowSection extends StatelessWidget {
  final ValueChanged<int> onStepTap;
  const HowSection({super.key, required this.onStepTap});
  @override
  Widget build(BuildContext context) => Section(
        child: Column(children: [
          const SectionTitle(eyebrow: 'How it works', title: 'A bill becomes an actionable claim.', body: 'ClaimMate turns boring warranty paperwork into a guided workflow. Revolutionary, because apparently keeping receipts was too much for civilization.'),
          const SizedBox(height: 34),
          GridWrap(children: List.generate(3, (i) {
            final items = [
              (Icons.cloud_upload_rounded, 'Upload bill', 'Send a bill, invoice, warranty card, or product document.'),
              (Icons.auto_awesome_rounded, 'AI extracts warranty', 'Product, date, seller, brand, warranty status, and claim readiness.'),
              (Icons.mark_email_read_rounded, 'Approve claim email', 'ClaimMate drafts. You review. Nothing goes out without approval.'),
            ];
            final item = items[i];
            return StepCard(icon: item.$1, title: item.$2, text: item.$3, number: i + 1, onTap: () => onStepTap(i));
          })),
        ]),
      );
}

class GridWrap extends StatelessWidget {
  final List<Widget> children;
  const GridWrap({super.key, required this.children});
  @override
  Widget build(BuildContext context) {
    final mobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    return Wrap(spacing: 20, runSpacing: 20, children: children.map((c) => SizedBox(width: mobile ? double.infinity : 360, child: c)).toList());
  }
}

class StepCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final int number;
  final VoidCallback? onTap;
  const StepCard({super.key, required this.icon, required this.title, required this.text, required this.number, this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: GlassCard(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Icon(icon, color: AppColors.cyan, size: 34), const Spacer(), Text('0$number', style: GoogleFonts.spaceGrotesk(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white24))]),
            const SizedBox(height: 22),
            Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
            const SizedBox(height: 10),
            Text(text, style: const TextStyle(color: AppColors.muted, height: 1.5)),
          ]),
        ),
      ).animate().fadeIn().slideY(begin: .12, end: 0);
}

class InteractiveDemo extends StatelessWidget {
  final int step;
  final ValueChanged<int> onStep;
  const InteractiveDemo({super.key, required this.step, required this.onStep});
  @override
  Widget build(BuildContext context) {
    final steps = ['Upload bill', 'Extract details', 'Update dashboard', 'Report issue', 'Draft email', 'Approve', 'Track follow-up'];
    final mobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    return Section(
      child: GlassCard(
        padding: const EdgeInsets.all(30),
        child: mobile
            ? Column(children: [_demoCopy(steps), const SizedBox(height: 28), AnimatedPhone(step: step)])
            : Row(children: [Expanded(child: _demoCopy(steps)), const SizedBox(width: 34), AnimatedPhone(step: step)]),
      ),
    );
  }

  Widget _demoCopy(List<String> steps) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Interactive product demo', style: GoogleFonts.spaceGrotesk(fontSize: 42, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        const Text('Click a step and watch the assistant state change. A landing page doing actual work, shocking development.', style: TextStyle(color: AppColors.muted, fontSize: 17, height: 1.5)),
        const SizedBox(height: 26),
        ...List.generate(steps.length, (i) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () => onStep(i),
                borderRadius: BorderRadius.circular(18),
                child: AnimatedContainer(
                  duration: 250.ms,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(color: step == i ? AppColors.blue.withOpacity(.22) : Colors.white.withOpacity(.05), borderRadius: BorderRadius.circular(18), border: Border.all(color: step == i ? AppColors.cyan : Colors.white12)),
                  child: Row(children: [CircleAvatar(radius: 15, backgroundColor: step == i ? AppColors.cyan : Colors.white12, child: Text('${i + 1}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 12))), const SizedBox(width: 12), Expanded(child: Text(steps[i], style: const TextStyle(fontWeight: FontWeight.w800))), if (step == i) const Icon(Icons.arrow_forward_rounded, color: AppColors.cyan)]),
                ),
              ),
            )),
      ]);
}

class DashboardSection extends StatelessWidget {
  DashboardSection({super.key});
  final products = const [
    ('Samsung 55" 4K UHD TV', 'Samsung', '11 May 2026', 'Active', AppColors.green),
    ('OnePlus 11R 5G', 'OnePlus', '27 Aug 2025', 'Active', AppColors.green),
    ('LG 7.5kg Front Load', 'LG', '09 Nov 2025', 'Expiring Soon', AppColors.amber),
    ('Dell Inspiron 3520', 'Dell', '14 Feb 2025', 'Expired', AppColors.red),
  ];
  @override
  Widget build(BuildContext context) => Section(
        child: Column(children: [
          const SectionTitle(eyebrow: 'Warranty dashboard', title: 'Everything you own, finally organized.', body: 'A clean warranty control room for bills, expiry dates, products, and claim readiness.'),
          const SizedBox(height: 34),
          GlassCard(
            child: Column(children: [
              Wrap(spacing: 14, runSpacing: 14, children: const [MetricCard('Active', '8', AppColors.green), MetricCard('Expiring', '2', AppColors.amber), MetricCard('Expired', '2', AppColors.red), MetricCard('Claims', '3', AppColors.cyan), MetricCard('Potential saved', '₹42K', AppColors.blue)]),
              const SizedBox(height: 24),
              Wrap(spacing: 10, runSpacing: 10, children: ['All', 'Active', 'Expiring Soon', 'Expired', 'Claim-ready'].map((x) => Chip(label: Text(x), backgroundColor: x == 'All' ? AppColors.blue.withOpacity(.3) : Colors.white10, side: const BorderSide(color: Colors.white12))).toList()),
              const SizedBox(height: 22),
              ...products.map((p) => ProductRow(name: p.$1, brand: p.$2, expiry: p.$3, status: p.$4, color: p.$5)),
            ]),
          )
        ]),
      );
}

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const MetricCard(this.label, this.value, this.color, {super.key});
  @override
  Widget build(BuildContext context) => Container(width: 190, padding: const EdgeInsets.all(18), decoration: BoxDecoration(color: Colors.white.withOpacity(.06), borderRadius: BorderRadius.circular(22), border: Border.all(color: Colors.white12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: GoogleFonts.spaceGrotesk(fontSize: 30, fontWeight: FontWeight.w900, color: color)), const SizedBox(height: 4), Text(label, style: const TextStyle(color: AppColors.muted))]));
}

class ProductRow extends StatelessWidget {
  final String name, brand, expiry, status;
  final Color color;
  const ProductRow({super.key, required this.name, required this.brand, required this.expiry, required this.status, required this.color});
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white.withOpacity(.045), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white10)),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withOpacity(.18), borderRadius: BorderRadius.circular(14)), child: Icon(Icons.inventory_2_rounded, color: color)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w900)), Text('$brand • expires $expiry', style: const TextStyle(color: AppColors.muted, fontSize: 13))])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: color.withOpacity(.18), borderRadius: BorderRadius.circular(999)), child: Text(status, style: TextStyle(color: color, fontWeight: FontWeight.w900))),
        ]),
      );
}

class ClaimSection extends StatelessWidget {
  const ClaimSection({super.key});
  @override
  Widget build(BuildContext context) {
    final mobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
    final chat = GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('User issue', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)), SizedBox(height: 18), ChatBubble(text: 'My Samsung TV is not powering on.', user: true), SizedBox(height: 14), ChatBubble(text: 'Warranty is active. I can draft a claim email for your approval.', user: false)]));
    final email = GlassCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('AI drafted claim email', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
      const SizedBox(height: 18),
      const EmailField('To', 'support@samsung.com'),
      const EmailField('Subject', 'Warranty Claim - Samsung 55" 4K UHD TV'),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white.withOpacity(.06), borderRadius: BorderRadius.circular(18)), child: const Text('Dear Samsung Support Team,\n\nI am requesting warranty support for my Samsung 55" 4K UHD TV. The product is within warranty and the TV is not powering on. Invoice details are attached.\n\nPlease share the next steps for claim processing.', style: TextStyle(height: 1.55, color: AppColors.muted))),
      const SizedBox(height: 18),
      Wrap(spacing: 12, runSpacing: 12, children: [OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.edit_rounded), label: const Text('Edit')), const CtaButton(label: 'Approve & Send', compact: true), OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.track_changes_rounded), label: const Text('Track Claim'))]),
      const SizedBox(height: 12),
      const Text('No claim email is sent without your approval.', style: TextStyle(color: AppColors.green, fontWeight: FontWeight.w800)),
    ]));
    return Section(child: Column(children: [const SectionTitle(eyebrow: 'Claims', title: 'The annoying email writes itself.', body: 'ClaimMate drafts a clean, brand-ready claim email while keeping the user in control.'), const SizedBox(height: 34), mobile ? Column(children: [chat, const SizedBox(height: 20), email]) : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: chat), const SizedBox(width: 20), Expanded(child: email)])]));
  }
}

class EmailField extends StatelessWidget {
  final String label, value;
  const EmailField(this.label, this.value, {super.key});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 12), child: Row(children: [SizedBox(width: 70, child: Text(label, style: const TextStyle(color: AppColors.muted))), Expanded(child: Container(padding: const EdgeInsets.all(13), decoration: BoxDecoration(color: Colors.white.withOpacity(.06), borderRadius: BorderRadius.circular(14)), child: Text(value)))]));
}

class WhySection extends StatelessWidget {
  const WhySection({super.key});
  @override
  Widget build(BuildContext context) => Section(child: Column(children: [
        const SectionTitle(eyebrow: 'Why it exists', title: 'Because warranties should not die in drawers.', body: 'Bills get lost, dates are forgotten, brand processes are tedious, and valid claims get abandoned.'),
        const SizedBox(height: 34),
        GridWrap(children: const [
          StepCard(icon: Icons.folder_off_rounded, title: 'Bills get lost', text: 'Receipts vanish exactly when needed.', number: 1),
          StepCard(icon: Icons.timer_off_rounded, title: 'Warranty dates expire', text: 'People remember too late. Naturally.', number: 2),
          StepCard(icon: Icons.support_agent_rounded, title: 'Claims are painful', text: 'ClaimMate keeps the follow-up moving.', number: 3),
        ])
      ]));
}

class TrustSection extends StatelessWidget {
  const TrustSection({super.key});
  @override
  Widget build(BuildContext context) => Section(child: Column(children: [
        const SectionTitle(eyebrow: 'Trust', title: 'Built for control, not chaos.', body: 'Clear boundaries, simple approvals, and transparent product status.'),
        const SizedBox(height: 34),
        GridWrap(children: const [
          StepCard(icon: Icons.how_to_reg_rounded, title: 'You approve every email', text: 'Drafting is automated. Sending requires approval.', number: 1),
          StepCard(icon: Icons.lock_rounded, title: 'Secure document handling', text: 'Designed for private invoice and warranty records.', number: 2),
          StepCard(icon: Icons.flag_rounded, title: 'Built for Indian bills', text: 'Structured around Indian retailers, brands, and invoice patterns.', number: 3),
          StepCard(icon: Icons.telegram_rounded, title: 'Telegram MVP', text: 'Start from Telegram while WhatsApp support is developed.', number: 4),
          StepCard(icon: Icons.chat_rounded, title: 'WhatsApp coming soon', text: 'The final mass-market channel for normal humans.', number: 5),
          StepCard(icon: Icons.gavel_rounded, title: 'Not legal advice', text: 'It helps draft and track claims. It is not a lawyer.', number: 6),
        ])
      ]));
}

class FaqSection extends StatelessWidget {
  FaqSection({super.key});
  final faqs = const [
    ('Is ClaimMate a legal advisor?', 'No. It helps draft emails and track warranties. It is not legal or insurance advice.'),
    ('Will ClaimMate send emails automatically?', 'No. The user reviews and approves before anything is sent.'),
    ('What documents can I upload?', 'Bills, invoices, warranty cards, and product documents.'),
    ('Is WhatsApp available?', 'The MVP starts on Telegram. WhatsApp is planned next.'),
    ('What happens after approval?', 'The claim email can be sent and tracked through status updates.'),
    ('Does it work for Indian invoices?', 'The product is designed around Indian bills, retailers, and consumer appliance claims.'),
  ];
  @override
  Widget build(BuildContext context) => Section(child: Column(children: [
        const SectionTitle(eyebrow: 'FAQ', title: 'Questions before the obvious panic.', body: 'The basics, minus the corporate fog machine.'),
        const SizedBox(height: 30),
        ...faqs.map((f) => Padding(padding: const EdgeInsets.only(bottom: 12), child: GlassCard(padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), child: Theme(data: Theme.of(context).copyWith(dividerColor: Colors.transparent), child: ExpansionTile(tilePadding: EdgeInsets.zero, title: Text(f.$1, style: const TextStyle(fontWeight: FontWeight.w900)), children: [Align(alignment: Alignment.centerLeft, child: Padding(padding: const EdgeInsets.only(bottom: 16), child: Text(f.$2, style: const TextStyle(color: AppColors.muted, height: 1.5))))]))))),
      ]));
}

class FinalCta extends StatelessWidget {
  const FinalCta({super.key});
  @override
  Widget build(BuildContext context) => Section(child: GlassCard(padding: const EdgeInsets.all(38), child: Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Start with your next bill.', style: GoogleFonts.spaceGrotesk(fontSize: 44, fontWeight: FontWeight.w900)), const SizedBox(height: 10), const Text('Upload. Track. Claim. Done.', style: TextStyle(color: AppColors.muted, fontSize: 18))])), const CtaButton()])),;
}

class Footer extends StatelessWidget {
  const Footer({super.key});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.all(34), child: Text('ClaimMate is an independent product and is not affiliated with any brand or company.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white.withOpacity(.55))));
}
