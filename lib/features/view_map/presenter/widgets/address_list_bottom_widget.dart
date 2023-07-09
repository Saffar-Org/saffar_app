import 'package:flutter/material.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/widgets/expansion_animation_widget.dart';

import '../../../../core/constants/nums.dart';
import '../../../search_places_and_get_route/presenter/widgets/searched_addresses_widget.dart';

class AddressListBottomWidget extends StatefulWidget {
  const AddressListBottomWidget({
    Key? key,
    required this.onAddressSelected,
    required this.animationController,
  }) : super(key: key);

  final Function(Address) onAddressSelected;
  final AnimationController animationController;

  @override
  State<AddressListBottomWidget> createState() =>
      _AddressListBottomWidgetState();
}

class _AddressListBottomWidgetState extends State<AddressListBottomWidget> {

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Size size = MediaQuery.of(context).size;

    return ExpansionAnimationWidget(
      controller: widget.animationController,
      child: Container(
        color: colorScheme.background,
        child: Column(
          children: [
            GestureDetector(
              onVerticalDragEnd: (details) {
                if (details.velocity.pixelsPerSecond.dy >= 50) {
                  widget.animationController.forward();
                } else if (details.primaryVelocity! <= -50) {
                  widget.animationController.reverse();
                }
              },
              child: Container(
                height: 40,
                width: size.width,
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 5,
                      width: .20 * size.width,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Nums.horizontalPadding,
                ),
                child: SearchedAddressesWidget(
                  onAddressSelected: widget.onAddressSelected,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
