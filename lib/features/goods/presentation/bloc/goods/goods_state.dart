part of 'goods_bloc.dart';

abstract class GoodsState extends Equatable {
  const GoodsState();

  @override
  List<Object> get props => [];
}

class GoodsInitial extends GoodsState {}

class LoadingGoodsState extends GoodsState {}

class AddGoodsSuccessState extends GoodsState {
  @override
  List<Object> get props => [];
}

class GetLostItemsSuccessState extends GoodsState {
  final List<LostItem> items;

  const GetLostItemsSuccessState({required this.items});

  @override
  List<Object> get props => [];
}

class ErrorGoodsState extends GoodsState {
  final String message;

  const ErrorGoodsState({required this.message});

  @override
  List<Object> get props => [message];
}
