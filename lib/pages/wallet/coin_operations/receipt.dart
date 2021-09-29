part of 'bottom_sheet.dart';

void receiveBottomSheet(BuildContext context, {required AssetModel asset}) {
  _coinOperationsBottomSheet(
    context,
    asset.icon!,
    _Receipt(asset.symbol),
    send: false,
  );
}

class _Receipt extends StatefulWidget {
  final String? symbol;

  const _Receipt(this.symbol, {Key? key}) : super(key: key);

  @override
  _ReceiptState createState() => _ReceiptState();
}

class _ReceiptState extends State<_Receipt> {
  AssetsController assetsCtl = AssetsController.assetsController;
  bool isSetAmount = false;
  String? address;
  String? value;
  AppTextFormField amount = AppTextFormField(
    hint: Strings.AMOUNT.tr,
    textInputType: TextInputType.number,
    disposing: false,
  );

  @override
  void initState() {
    super.initState();
    address = assetsCtl.coinsAddress[0].address;
    amount.onChanged = (val) {
      value = val;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          Strings.RECEIVE.tr + ' ${widget.symbol}',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 24.0),
        AppButton1(
          title: Strings.COPY_ADDRESS.tr,
          onTap: () {
            clipboardCopy(address);
            showSnackBar(Strings.COPIED.tr);
          },
          icon: _buttonIcon(Images.COPY),
        ),
        if (!GetPlatform.isWeb)
          Column(
            children: [
              const SizedBox(height: 16.0),
              AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: isSetAmount ? 120.0 : 55.0,
                child: Column(
                  children: [
                    Visibility(
                      child: amount,
                      visible: isSetAmount,
                    ),
                    Visibility(
                      child: const SizedBox(height: 16.0),
                      visible: isSetAmount,
                    ),
                    AppButton1(
                      title: isSetAmount
                          ? Strings.CANCEL.tr
                          : Strings.SET_AMOUNT.tr,
                      onTap: () {
                        setState(() {
                          isSetAmount = !isSetAmount;
                        });
                      },
                      icon: isSetAmount ? Center() : _buttonIcon(Images.NUMBER),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              AppButton(
                title: Strings.SHARE.tr,
                onTap: () {
                  String info = widget.symbol!;
                  info += '\n';
                  info += address!;
                  if (value != null) info += '&amount=${value}';

                  Share.share(info);
                },
                btnColor: Get.theme.primaryColor,
                icon: _buttonIcon(Images.SHARE, color: Colors.black),
              ),
            ],
          ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    amount.controller.dispose();
    amount.focusNode.dispose();
  }
}
