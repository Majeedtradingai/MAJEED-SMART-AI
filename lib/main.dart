import 'package:flutter/material.dart';

void main() => runApp(const MajeedSmartAI());

class MajeedSmartAI extends StatelessWidget {
  const MajeedSmartAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAJEED SMART AI',
      theme: ThemeData.dark(useMaterial3: true),
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

  final pages = const [DashboardPage(), SignalsPage(), PortfolioPage(), SettingsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MAJEED SMART AI V2')),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.show_chart), label: 'Signals'),
          NavigationDestination(icon: Icon(Icons.account_balance_wallet), label: 'Portfolio'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: const [
      Card(child: ListTile(title: Text('NIFTY'), subtitle: Text('Demo: 25000'))),
      Card(child: ListTile(title: Text('Market Trend'), subtitle: Text('Bullish'))),
      Card(child: ListTile(title: Text('AI Score'), subtitle: Text('78/100'))),
      Card(child: ListTile(title: Text('Mode'), subtitle: Text('Paper Trading'))),
    ],
  );
}

class SignalsPage extends StatelessWidget {
  const SignalsPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('BUY Signal\nEntry: Demo\nSL: Demo\nT1: Demo', textAlign: TextAlign.center));
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Paper Balance\n₹100000\nP&L: ₹0', textAlign: TextAlign.center));
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Settings\nPaper Mode ON', textAlign: TextAlign.center));
}
