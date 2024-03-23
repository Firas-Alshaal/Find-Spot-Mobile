import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lost_find_tracker/core/network/authrization.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/search.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/goods/goods_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/app_bar_widget.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/empty_list.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/error_snackbar.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/lost_item.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/search_filter.dart';
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
                return Center(
                    child: CircularProgressIndicator(
                        color: ColorsFave.primaryColor));
              } else if (state is GetLostItemsSuccessState) {
                searchList = state.items;
                return searchList.isEmpty
                    ? const EmptyListWidget()
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: ListView.builder(
                          key: const ValueKey('lost_page_list_key'),
                          controller: _scrollController,
                          itemCount: searchList.length,
                          itemBuilder: (context, index) {
                            final item = searchList[index];
                            return LostListItem(
                                key: ValueKey(item.id),
                                lostItem: item,
                                onTap: (item) {
                                  Navigator.pushNamed(
                                      context, Constants.ItemDetailsScreen,
                                      arguments: item);
                                });
                          },
                        ),
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
