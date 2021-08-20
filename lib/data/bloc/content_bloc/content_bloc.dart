import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:real_estate/data/bloc/base_state.dart';
import 'package:real_estate/data/bloc/content_bloc/content_event.dart';
import 'package:real_estate/data/network/repository/content_repository.dart';

class ContentBloc extends Bloc<ContentEvent, BaseState> {
  ContentBloc(this._contentRepository) : super(const BaseInitial());

  final ContentRepository _contentRepository;

  @override
  Stream<BaseState> mapEventToState(ContentEvent event) async* {
    try {
      if (event is GetCityInfoEvent) {
        yield const BaseLoading();
        final mList = await _contentRepository.getCityInfo();
        yield BaseLoaded(mList);
      }
      if (event is GetEstateTypeEvent) {
        yield const BaseLoading();
        final mList = await _contentRepository.getEstateType();
        yield BaseLoaded(mList);
      }
    } on Error {
      yield const BaseError(1, "message");
    }
  }
}
