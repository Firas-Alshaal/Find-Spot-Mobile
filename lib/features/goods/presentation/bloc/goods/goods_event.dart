part of 'goods_bloc.dart';

abstract class GoodsEvent extends Equatable {
  const GoodsEvent();

  @override
  List<Object> get props => [];
}

class AddLostItemEvent extends GoodsEvent {
  final LostItem lostItem;
  final ItemType itemType;

  const AddLostItemEvent({required this.lostItem, required this.itemType});

  @override
  List<Object> get props => [lostItem, itemType];
}

class GetLostItemsEvent extends GoodsEvent {
  final ItemType itemType;

  const GetLostItemsEvent({required this.itemType});

  @override
  List<Object> get props => [itemType];
}

class GetSearchItemsEvent extends GoodsEvent {
  final Search search;

  const GetSearchItemsEvent({required this.search});

  @override
  List<Object> get props => [search];
}

class EmptyEvent extends GoodsEvent {
  @override
  List<Object> get props => [];
}
