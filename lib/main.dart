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

class IndexPriceCard extends StatelessWidget {
  final String symbol;
  final String price;
  final String change;
  final String percent;
  final String trend;
  final List<double> values;

  const IndexPriceCard({
    super.key,
    required this.symbol,
    required this.price,
    required this.change,
    required this.percent,
    required this.trend,
    required this.values,
  });

  @override
  Widget build(BuildContext context) {
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
                const Icon(Icons.trending_up, color: Color(0xFF52E59A), size: 21),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              price,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 5),
            Text(
              '$change  ($percent)',
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
              child: Sparkline(values: values),
            ),
            const SizedBox(height: 7),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF163C2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                trend,
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
