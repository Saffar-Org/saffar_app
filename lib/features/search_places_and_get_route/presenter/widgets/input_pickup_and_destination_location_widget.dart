import 'package:flutter/material.dart';

import '../../../../core/constants/nums.dart';

class InputPickupAndDestinationLocationWidget extends StatefulWidget {
  const InputPickupAndDestinationLocationWidget({
    Key? key,
    required this.pickupTextEditingController,
    required this.destinationTextEditingController,
    required this.pickupFocusNode,
    required this.destinationFocusNode,
    this.onDonePressed,
  }) : super(key: key);

  final TextEditingController pickupTextEditingController;
  final TextEditingController destinationTextEditingController;
  final FocusNode pickupFocusNode;
  final FocusNode destinationFocusNode;
  final Function()? onDonePressed;

  @override
  State<InputPickupAndDestinationLocationWidget> createState() =>
      _InputPickupAndDestinationLocationWidgetState();
}

class _InputPickupAndDestinationLocationWidgetState
    extends State<InputPickupAndDestinationLocationWidget> {
  bool _showDeleteTextButtonInPickupTextField = false;
  bool _showDeleteTextButtonInDestinationTextField = false;

  @override
  void initState() {
    super.initState();

    widget.pickupTextEditingController.addListener(() {
      setState(() {
        _showDeleteTextButtonInPickupTextField =
            widget.pickupTextEditingController.text.isNotEmpty;
      });
    });

    widget.destinationTextEditingController.addListener(() {
      setState(() {
        _showDeleteTextButtonInDestinationTextField =
            widget.destinationTextEditingController.text.isNotEmpty;
      });
    });
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
                        controller: widget.pickupTextEditingController,
                        focusNode: widget.pickupFocusNode,
                        autofocus: true,
                        decoration: InputDecoration(
                          hintText: 'Pickup location',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          suffixIcon: _showDeleteTextButtonInPickupTextField
                              ? InkWell(
                                  onTap: () {
                                    widget.destinationFocusNode.unfocus();
                                    widget.pickupFocusNode.requestFocus();
                                    widget.pickupTextEditingController.clear();
                                  },
                                  child: const Icon(Icons.cancel),
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Destination location textfield
                      TextField(
                        controller: widget.destinationTextEditingController,
                        focusNode: widget.destinationFocusNode,
                        decoration: InputDecoration(
                          hintText: 'Destination location',
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          suffixIcon:
                              _showDeleteTextButtonInDestinationTextField
                                  ? InkWell(
                                      onTap: () {
                                        widget.pickupFocusNode.unfocus();
                                        widget.destinationFocusNode.requestFocus();
                                        widget.destinationTextEditingController
                                            .clear();
                                      },
                                      child: const Icon(Icons.cancel),
                                    )
                                  : null,
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
              onPressed: widget.onDonePressed == null ? null : () {
                FocusScope.of(context).unfocus();
                widget.onDonePressed!();
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
