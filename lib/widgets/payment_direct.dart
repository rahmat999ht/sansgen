import 'package:flutter/material.dart';

GestureDetector paymentDirect({required Function()? onTap }) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child:Text('Bayar')
      ),
    ),
  );
}
