part of 'bottom_sheet.dart';

void sendBottomSheet(BuildContext context, {AssetModel? asset}) {
  _coinOperationsBottomSheet(context, asset!.icon!, _Send(asset));
}

class _Send extends StatefulWidget {
  final AssetModel assetModel;

  const _Send(this.assetModel, {Key? key}) : super(key: key);

  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<_Send> {
  final formKey = GlobalKey<FormState>();
  AppTextFormField? amount;
  AppTextFormField? address;

  @override
  void initState() {
    super.initState();
    amount = AppTextFormField(
      hint: Strings.AMOUNT.tr,
      textInputType: TextInputType.number,
      onChanged: (val) {
        setState(() {});
      },
    );
    address = AppTextFormField(
      hint: Strings.RECIPIENT_ADDR.tr,
      nextFocusNode: amount!.focusNode,
      onChanged: (val) {
        setState(() {});
      },
    );
    address!.focusNode.requestFocus();
    address!.controller.addListener(() {
      setState(() {});
    });
    amount!.controller.addListener(() {
      setState(() {});
    });
  }

  Widget addressBtns() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: AppButton1(
              title: Strings.PASTE.tr,
              onTap: () {
                FlutterClipboard.paste().then((value) {
                  address!.controller.text = value;
                  if (value.length > 0) amount!.focusNode.requestFocus();
                });
              },
              icon: _buttonIcon(Images.COPY),
            ),
          ),
          if (!GetPlatform.isWeb) const SizedBox(width: 32.0),
          if (!GetPlatform.isWeb)
            Expanded(
              child: AppButton1(
                title: Strings.SCAN_QR.tr,
                onTap: () {
                  barcodeScan().then((value) {
                    address!.controller.text = value;
                    if (value.length > 0) amount!.focusNode.requestFocus();
                  });
                },
                icon: _buttonIcon(Images.SCAN),
              ),
            ),
        ],
      );

  Widget amountBtn() => AppButton1(
        title: Strings.MAX_AMOUNT.tr,
        onTap: () {
          amount!.controller.text = widget.assetModel.balance.toString();
        },
        icon: _buttonIcon(Images.FIRE),
      );

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).addListener(() {
      if (address!.controller.text == '')
        address!.focusNode.requestFocus();
      else if (amount!.controller.text == '') amount!.focusNode.requestFocus();
      setState(() {});
    });
    return Form(
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
          address!,
          const SizedBox(height: 16.0),
          amount!,
          const SizedBox(height: 16.0),
          address!.controller.text != '' && amount!.controller.text != ''
              ? AppButton(
                  title: Strings.CONTINUE.tr,
                  onTap: () {},
                  btnColor: Get.theme.primaryColor,
                )
              : amount!.focusNode.hasFocus
                  ? amountBtn()
                  : addressBtns(),
        ],
      ),
    );
  }
}
