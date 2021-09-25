part of 'bottom_sheet.dart';

void sendBottomSheet(BuildContext context) {
  _coinOperationsBottomSheet(context, '', _Send());
}

class _Send extends StatefulWidget {
  const _Send({Key? key}) : super(key: key);

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
    address!.focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
              : address!.focusNode.hasFocus
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: AppButton1(
                            title: Strings.PASTE.tr,
                            onTap: () {
                              FlutterClipboard.paste().then((value) {
                                address!.controller.text = value;
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
                                });
                              },
                              icon: _buttonIcon(Images.SCAN),
                            ),
                          ),
                      ],
                    )
                  : amount!.focusNode.hasFocus
                      ? AppButton1(
                          title: Strings.MAX_AMOUNT.tr,
                          onTap: () {},
                          icon: _buttonIcon(Images.FIRE),
                        )
                      : Center(),
        ],
      ),
    );
  }
}
