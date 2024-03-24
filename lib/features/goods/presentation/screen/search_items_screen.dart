import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/network/authrization.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/goods/goods_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/app_bar_widget.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/empty_list.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/error_snackbar.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/filter_search.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/itemWidget/lost_item.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/search_filter.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;

class SearchItemsScreen extends StatefulWidget {
  const SearchItemsScreen({Key? key}) : super(key: key);

  @override
  State<SearchItemsScreen> createState() => _SearchItemsScreenState();
}

class _SearchItemsScreenState extends State<SearchItemsScreen> {
  List<LostItem> searchList = [];

  final _scrollController = ScrollController();

  late GoodsBloc _goodsBloc;

  bool isInit = false;

  ItemType selectedButton = ItemType.BOTH;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _goodsBloc = di.sl<GoodsBloc>()
      ..add(const GetSearchItemsEvent(
          search: Search(name: '', date: '', location: '', categoryId: '')));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) {
        _goodsBloc.add(EmptyEvent());
      },
      child: Scaffold(
          appBar: AppBarWidget(
              appBar: AppBar(),
              title: 'Search items',
              leading: BackButton(
                onPressed: () {
                  _goodsBloc.add(EmptyEvent());
                  Navigator.pop(context);
                },
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return SearchFilterDialog();
                },
              ).then((value) => value != null
                  ? _goodsBloc.add(GetSearchItemsEvent(search: value))
                  : null);
            },
            child: const Icon(Icons.search_outlined),
          ),
          body: BlocConsumer<GoodsBloc, GoodsState>(
            bloc: _goodsBloc,
            listener: (context, state) {
              if (state is ErrorGoodsState) {
                showSuccessSnackBar(context, state.message, Colors.red);
                if (state.message == Authorization_FAILURE_MESSAGE) {
                  logout(context);
                }
              }
            },
            builder: (context, state) {
              if (state is LoadingGoodsState) {
                isInit = false;
                return Center(
                    child: CircularProgressIndicator(
                        color: ColorsFave.primaryColor));
              } else if (state is GetLostItemsSuccessState) {
                if (!isInit) {
                  searchList = selectedButton == ItemType.BOTH
                      ? state.items.reversed.toList()
                      : selectedButton == ItemType.LOST
                          ? state.items.reversed
                              .where((element) => element.isLost == true)
                              .toList()
                          : state.items.reversed
                              .where((element) => element.isLost == false)
                              .toList();
                  isInit = true;
                }

                return searchList.isEmpty
                    ? Column(
                        children: [
                          Row(
                            children: [
                              FilterButton(
                                buttonType: ItemType.BOTH,
                                selectedButton: selectedButton,
                                onTap: () {
                                  setState(() {
                                    searchList = state.items.reversed.toList();
                                    selectedButton = ItemType.BOTH;
                                  });
                                },
                              ),
                              FilterButton(
                                buttonType: ItemType.LOST,
                                selectedButton: selectedButton,
                                onTap: () {
                                  setState(() {
                                    searchList = state.items.reversed
                                        .where(
                                            (element) => element.isLost == true)
                                        .toList();
                                    selectedButton = ItemType.LOST;
                                  });
                                },
                              ),
                              FilterButton(
                                buttonType: ItemType.FOUND,
                                selectedButton: selectedButton,
                                onTap: () {
                                  setState(() {
                                    searchList = state.items.reversed
                                        .where((element) =>
                                            element.isLost == false)
                                        .toList();
                                    selectedButton = ItemType.FOUND;
                                  });
                                },
                              ),
                            ],
                          ),
                          const Expanded(child: EmptyListWidget()),
                        ],
                      )
                    : Column(
                        children: [
                          Row(
                            children: [
                              FilterButton(
                                buttonType: ItemType.BOTH,
                                selectedButton: selectedButton,
                                onTap: () {
                                  setState(() {
                                    searchList = state.items.reversed.toList();
                                    selectedButton = ItemType.BOTH;
                                  });
                                },
                              ),
                              FilterButton(
                                buttonType: ItemType.LOST,
                                selectedButton: selectedButton,
                                onTap: () {
                                  setState(() {
                                    searchList = state.items.reversed
                                        .where(
                                            (element) => element.isLost == true)
                                        .toList();
                                    selectedButton = ItemType.LOST;
                                  });
                                },
                              ),
                              FilterButton(
                                buttonType: ItemType.FOUND,
                                selectedButton: selectedButton,
                                onTap: () {
                                  setState(() {
                                    searchList = state.items.reversed
                                        .where((element) =>
                                            element.isLost == false)
                                        .toList();
                                    selectedButton = ItemType.FOUND;
                                  });
                                },
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: ListView.builder(
                                key: const ValueKey('lost_page_list_key'),
                                controller: _scrollController,
                                itemCount: searchList.length,
                                itemBuilder: (context, index) {
                                  var item = searchList[index];

                                  return LostListItem(
                                      key: ValueKey(item.id),
                                      lostItem: item,
                                      onTap: (item) {
                                        Navigator.pushNamed(context,
                                            Constants.ItemDetailsScreen,
                                            arguments: item);
                                      });
                                },
                              ),
                            ),
                          ),
                        ],
                      );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.search_outlined,
                        size: 60, color: ColorsFave.primaryColor),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Click search to found items',
                        style: GoogleFonts.lato(fontSize: 20),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
