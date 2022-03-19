part of 'category_bloc.dart';

enum LoadingStatus { initial, loading, loaded, failed }

@immutable
class CategoryState {
  final LoadingStatus status;
  final LoadingStatus apiVersionLoadingStatus;
  final List<Category> categories;
  final List<Category> selectedCategories;
  final int apiVersion;
  final List<int?> parentIdsStack;

  const CategoryState({
    this.status = LoadingStatus.initial,
    this.apiVersionLoadingStatus = LoadingStatus.initial,
    this.categories = const [],
    this.selectedCategories = const [],
    this.parentIdsStack = const [],
    this.apiVersion = -1,
  });

  CategoryState copyWith(
      {LoadingStatus? status,
      List<Category>? categories,
      List<Category>? selectedCategories,
      int? apiVersion,
      LoadingStatus? apiVersionLoadingStatus,
      List<int?>? parentIdsStack}) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      apiVersion: apiVersion ?? this.apiVersion,
      apiVersionLoadingStatus:
          apiVersionLoadingStatus ?? this.apiVersionLoadingStatus,
      parentIdsStack: parentIdsStack ?? this.parentIdsStack,
    );
  }
}
