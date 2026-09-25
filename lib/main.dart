import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(const MajeedSmartAI());

class MajeedSmartAI extends StatelessWidget {
  const MajeedSmartAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAJEED SMART AI',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F14),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF35D07F),
          brightness: Brightness.dark,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int index = 0;

  final pages = const [
    DashboardPage(),
    SignalsPage(),
    PortfolioPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B0F14),
        title: const Text(
          'MAJEED SMART AI',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF163C2A),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'PAPER',
                  style: TextStyle(
                    color: Color(0xFF52E59A),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF11161D),
        indicatorColor: const Color(0xFF214C39),
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart_outlined),
            selectedIcon: Icon(Icons.show_chart),
            label: 'Signals',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Portfolio',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      children: [
        const Text(
          'Market Overview',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Text(
          'Paper trading • Demo market data',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 16),
        Row(
          children: const [
            Expanded(
              child: IndexPriceCard(
                symbol: 'NIFTY 50',
                price: '25,000.00',
                change: '+125.40',
                percent: '+0.50%',
                trend: 'BULLISH',
                marketStatus: 'MARKET OPEN',
                lastUpdated: DateTime(2026, 9, 26, 9, 30, 15),
                values: [24780, 24820, 24805, 24870, 24840, 24910, 24890, 24955, 24920, 25000],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: IndexPriceCard(
                symbol: 'BANKNIFTY',
                price: '55,100.00',
                change: '+310.25',
                percent: '+0.57%',
                trend: 'BULLISH',
                marketStatus: 'MARKET OPEN',
                lastUpdated: DateTime(2026, 9, 26, 9, 30, 15),
                values: [54690, 54760, 54730, 54840, 54810, 54920, 54880, 55010, 54960, 55100],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          color: const Color(0xFF121922),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
            side: BorderSide(color: Colors.white.withOpacity(0.06)),
          ),
          child: const Padding(
            padding: EdgeInsets.all(18),
            child: Row(
              children: [
                Icon(Icons.psychology, size: 34, color: Color(0xFF7C8CFF)),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI Market Score', style: TextStyle(fontSize: 13, color: Colors.white60)),
                      SizedBox(height: 3),
                      Text('78 / 100', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w800)),
                      Text('Trend + momentum aligned', style: TextStyle(fontSize: 12, color: Colors.white54)),
                    ],
                  ),
                ),
                Text('BULLISH', style: TextStyle(color: Color(0xFF52E59A), fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text('Market Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Card(
          color: const Color(0xFF121922),
          elevation: 0,
          child: const ListTile(
            leading: CircleAvatar(
              backgroundColor: Color(0xFF163C2A),
              child: Icon(Icons.check_circle, color: Color(0xFF52E59A)),
            ),
            title: Text('Paper Trading Active'),
            subtitle: Text('No real orders are being placed'),
            trailing: Icon(Icons.chevron_right),
          ),
        ),
      ],
    );
  }
}

class IndexPriceCard extends StatefulWidget {
  final String symbol;
  final String widget.price;
  final String widget.change;
  final String widget.percent;
  final String widget.trend;
  final String widget.marketStatus;
  final DateTime widget.lastUpdated;
  final List<double> widget.values;

  const IndexPriceCard({
    super.key,
    required this.symbol,
    required this.widget.price,
    required this.widget.change,
    required this.widget.percent,
    required this.widget.trend,
    required this.widget.marketStatus,
    required this.widget.lastUpdated,
    required this.widget.values,
  });

  @override
  State<IndexPriceCard> createState() => _IndexPriceCardState();
}

class _IndexPriceCardState extends State<IndexPriceCard> {
  static const int refreshIntervalSeconds = 30;
  late DateTime nextRefresh;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    nextRefresh = widget.lastUpdated.add(const Duration(seconds: refreshIntervalSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (!DateTime.now().isBefore(nextRefresh)) {
          nextRefresh = DateTime.now().add(const Duration(seconds: refreshIntervalSeconds));
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatCountdown() {
    final remaining = nextRefresh.difference(DateTime.now());
    final totalSeconds = remaining.inSeconds.clamp(0, refreshIntervalSeconds);
    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final bool isOpen = widget.widget.marketStatus == 'MARKET OPEN';

    String formatTime(DateTime time) {
      final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
      final minute = time.minute.toString().padLeft(2, '0');
      final second = time.second.toString().padLeft(2, '0');
      final period = time.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute:$second $period';
    }

    return Card(
      color: const Color(0xFF121922),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: Colors.white.withOpacity(0.06)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 14, 14, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    symbol,
                    style: const TextStyle(fontSize: 13, color: Colors.white70, fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                  decoration: BoxDecoration(
                    color: isOpen ? const Color(0xFF163C2A) : const Color(0xFF33242A),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 6,
                        color: isOpen ? const Color(0xFF52E59A) : const Color(0xFFFF7A90),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isOpen ? 'OPEN' : 'CLOSED',
                        style: TextStyle(
                          color: isOpen ? const Color(0xFF52E59A) : const Color(0xFFFF7A90),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.price,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 5),
            Text(
              '$widget.change  ($widget.percent)',
              style: const TextStyle(
                color: Color(0xFF52E59A),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 7),
            SizedBox(
              height: 38,
              width: double.infinity,
              child: Sparkline(widget.values: widget.values),
            ),
            const SizedBox(height: 7),
            Row(
              children: [
                const Icon(Icons.refresh, size: 12, color: Colors.white54),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Updated ${formatTime(widget.lastUpdated)}',
                    style: const TextStyle(fontSize: 9, color: Colors.white54),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isOpen ? const Color(0xFF52E59A) : const Color(0xFFFF7A90),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  isOpen ? 'LIVE' : 'OFFLINE',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                    color: isOpen ? const Color(0xFF52E59A) : const Color(0xFFFF7A90),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.schedule, size: 11, color: Colors.white54),
                const SizedBox(width: 4),
                const Text('Next refresh', style: TextStyle(fontSize: 9, color: Colors.white54)),
                const Spacer(),
                Text(
                  formatCountdown(),
                  style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF52E59A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF163C2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                widget.trend,
                style: const TextStyle(
                  color: Color(0xFF52E59A),
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Sparkline extends StatelessWidget {
  final List<double> values;

  const Sparkline({super.key, required this.values});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SparklinePainter(values),
      child: const SizedBox.expand(),
    );
  }
}

class SparklinePainter extends CustomPainter {
  final List<double> values;

  SparklinePainter(this.values);

  @override
  void paint(Canvas canvas, Size size) {
    if (values.length < 2 || size.width <= 0 || size.height <= 0) return;

    final min = values.reduce((a, b) => a < b ? a : b);
    final max = values.reduce((a, b) => a > b ? a : b);
    final range = max - min == 0 ? 1 : max - min;

    final path = Path();
    for (var i = 0; i < values.length; i++) {
      final x = size.width * i / (values.length - 1);
      final y = size.height - ((values[i] - min) / range) * (size.height - 4) - 2;
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final paint = Paint()
      ..color = const Color(0xFF52E59A)
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant SparklinePainter oldDelegate) {
    return oldDelegate.values != values;
  }
}

class SignalsPage extends StatelessWidget {
  const SignalsPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('BUY Signal\nEntry: Demo\nSL: Demo\nT1: Demo', textAlign: TextAlign.center),
      );
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Paper Balance\n₹100000\nP&L: ₹0', textAlign: TextAlign.center),
      );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Text('Settings\nPaper Mode ON', textAlign: TextAlign.center),
      );
}
