import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}