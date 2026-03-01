import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'navigation_provider.g.dart';

/// Provider to track the current navigation tab index.
/// This is used to notify widgets when the user switches tabs,
/// allowing them to refresh their data.
@Riverpod(keepAlive: true)
class CurrentTabIndex extends _$CurrentTabIndex {
  @override
  int build() => 0;

  void setIndex(int index) {
    state = index;
  }
}
