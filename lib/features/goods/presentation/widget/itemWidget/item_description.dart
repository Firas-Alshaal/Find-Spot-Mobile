import 'package:flutter/material.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';

class ItemDescription extends StatelessWidget {
  const ItemDescription({super.key, required this.lostItem});

  final LostItem lostItem;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, right: 8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            color: colorScheme.surfaceVariant,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                Text(
                  lostItem.name,
                  maxLines: 1,
                  style: textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(
                  'Description: ${lostItem.description}',
                  maxLines: 1,
                  style: textTheme.bodyMedium!.copyWith(
                      overflow: TextOverflow.ellipsis,
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  'Location: ${lostItem.city} , ${lostItem.street}',
                  maxLines: 1,
                  style: textTheme.labelSmall!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
