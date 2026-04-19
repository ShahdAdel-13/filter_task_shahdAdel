import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit()
    : super(
        const ProductState(
          allProducts: [
            'Phone | electronics',
            'Mouse | electronics',
            'Chair | furniture',
            'Laptop | electronics',
            'Table | furniture',
          ],
          visibleProducts: [
            'Phone | electronics',
            'Mouse | electronics',
            'Chair | furniture',
            'Laptop | electronics',
            'Table | furniture',
          ],
          selectedCategory: 'all',
        ),
      );

  void updateSearch(String query) {
    _applyFilters(state.selectedCategory, query);
  }

  void changeCategory(String category) {
    _applyFilters(category, state.searchQuery);
  }

  void _applyFilters(String category, String query) {
    final filtered = state.allProducts.where((item) {
      final matchesCategory =
          category == 'all' ||
          item.toLowerCase().endsWith(category.toLowerCase());
      final matchesSearch = item.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    emit(
      state.copyWith(
        selectedCategory: category,
        searchQuery: query,
        visibleProducts: filtered,
      ),
    );
  }

  void reset() {
    emit(
      state.copyWith(
        selectedCategory: 'all',
        searchQuery: '',
        visibleProducts: state.allProducts,
      ),
    );
  }
}
