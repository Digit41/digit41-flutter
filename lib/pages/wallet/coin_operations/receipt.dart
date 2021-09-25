part of 'bottom_sheet.dart';

void receiveBottomSheet(BuildContext context) {
  _coinOperationsBottomSheet(
    context,
    '',
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
