import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/components/atoms/button.dart';
import 'package:salah_app/components/atoms/text_field.dart';
import 'package:salah_app/core/utils/constants.dart';
import 'package:salah_app/features/dogs/dogs.dart';
import 'package:salah_app/state/dogs_state.dart';
import 'package:salah_app/state/state.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  TextEditingController dog = TextEditingController();

  Future<void> addDog() async {
    if (dog.text.isEmpty) return;
    final id = await ref.read(dogsProvider.notifier).create(dog.text);
    dog.clear();
    FocusManager.instance.primaryFocus?.unfocus();

    final textEditingControllers = ref.read(dogsTextControllers.notifier);
    textEditingControllers.state[id] = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //
        const Text('Hello world'),

        const SizedBox(height: lg),

        const Dogs(),

        const SizedBox(height: lg),

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
