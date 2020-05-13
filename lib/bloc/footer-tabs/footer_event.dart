import 'package:equatable/equatable.dart';
import 'package:etc/models/models.dart';

abstract class FooterEvent extends Equatable {
  const FooterEvent();
}

class TabUpdated extends FooterEvent {
  final AppTab tab;

  const TabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}