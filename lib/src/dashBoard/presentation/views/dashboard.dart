import 'package:flutter/material.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});
  static const routeName = '/dashboard';
  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DashBoard'),
      ),
    );
  }
}
