import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/core/controllers/dogs_controller.dart';
import 'package:salah_app/models/dog.dart';

final dogsProvider = StateNotifierProvider<DogsNotifier, List<Dog>>((ref) {
  return DogsNotifier(ref);
});

class DogsNotifier extends StateNotifier<List<Dog>> {
  DogsNotifier(this.ref) : super([]);

  final Ref ref;

  Future<List<Dog>> fetchAll() async {
    final dogs = await DogsController(ref).fetchAll();
    return state = dogs;
  }

  Future<Dog> fetch(int id) async {
    return DogsController(ref).fetch(id);
  }

  Future<void> create(String name) async {
    final controller = DogsController(ref);
    final id = await controller.create(name);
    final dog = await controller.fetch(id);

    final dogs = state.toList();
    dogs.add(dog);
    state = dogs;
  }

  Future<void> update(int id, String name) async {
    final controller = DogsController(ref);
    await controller.update(id, name);
    final dog = await controller.fetch(id);
    state[id - 1] = dog;
  }
}
