import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posterr/domain/domain.dart';
import 'package:posterr/ui/pages/home/bloc/timeline_event.dart';
import 'package:posterr/ui/pages/home/bloc/timeline_state.dart';

// TODO(victor-tinoco): Provide tests for this bloc.
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc({
    required this.getTimelineContent,
  }) : super(TimelineState.initial()) {
    on<ContentsFetchedTimelineEvent>(_onContentsFetched);
  }

  final GetTimelineContent getTimelineContent;

  Future<void> _onContentsFetched(ContentsFetchedTimelineEvent event, Emitter<TimelineState> emit) async {
    emit(state.copyWith(status: TimelineStatus.loading));

    final result = await getTimelineContent();

    result.when(
      data: (list) => emit(TimelineState(status: TimelineStatus.success, contentList: list)),
      failure: (_) => emit(state.copyWith(status: TimelineStatus.failure)),
    );
  }
}
