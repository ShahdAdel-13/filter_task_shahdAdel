class ProductState {
final List<String> allProducts;
final List<String> visibleProducts;
final String selectedCategory;
final String searchQuery;

const ProductState ({
required
 this. allProducts,
  required this.visibleProducts,
   required this. selectedCategory,
this.searchQuery = '',
});
ProductState copyWith ( {
List<String>? allProducts,
List<String>? visibleProducts,
String? selectedCategory,
String? searchQuery,
} )
{
return ProductState (
allProducts: allProducts ?? this. allProducts,
 visibleProducts: visibleProducts ?? this. visibleProducts, 
 selectedCategory: selectedCategory ?? this.selectedCategory,
 searchQuery: searchQuery ?? this.searchQuery,
) ;
}
}