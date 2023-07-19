import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/core/components/atoms/button.dart';
import 'package:salah_app/core/components/atoms/text_field.dart';
import 'package:salah_app/core/controllers/dogs_controller.dart';
import 'package:salah_app/core/utils/constants.dart';
import 'package:salah_app/features/dogs/dogs.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  TextEditingController dog = TextEditingController();

  Future<void> addDog() async {
    if (dog.text.isEmpty) return;
    await DogsController(ref).create(dog.text);
    dog.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        const Text('Hello world'),

        const SizedBox(height: lg),

        const Dogs(),

        AppTextField(text: 'Alex...', controller: dog),

        const SizedBox(height: lg),

        Button(
          onPressed: addDog,
          text: 'Add Dog',
        ),
      ],
    );
  }
}
