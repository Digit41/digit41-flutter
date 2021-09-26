part of 'bottom_sheet.dart';

void sendBottomSheet(BuildContext context,
    {AssetModel? asset, Function? getTrxs}) {
  _coinOperationsBottomSheet(context, asset!.icon!, _Send(asset, getTrxs!));
}

class _Send extends StatefulWidget {
  final Function getTrxs;
  final AssetModel assetModel;

  const _Send(this.assetModel, this.getTrxs, {Key? key}) : super(key: key);

  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<_Send> {
  AssetsController assetsController = AssetsController.assetsController;
  final formKey = GlobalKey<FormState>();
  bool loading = false;
  AppTextFormField? amount;
  AppTextFormField? address;

  String? onChange(val) {
    if (val!.length == 0)
      setState(() {});
    else if (val.length == 1) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    amount = AppTextFormField(
      hint: Strings.AMOUNT.tr,
      textInputType: TextInputType.number,
      onChanged: onChange,
    );
    address = AppTextFormField(
      hint: Strings.RECIPIENT_ADDR.tr,
      nextFocusNode: amount!.focusNode,
      onChanged: onChange,
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
      if (!address!.focusNode.hasFocus &&
          address!.controller.text != '' &&
          amount!.controller.text == '') {
        amount!.focusNode.requestFocus();
        setState(() {});
      }
    });
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Strings.SEND.tr + ' ${widget.assetModel.symbol}',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24.0),
          address!,
          const SizedBox(height: 16.0),
          amount!,
          const SizedBox(height: 16.0),
          address!.controller.text != '' && amount!.controller.text != ''
              ? loading
                  ? CupertinoActivityIndicator()
                  : AppButton(
                      title: Strings.SEND.tr,
                      onTap: send,
                      btnColor: Get.theme.primaryColor,
                    )
              : amount!.focusNode.hasFocus
                  ? amountBtn()
                  : addressBtns(),
        ],
      ),
    );
  }

  void send() async {
    EthereumAddress? toAddress;
    try {
      toAddress = EthereumAddress.fromHex(address!.controller.text);
    } catch (e) {}
    if (toAddress == null) {
      showSnackBar(Strings.INVALID.tr + ' ' + Strings.ADDRESS.tr);
      return;
    }

    dynamic am = double.tryParse(amount!.controller.text);
    if (am == null) {
      showSnackBar(Strings.INVALID.tr + ' ' + Strings.AMOUNT.tr);
      return;
    }
    am = convertEtherToWei(am);
    setState(() {
      loading = true;
    });
    try {
      EthPrivateKey cred =
          await assetsController.ethClient!.credentialsFromPrivateKey(
        WalletController.walletCtl.walletModel!.addresses![0].privateKey,
      );
      String trxHash = await assetsController.ethClient!.sendTransaction(
        cred,
        Transaction(
          to: toAddress,
          gasPrice: EtherAmount.inWei(BigInt.from(10e8)),
          maxGas: 21000,
          value: EtherAmount.fromUnitAndValue(EtherUnit.wei, am),
        ),
        chainId: NetworkController.netCtl.networkModel!.chainId,
      );
      widget.getTrxs(forceUpdate: 'true');
      print('trx hash: ' + trxHash);
      showSnackBar(Strings.SUCCESS_DONE.tr);
      Timer(Duration(milliseconds: 1500), () {
        Get.back();
        Get.back();
      });
    } catch (e) {
      showSnackBar(e.toString());
      print(e.toString());
      setState(() {
        loading = false;
      });
    }
  }
}
