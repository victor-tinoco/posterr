import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posterr/domain/domain.dart';
import 'package:posterr/ui/pages/home/bloc/timeline_event.dart';
import 'package:posterr/ui/pages/home/bloc/timeline_state.dart';

// TODO(victor-tinoco): Provide tests for this bloc.
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc({
    required this.getTimelineContent,
    required this.sharePost,
  }) : super(TimelineState.initial()) {
    on<ContentsFetchedTimelineEvent>(_onContentsFetched);
    on<PostSharedTimelineEvent>(_onPostShared);
  }

  final GetTimelineContent getTimelineContent;
  final SharePost sharePost;

  Future<void> _onContentsFetched(ContentsFetchedTimelineEvent event, Emitter<TimelineState> emit) async {
    emit(state.copyWith(status: TimelineStatus.loading));

    final result = await getTimelineContent();

    result.when(
      data: (list) => emit(TimelineState(status: TimelineStatus.success, contentList: list)),
      failure: (_) => emit(state.copyWith(status: TimelineStatus.failure)),
    );
  }

  Future<void> _onPostShared(PostSharedTimelineEvent event, Emitter<TimelineState> emit) async {
    final result = await sharePost(event.message);

    result.whenOrNull(
      // TODO(victor-tinoco): Improve this way to re-fetch contents, since I think
      // that a bloc should not emit a state. We should do a separated bloc for the
      // post sharing, and managem them through screen.
      success: () => add(const ContentsFetchedTimelineEvent()),
    );
  }
}
