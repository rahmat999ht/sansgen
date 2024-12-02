import 'package:flutter/material.dart';

import '../widgets/book_empty.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: bookEmpty('Data kosong ...', height: 170),
    );
  }
}
