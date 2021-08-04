import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/search_bloc/search_event.dart';
import 'package:real_estate/data/network/repository/search_repository.dart';

class SearchBloc extends Bloc<SearchEvent, BaseState> {

  SearchBloc(this._searchRepository) : super(const BaseInitial());

  final SearchRepository _searchRepository;

  @override
  Stream<BaseState> mapEventToState(SearchEvent event) async*  {
    if (event is GetSearchEvent) {
      try {
        yield const BaseLoading();
        final mList = await _searchRepository.getPosts();
        yield BaseLoaded(mList);
      } on Error {
        yield const BaseError(1, "message");
      }
    }
  }
}
