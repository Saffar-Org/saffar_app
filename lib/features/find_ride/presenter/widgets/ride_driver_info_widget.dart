import 'package:flutter/material.dart';
import 'package:saffar_app/core/models/driver.dart';

class RideDriverInfoWidget extends StatelessWidget {
  const RideDriverInfoWidget({
    Key? key,
    required this.driver,
  }) : super(key: key);

  final Driver driver;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          children: [
            // Driver image
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.4),
                border: Border.all(
                  width: 2,
                  color: colorScheme.primary,
                ),
              ),
              child: driver.imageUrl != null
                  ? Image.network(
                      driver.imageUrl!,
                      fit: BoxFit.cover,
                    )
                  : const Icon(
                      Icons.person,
                      color: Colors.grey,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  // Driver name
                  Text(
                    driver.name,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Vehicle name
                  Text(
                    driver.vehicleName,
                    style: textTheme.bodyText2,
                  ),
                  // Vehicle number
                  Text(
                    driver.vehicleNumber,
                    style: textTheme.bodyText2,
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.call),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.call),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
