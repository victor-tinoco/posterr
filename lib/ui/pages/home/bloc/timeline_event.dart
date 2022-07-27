import 'package:freezed_annotation/freezed_annotation.dart';

part 'timeline_event.freezed.dart';

@freezed
class TimelineEvent with _$TimelineEvent {
  const factory TimelineEvent.contentsFetched() = ContentsFetchedTimelineEvent;
}
