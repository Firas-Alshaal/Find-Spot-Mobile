import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lost_find_tracker/core/network/authrization.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/strings/failures.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/itemType.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/presentation/bloc/goods/goods_bloc.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/app_bar_widget.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/empty_list.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/error_snackbar.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/lost_item.dart';
import 'package:lost_find_tracker/injection_container.dart' as di;

class FoundItemsScreen extends StatelessWidget {
  FoundItemsScreen({Key? key}) : super(key: key);

  final _scrollController = ScrollController();

  List<LostItem> list = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<GoodsBloc>()
        ..add(const GetLostItemsEvent(itemType: ItemType.FOUND)),
      child: Scaffold(
        appBar: AppBarWidget(appBar: AppBar(), title: 'Found items'),
        body: BlocConsumer<GoodsBloc, GoodsState>(
          listener: (context, state) {
            if (state is ErrorGoodsState) {
              showSuccessSnackBar(context, state.message, Colors.red);
              if (state.message == Authorization_FAILURE_MESSAGE) {
                logout(context);
              }
            }
          },
          builder: (context, state) {
            if (state is GetLostItemsSuccessState) {
              list = state.items;
              return Padding(
                padding: const EdgeInsets.all(10),
                child: ListView.builder(
                  key: const ValueKey('lost_page_list_key'),
                  controller: _scrollController,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return list.isEmpty
                        ? const EmptyListWidget()
                        : LostListItem(
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
