import 'package:flutter/material.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/widgets/address_widget.dart';
import 'package:latlong2/latlong.dart';

class SearchedAddressesWidget extends StatelessWidget {
  const SearchedAddressesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 10 + 1,
      itemBuilder: (context, index) {
        if (index == 10) {
          return const SizedBox(height: 16);
        }

        return AddressWidget(
          address: Address(
            id: '123',
            street: 'Ok Street',
            state: 'West Bengal',
            country: 'India',
            latLng: LatLng(10, 10),
          ),
          showDivider: index != 9,
        );
      },
    );
  }
}
