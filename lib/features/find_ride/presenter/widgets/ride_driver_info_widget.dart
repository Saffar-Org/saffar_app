import 'package:flutter/material.dart';
import 'package:saffar_app/core/constants/nums.dart';
import 'package:saffar_app/core/models/driver.dart';
import 'package:saffar_app/core/utils/snackbar.dart';
import 'package:saffar_app/features/find_ride/presenter/cubits/ride_driver_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RideDriverInfoWidget extends StatelessWidget {
  const RideDriverInfoWidget({
    Key? key,
    required this.driver,
    required this.onCancelRidePressed,
  }) : super(key: key);

  final Driver driver;
  final Function() onCancelRidePressed;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Expanded(
          child: Row(
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
                  ],
                ),
              ),
            ],
          ),
        ),
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
                onPressed: () {
                  context.read<RideDriverCubit>().shareDriverInfo(driver);
                },
                child: const Icon(Icons.share),
              ),
            ),
            const SizedBox(width: 16),
            // Cancel button
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final bool cancelRide = await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: Nums.horizontalPadding,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.background,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(
                                Nums.roundedCornerRadius,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Do you want to cancel the Ride?',
                                  style: textTheme.bodyText1?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Snackbar.of(context).show(
                                            'Ride cancelled successfully',
                                          );

                                          Navigator.pop(dialogContext, true);
                                        },
                                        child: const Text('Yes'),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pop(dialogContext, false);
                                        },
                                        child: const Text('No'),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );

                  if (cancelRide) {
                    onCancelRidePressed();

                    Navigator.pop(context);
                  }
                },
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
