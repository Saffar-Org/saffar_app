import 'package:flutter/material.dart';
import 'package:saffar_app/core/constants/nums.dart';
import 'package:saffar_app/core/constants/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final String? userImageUrl =
        'https://www.shutterstock.com/image-photo/head-shot-portrait-close-smiling-260nw-1714666150.jpg';

    return Scaffold(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User name
                          Text(
                            'FirstName',
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
                              color: colorScheme.onPrimary.withOpacity(.6),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // User image
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: colorScheme.onPrimary.withOpacity(.6),
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

                // Where do you want to go Container
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.onPrimary,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(Nums.roundedCornerRadius),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: textTheme.bodyText1?.copyWith(
                                  color: textTheme.bodyText1?.color
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
                            color: colorScheme.onPrimary.withOpacity(.2),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Nums.roundedCornerRadius),
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
                            color: colorScheme.onPrimary.withOpacity(.2),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Nums.roundedCornerRadius),
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
                            color: colorScheme.onPrimary.withOpacity(.2),
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Nums.roundedCornerRadius),
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

                    // Most recently visited place address.
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: colorScheme.onPrimary,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            Nums.roundedCornerRadius,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Address 1
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
                                      'Seva Dell',
                                      style: textTheme.bodyText1?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '4455 Landing Lange, APT 4 Louisville, KY 40018-1234',
                                      style: textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Divider
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              child: Divider(
                                thickness: 2,
                                color:
                                    textTheme.bodyText1?.color?.withOpacity(.1),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Address 2
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
                                      'Seva Dell',
                                      style: textTheme.bodyText1?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '4455 Landing Lange, APT 4 Louisville, KY 40018-1234',
                                      style: textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Share location poster
                    GestureDetector(
                      onTap: () {},
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
                                      const EdgeInsets.fromLTRB(16, 0, 16, 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Want better pickups?',
                                        style: textTheme.bodyText1?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Text(
                                            'Share your location',
                                            style: textTheme.bodyText2?.copyWith(
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          const Icon(
                                            Icons.arrow_forward_ios_rounded,
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
                                  alignment: Alignment.bottomRight,
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
    );
  }
}
