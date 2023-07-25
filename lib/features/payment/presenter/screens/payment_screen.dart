import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saffar_app/core/cubits/user_cubit.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/models/driver.dart';
import 'package:saffar_app/features/payment/presenter/cubits/payment_cubit.dart';

class PaymentScreenArguments {
  const PaymentScreenArguments({
    required this.driver,
    required this.sourceAddress,
    required this.destinationAddress,
    required this.startTime,
  });

  final Driver driver;
  final Address sourceAddress;
  final Address destinationAddress;
  final DateTime startTime;
}

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({
    Key? key,
    required this.paymentScreenArguments,
  }) : super(key: key);

  static const String routeName = '/payment';

  final PaymentScreenArguments paymentScreenArguments;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final PaymentCubit _paymentCubit;

  @override
  void initState() {
    super.initState();

    _paymentCubit = PaymentCubit();

    _paymentCubit.getTotalRidePrice(
      widget.paymentScreenArguments.sourceAddress.latLng,
      widget.paymentScreenArguments.destinationAddress.latLng,
    );

    _paymentCubit.stream.listen((paymentState) {
      if (paymentState is PaymentComplete) {
        Future.delayed(
          const Duration(seconds: 1),
          () {
            Navigator.pop(context);
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Size size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _paymentCubit,
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, state) {
          final double totalPrice = state is PaymentInitial ? state.price : 0;

          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: colorScheme.primary,
              body: (state is PaymentInitial)
                  ? SizedBox(
                      height: size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Ride completed',
                            textAlign: TextAlign.center,
                            style: textTheme.headline6?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          Text(
                            'Final Payable amount',
                            textAlign: TextAlign.center,
                            style: textTheme.headline5?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            '\u{20B9} ${totalPrice.toStringAsFixed(2)}',
                            style: textTheme.headline1?.copyWith(
                              color: colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Pay via',
                            style: textTheme.bodyText1?.copyWith(
                              color: colorScheme.onPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<UserCubit, UserState>(
                                builder: (context, userState) {
                                  if (userState.currentUser != null) {
                                    final DateTime endTime = DateTime.now();

                                    return ElevatedButton(
                                      onPressed: () {
                                        _paymentCubit.addRide(
                                          user: userState.currentUser!,
                                          driver: widget
                                              .paymentScreenArguments.driver,
                                          sourceAddress: widget
                                              .paymentScreenArguments
                                              .sourceAddress,
                                          destinationAddress: widget
                                              .paymentScreenArguments
                                              .destinationAddress,
                                          startTime: widget
                                              .paymentScreenArguments.startTime,
                                          endTime: endTime,
                                          cancelled: false,
                                          price: state.price,
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: colorScheme.onPrimary,
                                      ),
                                      child: Text(
                                        'Cash',
                                        style: TextStyle(
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                                  }

                                  return const SizedBox();
                                },
                              ),
                              const SizedBox(width: 16),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: colorScheme.onPrimary,
                                ),
                                child: Text(
                                  'QR Payment',
                                  style: TextStyle(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : (state is PaymentLoading)
                      ? Center(
                          child: CircularProgressIndicator(
                            color: colorScheme.onPrimary,
                          ),
                        )
                      : SizedBox(
                          height: size.height,
                          width: size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Payment is Complete',
                                style: textTheme.headline5?.copyWith(
                                  color: colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Icon(
                                Icons.done,
                                color: Colors.green,
                                size: 48,
                              ),
                            ],
                          ),
                        ),
            ),
          );
        },
      ),
    );
  }
}
