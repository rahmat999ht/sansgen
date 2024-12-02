import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:sansgen/utils/ext_context.dart';
import 'package:sks_ticket_view/sks_ticket_view.dart';

import '../controllers/payment_details_controller.dart';

class PaymentDetailsView extends GetView<PaymentDetailsController> {
  const PaymentDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Payment Details'),
        centerTitle: true,
      ),
      body: Stack(alignment: Alignment.topCenter, children: [
        Padding(
          padding: const EdgeInsets.only(top: 70, bottom: 100, right: 32, left: 32),
          child: receipt(context),
        ),
        const Positioned(
          top: 20,
          child: CircleAvatar(
            radius: 42,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
          ),
        )
      ]),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //     const Gap(30),
      //     SizedBox(
      //       width: 300,
      //       height: 50,
      //       child:
      //           ElevatedButton(onPressed: () {}, child: const Text('Selesai')),
      //     ),
      //   ],
      // ),
    );
  }

  Container receipt(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.secondary,
            offset: const Offset(
              0.0,
              5.0,
            ),
            blurRadius: 20.0,
            spreadRadius: 0.5,
            blurStyle: BlurStyle.normal,
          )
        ],
      ),
      // padding: const EdgeInsets.only(top: 70, bottom: 100,),
      child: SKSTicketView(
        backgroundPadding:
            const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        backgroundColor: Colors.transparent,
        // contentPadding:
        //     const EdgeInsets.only(top: 70, bottom: 100, right: 0, left: 0),
        drawArc: false,
        triangleAxis: Axis.vertical,
        borderRadius: 6,
        drawDivider: true,
        trianglePos: .5,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const Gap(65),
                Text('Payment Total',
                    style: context.titleSmall
                        .copyWith(color: context.colorScheme.secondary)),
                Text(
                  '\$12.00',
                  style: context.titleLargeBold,
                ),
                const Gap(20),
                txtReceipt(
                    context: context, label: 'Date', content: '12 May 2024'),
                const Gap(20),
                txtReceipt(
                    context: context,
                    label: 'Details',
                    content: 'Premium Sansgen'),
                const Gap(20),
                txtReceipt(
                    context: context,
                    label: 'Reference num',
                    content: 'A06453826151'),
                const Gap(20),
                txtReceipt(
                    context: context,
                    label: 'Account',
                    content: 'Rahmat Hidayat'),
                const Gap(100),
                txtReceipt(
                    context: context,
                    label: 'Total Payment',
                    content: '\$11.00'),
                const Gap(20),
                txtReceipt(
                    context: context, label: 'Admin fee', content: '\$1.00'),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: context.titleSmall
                          .copyWith(color: context.colorScheme.secondary),
                    ),
                    Text('\$12.00',
                        style: context.titleSmallBold
                            .copyWith(color: context.colorScheme.surface))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row txtReceipt(
      {required BuildContext context,
      required String label,
      required String content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              context.titleSmall.copyWith(color: context.colorScheme.secondary),
        ),
        Text(
          content,
          style: context.titleSmall,
        )
      ],
    );
  }
}
