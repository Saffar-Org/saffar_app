import 'package:flutter/material.dart';

import '../../../../core/constants/nums.dart';
import '../../../search_places/presenter/widgets/searched_addresses_widget.dart';

class AddressListBottomWidget extends StatefulWidget {
  const AddressListBottomWidget({Key? key}) : super(key: key);

  @override
  State<AddressListBottomWidget> createState() =>
      _AddressListBottomWidgetState();
}

class _AddressListBottomWidgetState extends State<AddressListBottomWidget> {
  double? _minYPos;
  double? _maxYPos;
  double? _yPos;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _minYPos = .60 * MediaQuery.of(context).size.height;
    _maxYPos = MediaQuery.of(context).size.height - 40;
    _yPos = _minYPos;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final Size size = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: size.height - _yPos!,
      color: colorScheme.background,
      child: Column(
        children: [
          GestureDetector(
            onVerticalDragEnd: (details) {
              if (details.velocity.pixelsPerSecond.dy >= 50) {
                setState(() {
                  _yPos = _maxYPos;
                });
              } else if (details.primaryVelocity! <= -10) {
                setState(() {
                  _yPos = _minYPos;
                });
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
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Nums.horizontalPadding,
              ),
              child: SearchedAddressesWidget(),
            ),
          ),
        ],
      ),
    );
  }
}
