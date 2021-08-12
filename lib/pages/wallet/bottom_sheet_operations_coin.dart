import 'package:clipboard/clipboard.dart';
import 'package:digit41/utils/app_state_management.dart';
import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/utils/utils.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void trxDetailsBottomSheet(BuildContext context) {
  Widget _anyItemOfInfo(String title, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: AppTheme.gray)),
          Text(value),
        ],
      );

  _bottomSheetOperationCoins(
    context,
    Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.RECEIVE.tr,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '0.125654',
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'ETH',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10.0,
              height: 10.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Get.theme.primaryColor,
              ),
            ),
            const SizedBox(width: 4.0),
            Text(
              Strings.COMPLETED.tr,
              style: TextStyle(color: Get.theme.primaryColor),
            ),
          ],
        ),
        const SizedBox(height: 16.0),
        _anyItemOfInfo(Strings.FROM.tr, '26,566' + 'USD'),
        const SizedBox(height: 10.0),
        _anyItemOfInfo(Strings.RATE.tr, '1 USDT = 0.006 ETH'),
        const SizedBox(height: 10.0),
        _anyItemOfInfo(Strings.TRX_ID.tr, '64116514548484'),
        const SizedBox(height: 10.0),
        _anyItemOfInfo(Strings.DATE.tr, '2021/02/02 - 12:12:12'),
        const SizedBox(height: 32.0),
        SizedBox(
          width: 120.0,
          child: AppButton(
            title: Strings.OK.tr,
            onTap: () {
              Get.back();
            },
            btnColor: AppTheme.gray,
            titleColor: Colors.white,
          ),
        ),
      ],
    ),
    trxDetail: true,
  );
}

void sendBottomSheet(BuildContext context) {
  AppGet appGet = AppGet.appGet;
  final formKey = GlobalKey<FormState>();
  AppTextFormField amount = AppTextFormField(
    hint: Strings.AMOUNT.tr + 'ETH',
    textInputType: TextInputType.number,
    onChanged: (val) {
      appGet.forUpdateUI();
    },
  );
  AppTextFormField address = AppTextFormField(
    hint: Strings.RECIPIENT_ADDR.tr,
    nextFocusNode: amount.focusNode,
    onChanged: (val) {
      appGet.forUpdateUI();
    },
  );
  address.focusNode.requestFocus();
  address.focusNode.addListener(() {
    appGet.forUpdateUI();
  });

  _bottomSheetOperationCoins(
    context,
    Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.SEND.tr + ' ETH',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24.0),
          address,
          const SizedBox(height: 16.0),
          amount,
          const SizedBox(height: 16.0),
          GetBuilder(
            init: AppGet(),
            builder: (ctx) =>
                address.controller.text != '' && amount.controller.text != ''
                    ? AppButton(
                        title: Strings.CONTINUE.tr,
                        onTap: () {},
                        btnColor: Get.theme.primaryColor,
                      )
                    : address.focusNode.hasFocus
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: AppButton1(
                                  title: Strings.PASTE.tr,
                                  onTap: () {
                                    FlutterClipboard.paste().then((value) {
                                      address.controller.text = value;
                                    });
                                  },
                                  icon: _buttonIcon(Images.COPY),
                                ),
                              ),
                              if (GetPlatform.isAndroid || GetPlatform.isIOS)
                                const SizedBox(width: 32.0),
                              if (GetPlatform.isAndroid || GetPlatform.isIOS)
                                Expanded(
                                  child: AppButton1(
                                    title: Strings.SCAN_QR.tr,
                                    onTap: () {
                                      barcodeScan().then((value) {
                                        address.controller.text = value;
                                      });
                                    },
                                    icon: _buttonIcon(Images.SCAN),
                                  ),
                                ),
                            ],
                          )
                        : amount.focusNode.hasFocus
                            ? AppButton1(
                                title: Strings.MAX_AMOUNT.tr,
                                onTap: () {},
                                icon: _buttonIcon(Images.FIRE),
                              )
                            : Center(),
          ),
        ],
      ),
    ),
  );
}

void receiveBottomSheet(BuildContext context) {
  _bottomSheetOperationCoins(
    context,
    Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.RECEIVE.tr + ' ETH',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 24.0),
        AppButton1(
          title: Strings.COPY_ADDRESS.tr,
          onTap: () {},
          icon: _buttonIcon(Images.COPY),
        ),
        const SizedBox(height: 16.0),
        AppButton1(
          title: Strings.SET_AMOUNT.tr,
          onTap: () {},
          icon: _buttonIcon(Images.NUMBER),
        ),
        const SizedBox(height: 16.0),
        AppButton(
          title: Strings.SHARE.tr,
          onTap: () {},
          btnColor: Get.theme.primaryColor,
          icon: _buttonIcon(Images.SHARE, color: Colors.black),
        ),
      ],
    ),
    send: false,
  );
}

Widget _buttonIcon(String path, {Color? color}) => Image.asset(
      path,
      width: 25.0,
      height: 25.0,
      color: Colors.white,
    );

void _bottomSheetOperationCoins(BuildContext context, Widget child,
    {bool send = true, bool trxDetail = false}) {
  Get.bottomSheet(
    Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50.0),
          padding: const EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 44.0),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topRight: const Radius.circular(24.0),
              topLeft: const Radius.circular(24.0),
            ),
            color: Get.theme.bottomSheetTheme.backgroundColor,
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: child,
          ),
        ),
        Positioned(
          top: 0.0,
          left: MediaQuery.of(context).size.width / 2 - 45.0,
          child: Container(
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.all(8.0),
            width: 85.0,
            height: 85.0,
            decoration: trxDetail
                ? BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Get.theme.primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  )
                : null,
            child: Image.asset(Images.LOGO),
          ),
        ),
        if (!trxDetail)
          Positioned(
            left: MediaQuery.of(context).size.width / 2 + 10.0,
            top: 2.0,
            width: 35.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                color: Get.theme.primaryColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: Icon(
                send ? Icons.arrow_upward : Icons.arrow_downward,
                color: AppTheme.gray,
              ),
            ),
          ),
      ],
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
  );
}
