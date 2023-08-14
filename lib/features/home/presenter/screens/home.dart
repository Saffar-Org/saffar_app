import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/core/constants/nums.dart';
import 'package:saffar_app/core/constants/strings.dart';
import 'package:saffar_app/core/cubits/previous_rides_cubit.dart';
import 'package:saffar_app/features/user/presenter/cubits/user_cubit.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/widgets/address_widget.dart';
import 'package:saffar_app/features/home/presenter/cubits/home_cubit.dart';
import 'package:saffar_app/features/view_map/presenter/screens/view_map_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();

    _homeCubit = HomeCubit();

    _homeCubit.initHomeCubit(context);

    context.read<PreviousRidesCubit>().getListOfPreviousRidesAndEmit();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final String? userImageUrl =
        context.read<UserCubit>().state.currentUser?.imageUrl;

    return BlocProvider<HomeCubit>.value(
      value: _homeCubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              return Stack(
                children: [
                  Scaffold(
                    key: _scaffoldKey,
                    drawer: Drawer(
                      backgroundColor: Theme.of(context).colorScheme.background,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: mediaQueryData.padding.top + 32),
                          Container(
                            width: 160,
                            height: 160,
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(.4),
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: colorScheme.primary,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40),
                              ),
                              child: userImageUrl != null
                                  ? Image.network(
                                      userImageUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 64,
                                      color: colorScheme.onPrimary,
                                    ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            userState.currentUser!.name,
                            style: textTheme.bodyText1?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            userState.currentUser!.phone,
                            style: textTheme.bodyText1,
                          ),
                          const SizedBox(height: 24),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                context
                                    .read<UserCubit>()
                                    .deleteCurrentUserFromLocalStorageAndEmitCurrentUser(
                                        context);
                              },
                              style: ElevatedButton.styleFrom(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    ?.copyWith(fontWeight: FontWeight.bold),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                              ),
                              child: const Center(
                                child: Text(
                                  'Logout',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    body: Column(
                      children: [
                        Container(
                          color: colorScheme.primary,
                          padding: EdgeInsets.fromLTRB(
                            Nums.horizontalPadding,
                            statusBarHeight + 16,
                            Nums.horizontalPadding,
                            16,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // User name
                                        Text(
                                          userState.currentUser?.name
                                                  .split(' ')
                                                  .first ??
                                              'Welcome',
                                          maxLines: 1,
                                          style: textTheme.headline5?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: colorScheme.onPrimary,
                                          ),
                                        ),
                                        const SizedBox(width: 16),

                                        // Saffar caption
                                        Text(
                                          Strings.saffarCaption,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.bodyText2?.copyWith(
                                            color: colorScheme.onPrimary
                                                .withOpacity(.6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // User image
                                  GestureDetector(
                                    onTap: () {
                                      _scaffoldKey.currentState!.openDrawer();
                                    },
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black26,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: colorScheme.onPrimary
                                              .withOpacity(.6),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(40),
                                        ),
                                        child: userImageUrl != null
                                            ? Image.network(
                                                userImageUrl,
                                                fit: BoxFit.cover,
                                              )
                                            : Icon(
                                                Icons.person,
                                                color: colorScheme.onPrimary,
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),

                              // Where do you want to go Container Button
                              GestureDetector(
                                onTap: () async {
                                  final bool locationEnabled = await _homeCubit
                                      .requestLocationPermissionAndEnableLocation(
                                          context);

                                  if (locationEnabled) {
                                    final Address? currentAddress =
                                        await _homeCubit.getCurrentAddress();

                                    await Navigator.pushNamed(
                                      context,
                                      ViewMapScreen.routeName,
                                      arguments: ViewMapScreenArguments(
                                        initialPickupAddress: currentAddress,
                                      ),
                                    );

                                    context
                                        .read<PreviousRidesCubit>()
                                        .getListOfPreviousRidesAndEmit();
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: colorScheme.onPrimary,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(Nums.roundedCornerRadius),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Where do you want to go
                                      Text(
                                        'Where do you want to go?',
                                        style: textTheme.headline6?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 12),

                                      Row(
                                        children: [
                                          Container(
                                            height: 24,
                                            width: 24,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: colorScheme.primary,
                                            ),
                                            child: Icon(
                                              Icons.arrow_forward_rounded,
                                              color: colorScheme.onPrimary,
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(width: 16),

                                          // Find the location text
                                          Expanded(
                                            child: Text(
                                              'Find the location',
                                              style:
                                                  textTheme.bodyText1?.copyWith(
                                                color: textTheme
                                                    .bodyText1?.color
                                                    ?.withOpacity(.6),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Saved places buttons
                              SizedBox(
                                height: 42,
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          width: 2,
                                          color: colorScheme.onPrimary
                                              .withOpacity(.2),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Nums.roundedCornerRadius),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.home,
                                            size: 20,
                                            color: colorScheme.onPrimary,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Home',
                                            style: textTheme.button?.copyWith(
                                              color: colorScheme.onPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          width: 2,
                                          color: colorScheme.onPrimary
                                              .withOpacity(.2),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Nums.roundedCornerRadius),
                                          ),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.apartment_rounded,
                                            size: 20,
                                            color: colorScheme.onPrimary,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            'Office',
                                            style: textTheme.button?.copyWith(
                                              color: colorScheme.onPrimary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    OutlinedButton(
                                      onPressed: () {},
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          width: 2,
                                          color: colorScheme.onPrimary
                                              .withOpacity(.2),
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                Nums.roundedCornerRadius),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Others',
                                        style: textTheme.button?.copyWith(
                                          color: colorScheme.onPrimary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: Nums.horizontalPadding),
                              child: Column(
                                children: [
                                  const SizedBox(height: 16),

                                  BlocBuilder<PreviousRidesCubit,
                                      PreviousRidesState>(
                                    builder: (context, state) {
                                      if (state is PreviousRidesGot) {
                                        // Most recently visited place address.
                                        return state
                                                .latestTwoPreviousRidesWithoutCancellation
                                                .isEmpty
                                            ? const SizedBox()
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 16),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        colorScheme.onPrimary,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(
                                                        Nums.roundedCornerRadius,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: List.generate(
                                                      state
                                                          .latestTwoPreviousRidesWithoutCancellation
                                                          .length,
                                                      (index) {
                                                        final Address address = state
                                                            .latestTwoPreviousRidesWithoutCancellation[
                                                                index]
                                                            .destinationAddress;

                                                        return GestureDetector(
                                                          onTap: () async {
                                                            await Navigator
                                                                .pushNamed(
                                                              context,
                                                              ViewMapScreen
                                                                  .routeName,
                                                              arguments:
                                                                  ViewMapScreenArguments(
                                                                initialDestinationAddress:
                                                                    address,
                                                              ),
                                                            );

                                                            context
                                                                .read<
                                                                    PreviousRidesCubit>()
                                                                .getListOfPreviousRidesAndEmit();
                                                          },
                                                          child: AddressWidget(
                                                            address: address,
                                                            showDivider: index !=
                                                                state.latestTwoPreviousRidesWithoutCancellation
                                                                        .length -
                                                                    1,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                      } else if (state
                                          is PreviousRidesLoading) {
                                        return const Center(
                                            child: Text('Loading'));
                                      } else {
                                        return Center(
                                            child: Text(
                                                'No UI for state: $state'));
                                      }
                                    },
                                  ),

                                  // Share location poster
                                  GestureDetector(
                                    onTap: () {
                                      _homeCubit
                                          .requestLocationPermissionAndEnableLocation(
                                        context,
                                        showLocationAlreadyOnMessage: true,
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(
                                          12,
                                        ),
                                      ),
                                      child: Container(
                                        height: 140,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.green[800],
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        16, 0, 16, 8),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Want better pickups?',
                                                      style: textTheme.bodyText1
                                                          ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 16),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'Share your location',
                                                          style: textTheme
                                                              .bodyText2
                                                              ?.copyWith(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 8),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          size: 14,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                  top: 16,
                                                  left: 16,
                                                ),
                                                color: Colors.green[900],
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Image.asset(
                                                  'assets/images/person_with_binocular.png',
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (homeState is HomeLoading)
                    Container(
                      color: colorScheme.primary.withOpacity(.6),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
