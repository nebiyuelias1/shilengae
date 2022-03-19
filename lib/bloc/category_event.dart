part of 'category_bloc.dart';

@immutable
abstract class CategoryEvent {}

class GetCategoriesRequested extends CategoryEvent {
  final int? parentCategoryId;
  final int? previousParentId;

  GetCategoriesRequested(
      {required this.parentCategoryId, required this.previousParentId});
}

class CheckForChangesRequested extends CategoryEvent {}

class GetPreviousCategoriesRequested extends CategoryEvent {}
