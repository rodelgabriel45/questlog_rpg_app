import 'package:flutter/material.dart';

class CreateQuestScreen extends StatelessWidget {
  const CreateQuestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Quest'), centerTitle: true),
      body: const Center(child: Text('Create Quest')),
    );
  }
}
