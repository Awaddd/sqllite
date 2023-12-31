import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/components/atoms/text_field.dart';
import 'package:salah_app/core/utils/constants.dart';
import 'package:salah_app/models/dog.dart';
import 'package:salah_app/state/dogs_state.dart';

class Dogs extends ConsumerStatefulWidget {
  const Dogs({super.key});

  @override
  ConsumerState<Dogs> createState() => _DogsState();
}

class _DogsState extends ConsumerState<Dogs> {
  String? error;
  bool loading = true;

  Map<int, bool> editingState = {};

  @override
  void initState() {
    super.initState();
    getDogs();
  }

  Future<void> getDogs() async {
    final data = await ref.read(dogsProvider.notifier).fetchAll();
    final textEditingControllers = ref.read(dogsTextControllers.notifier);

    final Map<int, TextEditingController> controllers = {};

    for (final dog in data) {
      controllers[dog.id] = TextEditingController();
    }

    textEditingControllers.state = controllers;
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

  Future<void> deleteDog(int id) async {
    await ref.read(dogsProvider.notifier).delete(id);
  }

  @override
  Widget build(BuildContext context) {
    final dogs = ref.watch(dogsProvider);
    final textEditingControllers = ref.read(dogsTextControllers);

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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      editingState[dog.id] = true;
                    });
                  },
                  icon: const Icon(Icons.edit),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),

                //
                const SizedBox(width: sm),

                //
                IconButton(
                  onPressed: () => deleteDog(dog.id),
                  icon: const Icon(Icons.delete),
                  style: const ButtonStyle(
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                ),
              ],
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
