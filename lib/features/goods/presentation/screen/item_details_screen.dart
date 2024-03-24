import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lost_find_tracker/core/utils/assets.dart';
import 'package:lost_find_tracker/core/utils/constant.dart';
import 'package:lost_find_tracker/core/utils/theme_color.dart';
import 'package:lost_find_tracker/features/goods/domain/entities/lostItem.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/materialWidget/app_bar_widget.dart';
import 'package:lost_find_tracker/features/goods/presentation/widget/dialogWidget/pick_date.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final LostItem lostItem =
        ModalRoute.of(context)!.settings.arguments as LostItem;

    return Scaffold(
      appBar: AppBarWidget(appBar: AppBar(), title: 'Details'),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: lostItem.id!,
              child: CachedNetworkImage(
                imageUrl: lostItem.images!.isEmpty
                    ? Images.errorImage
                    : lostItem.images!.first,
                errorWidget: (ctx, url, err) => const Icon(Icons.error),
                placeholder: (ctx, url) => const Icon(Icons.image),
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    lostItem.name,
                    style: textTheme.displaySmall!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Status: ${lostItem.isLost! ? 'Lost' : 'Found'}',
                    style: textTheme.titleLarge!.copyWith(
                      color: lostItem.isLost!
                          ? Colors.redAccent
                          : Colors.lightGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Divider(height: 1),
                  const SizedBox(height: 16),
                  Text(
                    'Description: ${lostItem.description}',
                    style: textTheme.headlineSmall!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Date: ${convertDateTime(lostItem.date)}',
                    style: textTheme.titleLarge!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${lostItem.category!.name}',
                    style: textTheme.titleLarge!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Location: ${lostItem.street}',
                    style: textTheme.titleLarge!.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[400]),
                                onPressed: () async {
                                  final Uri url = Uri.parse(
                                      'tel://${lostItem.user!.phoneNumber}');

                                  if (!await launchUrl(url,
                                      mode: LaunchMode.externalApplication)) {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Text(
                                  'Call',
                                  style: GoogleFonts.lato(
                                      color: ColorsFave.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Constants.PutLocationScreen,
              arguments: Marker(
                  markerId: MarkerId(lostItem.id!),
                  position: LatLng(
                      lostItem.location!.last, lostItem.location!.first)));
        },
        child: const Icon(Icons.location_on_outlined),
      ),
    );
  }
}
