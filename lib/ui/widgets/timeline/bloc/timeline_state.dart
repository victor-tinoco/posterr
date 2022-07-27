import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:posterr/domain/domain.dart';

part 'timeline_state.freezed.dart';

enum TimelineStatus { success, failure, loading }

@freezed
class TimelineState with _$TimelineState {
  const factory TimelineState({
    required TimelineStatus status,
    required List<Content> contentList,
  }) = _TimelineState;

  factory TimelineState.initial() {
    return const TimelineState(
      status: TimelineStatus.loading,
      contentList: [],
    );
  }
}
