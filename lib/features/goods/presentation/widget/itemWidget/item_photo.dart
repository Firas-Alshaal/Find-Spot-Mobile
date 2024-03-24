import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lost_find_tracker/core/utils/assets.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';

class ItemPhoto extends StatelessWidget {
  const ItemPhoto({super.key, required this.lostItem});

  final LostItem lostItem;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      child: SizedBox(
        height: 122,
        child: Hero(
          tag: lostItem.id!,
          child: CachedNetworkImage(
            height: 122,
            width: 122,
            imageUrl: lostItem.images!.isEmpty
                ? Images.errorImage
                : lostItem.images!.first,
            fit: BoxFit.cover,
            errorWidget: (ctx, url, err) => const Icon(Icons.error),
            placeholder: (ctx, url) => const Icon(Icons.image),
          ),
        ),
      ),
    );
  }
}
