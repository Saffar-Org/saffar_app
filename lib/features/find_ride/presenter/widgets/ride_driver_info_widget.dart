import 'package:flutter/material.dart';
import 'package:saffar_app/core/models/driver.dart';
import 'package:saffar_app/features/find_ride/presenter/cubits/ride_driver_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

    return Row(
      children: [
        // Driver image
        Container(
          height: 100,
          width: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.4),
            shape: BoxShape.circle,
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
                  size: 48,
                  color: Colors.grey,
                ),
        ),
        const SizedBox(width: 32),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              const SizedBox(height: 16),
              Row(
                children: [
                  // Phone icon
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<RideDriverCubit>().openCallerApp(driver.phone);
                      },
                      child: const Icon(Icons.call),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Share icon
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.share),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
