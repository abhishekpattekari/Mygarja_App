import 'package:mygarja/feature/product/presentation/widgets/back_app_bar.dart';
import 'package:mygarja/feature/product/presentation/widgets/transaction_button.dart';
import 'package:flutter/material.dart';
import 'package:mygarja/core/asset_constants.dart' as asset;

import '../main_home_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(context, 'Payments Methods'),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SizedBox(
          child: ListView(children: [
            Text(
              'Select the payment method you want to choose',
              style: asset.introStyles(18),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  payment_tile("My Wallet", "Estimated Arrival,Dec 21-23 ",
                      asset.wallet, true, true),
                  payment_tile("PayPal", "Estimated Arrival,Dec 20-22 ",
                      asset.paypal, false, false),
                  payment_tile("Google Pay", "Estimated Arrival,Dec 19-20 ",
                      asset.google_logo, false, false),
                  payment_tile("Apple Pay", "Estimated Arrival,Dec 18-19 ",
                      asset.apple_logo, false, false),
                ],
              ),
            ),
          ]),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
        child: TransactionButton(
          mediaQuery: MediaQuery.of(context).size.width * .9,
          verticalpadding: 20,
          title: 'Confirm Payment',
          suffixIcon: const SizedBox(),
          trasaction_fun: () {
            // Show success message directly
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                'Ordered Successfully..',
                style: asset.introStyles(18, color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
            // Navigate to home screen
            Navigator.pushNamedAndRemoveUntil(
                    context, MainHomeScreen.routename, (route) => false);
          },
        ),
      ),
    );
  }

  ListTile payment_tile(String title, String address, String icon_url,
      bool isSelected, bool isPriceneeded) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      title: Text(
        title,
        maxLines: 2,
        style: asset.introStyles(20),
      ),
      trailing: SizedBox(
        width: 110,
        child: Row(
          mainAxisAlignment: isPriceneeded
              ? MainAxisAlignment.spaceAround
              : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (isPriceneeded)
              Text(
                "₹2,54,856",
                style: asset.introStyles(20),
              ),
            isSelected
                ? const Icon(
                    Icons.radio_button_checked_rounded,
                    color: Colors.black,
                  )
                : const Icon(
                    Icons.radio_button_off_rounded,
                    color: Colors.black,
                  )
          ],
        ),
      ),
      leading: SizedBox(
        height: 35,
        width: 35,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(icon_url)),
      ),
    );
  }
}
