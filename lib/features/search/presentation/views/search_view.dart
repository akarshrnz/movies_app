import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/presentation/components/error_text.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/utils/constants/app_values.dart';
import 'package:movies_app/di/service_locator.dart';
import 'package:movies_app/features/search/presentation/components/no_results.dart';
import 'package:movies_app/features/search/presentation/components/search_grid_view.dart';
import 'package:movies_app/features/search/presentation/components/search_text.dart';
import 'package:movies_app/features/search/presentation/components/search_field.dart';
import 'package:movies_app/features/search/presentation/bloc/search_bloc/search_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<SearchBloc>(),
      child: const SearchWidget(),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: AppPadding.p12,
            left: AppPadding.p16,
            right: AppPadding.p16,
          ),
          child: Column(
            children: [
              const SearchField(),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  switch (state.status) {
                    case SearchRequestStatus.empty:
                      return const SearchText();
                    case SearchRequestStatus.loading:
                      return const Expanded(child: LoadingIndicator());
                    case SearchRequestStatus.loaded:
                      return SearchGridView(results: state.searchResults);
                    case SearchRequestStatus.error:
                      return const Expanded(child: ErrorText());
                    case SearchRequestStatus.noResults:
                      return const NoResults();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
