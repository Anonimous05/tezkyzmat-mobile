import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';

class HideTalkerScreen extends StatefulWidget {
  const HideTalkerScreen({
    super.key,
    required this.talker,
  });
  final Talker talker;

  @override
  State<HideTalkerScreen> createState() => _HideTalkerScreenState();
}

class _HideTalkerScreenState extends State<HideTalkerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TalkerScreen(talker: widget.talker),
    );
  }
}
