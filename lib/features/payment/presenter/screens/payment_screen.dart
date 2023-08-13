import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:saffar_app/features/user/presenter/cubits/user_cubit.dart';
import 'package:saffar_app/core/models/address.dart';
import 'package:saffar_app/core/models/driver.dart';
import 'package:saffar_app/core/service_locator.dart';
import 'package:saffar_app/features/payment/presenter/cubits/payment_cubit.dart';

import '../../../../core/models/ride.dart';
import '../../../../core/utils/snackbar.dart';

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
  late final Razorpay _razorpay;

  Ride? ride;

  @override
  void initState() {
    super.initState();

    _paymentCubit = PaymentCubit();
    _razorpay = sl<Razorpay>();

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

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_SUCCESS,
      (PaymentSuccessResponse response) {
        if (_paymentCubit.state is PaymentInitial) {
          final PaymentInitial paymentInitialState =
              _paymentCubit.state as PaymentInitial;
          final double price = paymentInitialState.price;

          _paymentCubit.addRide(
            user: context.read<UserCubit>().state.currentUser!,
            driver: widget.paymentScreenArguments.driver,
            sourceAddress: widget.paymentScreenArguments.sourceAddress,
            destinationAddress:
                widget.paymentScreenArguments.destinationAddress,
            startTime: widget.paymentScreenArguments.startTime,
            cancelled: false,
            price: price,
          );
        }
      },
    );

    _razorpay.on(
      Razorpay.EVENT_PAYMENT_ERROR,
      (PaymentFailureResponse response) {
        Snackbar.of(context).show(
          'Payment failed. Please try again.',
          bgColor: Theme.of(context).colorScheme.onPrimary,
          textColor: Theme.of(context).colorScheme.primary,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final Size size = MediaQuery.of(context).size;

    return BlocProvider.value(
      value: _paymentCubit,
      child: BlocBuilder<PaymentCubit, PaymentState>(
        builder: (context, paymentState) {
          final double totalPrice =
              paymentState is PaymentInitial ? paymentState.price : 0;

          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Scaffold(
              backgroundColor: colorScheme.primary,
              body: (paymentState is PaymentInitial)
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
                            style: textTheme.headline2?.copyWith(
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
                                      onPressed: paymentState
                                              .onlineButtonLoading
                                          ? null
                                          : () {
                                              _paymentCubit.addRide(
                                                user: userState.currentUser!,
                                                driver: widget
                                                    .paymentScreenArguments
                                                    .driver,
                                                sourceAddress: widget
                                                    .paymentScreenArguments
                                                    .sourceAddress,
                                                destinationAddress: widget
                                                    .paymentScreenArguments
                                                    .destinationAddress,
                                                startTime: widget
                                                    .paymentScreenArguments
                                                    .startTime,
                                                endTime: endTime,
                                                cancelled: false,
                                                price: paymentState.price,
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
                                onPressed: paymentState.onlineButtonLoading
                                    ? null
                                    : () {
                                        _paymentCubit.payViaRazorpay(context);
                                      },
                                style: ElevatedButton.styleFrom(
                                  primary: colorScheme.onPrimary,
                                ),
                                child: Text(
                                  paymentState.onlineButtonLoading
                                      ? '...'
                                      : 'Online',
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
                  : (paymentState is PaymentLoading)
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
