import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/core/controllers/application_controller.dart';
import 'package:salah_app/data/cat.dart';

class Cats extends ConsumerStatefulWidget {
  const Cats({super.key});

  @override
  ConsumerState<Cats> createState() => _CatsState();
}

class _CatsState extends ConsumerState<Cats> {
  List<Cat> cats = [];
  String? error;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getCats();
  }

  Future<void> getCats() async {
    try {
      final data = await ApplicationController(ref).getAllCats();

      setState(() {
        cats = data;
        loading = false;
      });
    } catch (err) {
      setState(() {
        error = 'Unexpected error ${err.toString}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (error != null) return const Text('error');

    if (loading) {
      return const Expanded(
        child: Text('loading...'),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: cats.length,
        itemBuilder: (context, index) {
          if (cats.isEmpty) return null;

          final Cat cat = cats[index];

          return ListTile(
            title: Text(cat.name),
          );
        },
      ),
    );
  }
}
