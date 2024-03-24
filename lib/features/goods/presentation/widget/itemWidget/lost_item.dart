import 'package:flutter/material.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/itemWidget/item_description.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/itemWidget/item_photo.dart';

typedef OnLostListItemTap = void Function(LostItem lostItem);

class LostListItem extends StatelessWidget {
  const LostListItem({
    super.key,
    required this.lostItem,
    this.onTap,
  });

  final LostItem lostItem;
  final OnLostListItemTap? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(lostItem),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: SizedBox(
          height: 124,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ItemPhoto(lostItem: lostItem),
              ItemDescription(lostItem: lostItem),
            ],
          ),
        ),
      ),
    );
  }
}
