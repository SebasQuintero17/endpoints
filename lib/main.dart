// lib/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/providers.dart';
import 'services/api_service.dart';

class HomeScreen extends ConsumerWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dataAsyncValue = ref.watch(dataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('API Data')),
      body: Center(
        child: dataAsyncValue.when(
          data: (list) {
            // Verifica si la lista está vacía
            if (list.isEmpty) {
              return const Text('No data available');
            }
            // Si hay datos, los muestra en una lista
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(list[index]),
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, stack) => Text('Error: $e'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await apiService.fetchDataAndStore();
          ref.refresh(
              dataProvider); 
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
