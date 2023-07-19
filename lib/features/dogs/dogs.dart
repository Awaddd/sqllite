import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/core/components/atoms/text_field.dart';
import 'package:salah_app/core/state/dogs_state.dart';
import 'package:salah_app/core/utils/constants.dart';
import 'package:salah_app/models/dog.dart';

class Dogs extends ConsumerStatefulWidget {
  const Dogs({super.key});

  @override
  ConsumerState<Dogs> createState() => _DogsState();
}

class _DogsState extends ConsumerState<Dogs> {
  String? error;
  bool loading = true;

  Map<int, bool> editingState = {};
  Map<int, TextEditingController> textEditingControllers = {};

  @override
  void initState() {
    super.initState();
    getDogs();
  }

  Future<void> getDogs() async {
    final data = await ref.read(dogsProvider.notifier).fetchAll();
    final Map<int, TextEditingController> controllers = {};

    for (final dog in data) {
      controllers[dog.id] = TextEditingController();
    }

    setState(() {
      textEditingControllers = controllers;
    });
  }

  Future<void> updateDog(int id, String name) async {
    await ref.read(dogsProvider.notifier).update(id, name);

    setState(() {
      editingState[id] = false;
    });
  }

  void close(int id) {
    setState(() {
      editingState[id] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dogs = ref.watch(dogsProvider);

    return Expanded(
      child: ListView.separated(
        itemCount: dogs.length,
        separatorBuilder: (context, index) => const SizedBox(height: sm),
        itemBuilder: (context, index) {
          if (dogs.isEmpty) return null;

          final Dog dog = dogs[index];

          if (editingState[dog.id] != null && editingState[dog.id] == true) {
            final controller = textEditingControllers[dog.id];

            if (controller == null) return null;

            return EditDog(
              dog: dog,
              controller: controller,
              close: close,
              update: updateDog,
            );
          }

          return ListTile(
            title: Text(dog.name),
            tileColor: Theme.of(context).colorScheme.secondary,
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  editingState[dog.id] = true;
                });
              },
              icon: const Icon(Icons.edit),
              style: const ButtonStyle(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              // padding: EdgeInsets.zero,
              // constraints: const BoxConstraints(),
            ),
          );
        },
      ),
    );
  }
}

class EditDog extends StatelessWidget {
  const EditDog({
    super.key,
    required this.dog,
    required this.controller,
    required this.close,
    required this.update,
  });

  final Dog dog;
  final TextEditingController controller;
  final void Function(int id) close;
  final void Function(int id, String name) update;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        Expanded(
          child: AppTextField(
            text: dog.name,
            controller: controller,
          ),
        ),

        const SizedBox(width: sm),

        IconButton(
          onPressed: () => close(dog.id),
          icon: const Icon(Icons.close),
        ),

        IconButton(
          onPressed: () async {
            update(dog.id, controller.text);
            // controller.clear();
          },
          icon: const Icon(Icons.done),
        )
      ],
    );
  }
}
