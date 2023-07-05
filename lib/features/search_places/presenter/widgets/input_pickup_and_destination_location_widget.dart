import 'package:flutter/material.dart';

import '../../../../core/constants/nums.dart';

class InputPickupAndDestinationLocationWidget extends StatefulWidget {
  const InputPickupAndDestinationLocationWidget({Key? key}) : super(key: key);

  @override
  State<InputPickupAndDestinationLocationWidget> createState() =>
      _InputPickupAndDestinationLocationWidgetState();
}

class _InputPickupAndDestinationLocationWidgetState
    extends State<InputPickupAndDestinationLocationWidget> {
  late final List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();

    _focusNodes = List.generate(2, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (final focusNode in _focusNodes) {
      focusNode.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final double topPadding = MediaQuery.of(context).padding.top;

    return Container(
      color: colorScheme.background,
      padding: EdgeInsets.only(top: topPadding, bottom: 16),
      child: Column(
        children: [
          // Top section of search pickup and destination
          Row(
            children: [
              // Back icon button
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: colorScheme.onBackground,
                  size: 20,
                ),
              ),

              // Title Ride text
              Expanded(
                child: Center(
                  child: Text(
                    'Ride',
                    style: textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              // This is same width as IconButton so that title can be
              // set in the middle
              const SizedBox(
                width: 32,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Nums.horizontalPadding,
            ),
            child: Row(
              children: [
                // Pickup to Destination point art
                Column(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 48,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                      ),
                    ),
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      // Pickup location textfield
                      TextField(
                        focusNode: _focusNodes[0],
                        autofocus: true,
                        onEditingComplete: () {
                          _focusNodes[0].unfocus();
                          _focusNodes[1].requestFocus();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Pickup location',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Destination location textfield
                      TextField(
                        focusNode: _focusNodes[1],
                        onEditingComplete: () {
                          _focusNodes[1].unfocus();
                        },
                        decoration: const InputDecoration(
                          hintText: 'Destination location',
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Done button
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Nums.horizontalPadding,
            ).copyWith(
              left: 40,
            ),
            child: ElevatedButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      Nums.roundedCornerRadius,
                    ),
                  ),
                ),
              ),
              child: const Center(
                child: Text(
                  'Done',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
