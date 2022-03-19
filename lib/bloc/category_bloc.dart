import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:meta/meta.dart';

import '../apis.dart';
import '../models.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends HydratedBloc<CategoryEvent, CategoryState> {
  final BuildContext context;
  final api = Apis();

  CategoryBloc(this.context) : super(const CategoryState()) {
    on<CheckForChangesRequested>((event, emit) async {
      _showSnackBarMessage('Checking version');
      emit(state.copyWith(apiVersionLoadingStatus: LoadingStatus.loading));

      final version = await api.getApiVersion();
      final didChange = version > state.apiVersion;
      _showSnackBarMessage('Did version change: $didChange');
      if (didChange) {
        emit(state.copyWith(status: LoadingStatus.loading));

        final list = await api.fetchCategoriesList();

        emit(state.copyWith(categories: list, status: LoadingStatus.loaded));
        _showSnackBarMessage('Fetched data remote data source.');
      } else {
        _showSnackBarMessage('Fetched data from cache.');
      }

      emit(
        state.copyWith(
          apiVersionLoadingStatus: LoadingStatus.loaded,
          selectedCategories: _filterCategories(null),
          apiVersion: version,
        ),
      );
    });
    on<GetCategoriesRequested>((event, emit) async {
      emit(state.copyWith(status: LoadingStatus.loading));

      final list = _filterCategories(event.parentCategoryId);

      emit(
        state.copyWith(
          selectedCategories: list,
          status: LoadingStatus.loaded,
          parentIdsStack: [...state.parentIdsStack, event.previousParentId],
        ),
      );
    });
    on<GetPreviousCategoriesRequested>((event, emit) async {
      emit(state.copyWith(status: LoadingStatus.loading));

      final parentId = state.parentIdsStack.removeLast();
      final list = _filterCategories(parentId);

      emit(
        state.copyWith(
          selectedCategories: list,
          status: LoadingStatus.loaded,
        ),
      );
    });
  }

  @override
  CategoryState? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('categories') && json.containsKey('version')) {
      final categories = json['categories']
          .map<Category>((e) => Category.fromJson(e))
          .toList();
      return CategoryState(
          status: LoadingStatus.loaded,
          apiVersionLoadingStatus: LoadingStatus.loaded,
          apiVersion: json['version'],
          categories: categories);
    }

    return null;
  }

  @override
  Map<String, dynamic>? toJson(CategoryState state) {
    if (state.status == LoadingStatus.loaded) {
      return {
        'categories': state.categories.map((e) => e.toJson()).toList(),
        'version': state.apiVersion
      };
    }

    return null;
  }

  List<Category> _filterCategories(int? parentCategoryId) {
    return state.categories
        .where((element) => element.parentCategoryId == parentCategoryId)
        .toList();
  }

  void _showSnackBarMessage(String s) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(s)));
  }
}
