part of 'bottom_sheet.dart';

void trxDetailsBottomSheet(
  BuildContext context,
  TrxModel trx,
  AssetModel assetModel,
) {
  Widget _anyItemOfInfo(String title, String value) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: AppTheme.gray,
                fontSize: MediaQuery.of(context).size.width * 0.025),
          ),
          Text(
            value,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.019),
          ),
        ],
      );

  _coinOperationsBottomSheet(
    context,
    assetModel.icon!,
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
              trx.amount.toString(),
              style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                assetModel.symbol!,
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
        _anyItemOfInfo(Strings.FROM.tr, trx.sender!),
        const SizedBox(height: 10.0),
        _anyItemOfInfo(Strings.TO.tr, trx.recipient!),
        const SizedBox(height: 10.0),
        _anyItemOfInfo(Strings.TRX_HASH.tr, trx.hash!),
        const SizedBox(height: 10.0),
        _anyItemOfInfo(Strings.FEE.tr, trx.fee.toString()),
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
