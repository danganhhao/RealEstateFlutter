import 'package:equatable/equatable.dart';
import 'package:real_estate/data/models/search_engine/request/search_request.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class GetSearchEvent extends SearchEvent {
  final SearchRequest data;
  final int page;

  GetSearchEvent({required this.data, required this.page});

  @override
  List<Object>? get props => null;
}
