import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_cubit.dart';
import 'product_state.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return BlocProvider(
      create: (_) => ProductCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search & Filter'),
          actions: [
            Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () {
                    searchController.clear();
                    context.read<ProductCubit>().reset();
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      labelText: 'Search products...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      context.read<ProductCubit>().updateSearch(value);
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  return DropdownButton<String>(
                    value: state.selectedCategory,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'all',
                        child: Text('All Categories'),
                      ),
                      DropdownMenuItem(
                        value: 'electronics',
                        child: Text('Electronics'),
                      ),
                      DropdownMenuItem(
                        value: 'furniture',
                        child: Text('Furniture'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ProductCubit>().changeCategory(value);
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 12),

              Expanded(
                child: BlocBuilder<ProductCubit, ProductState>(
                  builder: (context, state) {
                    if (state.visibleProducts.isEmpty) {
                      return const Center(child: Text('No products found!'));
                    }
                    return ListView.builder(
                      itemCount: state.visibleProducts.length,
                      itemBuilder: (context, index) {
                        final parts = state.visibleProducts[index].split('|');
                        return Card(
                          child: ListTile(
                            title: Text(parts[0].trim()),
                            subtitle: Text(parts[1].trim()),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
