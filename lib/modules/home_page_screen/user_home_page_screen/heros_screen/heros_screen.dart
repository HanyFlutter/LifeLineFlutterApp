import 'package:flutter/material.dart';

class HerosScreen extends StatefulWidget {
  const HerosScreen({super.key});

  @override
  State<HerosScreen> createState() => _HerosScreenState();
}

class _HerosScreenState extends State<HerosScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('HerosScreen'),);
  }
}
