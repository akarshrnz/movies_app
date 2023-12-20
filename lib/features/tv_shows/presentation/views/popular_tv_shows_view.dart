import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media.dart';
import 'package:movies_app/core/presentation/components/custom_app_bar.dart';
import 'package:movies_app/core/presentation/components/error_screen.dart';
import 'package:movies_app/core/presentation/components/loading_indicator.dart';
import 'package:movies_app/core/presentation/components/vertical_listview.dart';
import 'package:movies_app/core/presentation/components/vertical_listview_card.dart';
import 'package:movies_app/core/utils/constants/app_strings.dart';
import 'package:movies_app/features/tv_shows/presentation/bloc/popular_tv_shows_bloc/popular_tv_shows_bloc.dart';
import 'package:movies_app/di/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';

class PopularTVShowsView extends StatelessWidget {
  const PopularTVShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          locator<PopularTVShowsBloc>()..add(GetPopularTVShowsEvent()),
      child: Scaffold(
        appBar: const CustomAppBar(
          title: AppStrings.popularShows,
        ),
        body: BlocBuilder<PopularTVShowsBloc, PopularTVShowsState>(
          builder: (context, state) {
            switch (state.status) {
              case GetAllRequestStatus.loading:
                return const LoadingIndicator();
              case GetAllRequestStatus.loaded:
                return PopularTVShowsWidget(tvShows: state.tvShows);
              case GetAllRequestStatus.error:
                return ErrorScreen(
                  onTryAgainPressed: () {
                    context
                        .read<PopularTVShowsBloc>()
                        .add(GetPopularTVShowsEvent());
                  },
                );
              case GetAllRequestStatus.fetchMoreError:
                return PopularTVShowsWidget(tvShows: state.tvShows);
            }
          },
        ),
      ),
    );
  }
}

class PopularTVShowsWidget extends StatelessWidget {
  const PopularTVShowsWidget({
    super.key,
    required this.tvShows,
  });

  final List<Media> tvShows;

  @override
  Widget build(BuildContext context) {
    return VerticalListView(
      itemCount: tvShows.length + 1,
      itemBuilder: (context, index) {
        if (index < tvShows.length) {
          return VerticalListViewCard(media: tvShows[index]);
        } else {
          return const LoadingIndicator();
        }
      },
      addEvent: () {
        context.read<PopularTVShowsBloc>().add(FetchMorePopularTVShowsEvent());
      },
    );
  }
}
