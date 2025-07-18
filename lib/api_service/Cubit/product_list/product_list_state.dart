part of 'product_list_cubit.dart';

@immutable
sealed class ProductListState {}

final class ProductListInitial extends ProductListState {}

final class ProductListLoading extends ProductListState {}

final class ProductListLoaded extends ProductListState {
  final ProductModel productModel;
  ProductListLoaded(this.productModel);
}

final class ProductListNetworkError extends ProductListState {}

final class ProductListModelError extends ProductListState {}