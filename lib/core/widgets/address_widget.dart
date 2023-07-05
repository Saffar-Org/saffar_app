import 'package:flutter/material.dart';
import 'package:saffar_app/core/models/address.dart';

import '../utils/view_helper.dart';

/// Shows Address along with an optional divider at the bottom
class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key? key,
    required this.address,
    required this.showDivider,
  }) : super(key: key);

  final Address address;
  /// In case this widget is used in a list then [showDivider]
  /// will be [true] if index is not the last index else if 
  /// index is last index then it will be set to [false].
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ViewHelper.getAddressPlace(address),
                    style: textTheme.bodyText1?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ViewHelper.getAddressWithoutPlace(address),
                    style: textTheme.bodyText2,
                  ),
                ],
              ),
            ),
          ],
        ),
        if (showDivider)
          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              child: Divider(
                thickness: 2,
                color: textTheme.bodyText1?.color?.withOpacity(.1),
              ),
            ),
          ),
      ],
    );
  }
}
