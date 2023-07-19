import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salah_app/models/dog.dart';

final dogsProvider = StateNotifierProvider<DogsNotifier, List<Dog>>((ref) {
  return DogsNotifier(ref);
});

class DogsNotifier extends StateNotifier<List<Dog>> {
  DogsNotifier(this.ref) : super([]);

  final Ref ref;

  void load() {}
}
