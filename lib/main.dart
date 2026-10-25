// 精厉害 iOS 测试应用
// 用途：验证「Windows 写代码 → GitHub Actions 云端 macOS 编译 → Sideloadly 签名装机」全链路
// 这个页面会显示设备信息，用于确认 App 真的跑在 iPhone 上
import 'package:flutter/material.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '精厉害测试',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2563EB)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('精厉害测试应用'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified, size: 72, color: Colors.green),
              const SizedBox(height: 16),
              const Text(
                '装机成功',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              _infoRow('运行平台', Platform.operatingSystem),
              _infoRow('系统版本', Platform.operatingSystemVersion),
              _infoRow('架构', _arch()),
              const SizedBox(height: 32),
              const Divider(),
              const SizedBox(height: 16),
              Text('点击次数：$_counter', style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => setState(() => _counter++),
                icon: const Icon(Icons.add),
                label: const Text('点我测试'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _arch() {
    try {
      final v = Platform.version;
      return v.contains('arm64') ? 'arm64（真机）' : 'x86_64（模拟器）';
    } catch (_) {
      return '未知';
    }
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$label：', style: const TextStyle(color: Colors.grey)),
          Flexible(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}
