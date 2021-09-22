import 'package:digit41/widgets/app_bottom_sheet.dart';
import 'package:digit41/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:digit41/models/network_model.dart';
import 'package:digit41/utils/strings.dart';
import 'package:digit41/widgets/app_text_form_field.dart';
import 'package:hive/hive.dart';

void network(Box netBox, {NetworkModel? netModel}) {
  _Netwotk _netwotk = _Netwotk(netBox, netModel: netModel);

  bottomSheet(Strings.DETAIL.tr, child: _netwotk);
}

class _Netwotk extends StatelessWidget {
  Box netBox;
  NetworkModel? netModel;
  final formKey = GlobalKey<FormState>();
  bool showButtons = true;
  AppTextFormField? blockUrl;
  AppTextFormField? currSymbol;
  AppTextFormField? chainId;
  AppTextFormField? rpcUrl;
  AppTextFormField? netName;

  _Netwotk(this.netBox, {this.netModel, Key? key}) : super(key: key) {
    blockUrl = AppTextFormField(
      hint: Strings.BLOCK_EXP_URL.tr,
      textInputType: TextInputType.url,
      enable: netModel != null && !netModel!.byUser ? false : true,
      hasTitle: true,
    );

    currSymbol = AppTextFormField(
      hint: Strings.CURRENCY_SYMBOL.tr,
      nextFocusNode: blockUrl!.focusNode,
      enable: netModel != null && !netModel!.byUser ? false : true,
      hasTitle: true,
    );

    chainId = AppTextFormField(
      hint: Strings.CHAIN_ID.tr,
      nextFocusNode: currSymbol!.focusNode,
      enable: netModel != null && !netModel!.byUser ? false : true,
      textInputType: TextInputType.number,
      hasTitle: true,
    );
    rpcUrl = AppTextFormField(
      hint: Strings.NEW_RPC_URL.tr,
      textInputType: TextInputType.url,
      nextFocusNode: chainId!.focusNode,
      enable: netModel != null && !netModel!.byUser ? false : true,
      hasTitle: true,
    );
    netName = AppTextFormField(
      hint: Strings.NETWORK_NAME.tr,
      nextFocusNode: rpcUrl!.focusNode,
      enable: netModel != null && !netModel!.byUser ? false : true,
      hasTitle: true,
    );

    if (netModel != null) {
      netName!.controller.text = netModel!.name!;
      rpcUrl!.controller.text = netModel!.url!;
      chainId!.controller.text = netModel!.chainId.toString();
      currSymbol!.controller.text = netModel!.currencySymbol!;
      blockUrl!.controller.text = netModel!.blockExplorerURL!;
      showButtons = netModel!.byUser;
    }
  }

  void save() {
    if (formKey.currentState!.validate()) {
      int? c = int.tryParse(chainId!.controller.text);
      if (c == null) {
        chainId!.controller.text = '';
        return;
      }
      NetworkModel nm = NetworkModel(
        byUser: true,
        name: netName!.controller.text,
        url: rpcUrl!.controller.text,
        chainId: c,
        currencySymbol: currSymbol!.controller.text,
        blockExplorerURL: blockUrl!.controller.text,
      );
      if (netModel == null)
        netBox.add(nm);
      else {
        netModel!.name = nm.name;
        netModel!.url = nm.url;
        netModel!.chainId = nm.chainId;
        netModel!.currencySymbol = nm.currencySymbol;
        netModel!.blockExplorerURL = nm.blockExplorerURL;
        netModel!.save();
      }
      netBox.close();
      Get.back();
    }
  }

  Widget showButton(child) => showButtons ? child : const Center();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(height: 8.0),
          netName!,
          const SizedBox(height: 16.0),
          rpcUrl!,
          const SizedBox(height: 16.0),
          chainId!,
          const SizedBox(height: 16.0),
          currSymbol!,
          const SizedBox(height: 16.0),
          blockUrl!,
          showButton(const SizedBox(height: 24.0)),
          showButton(AppButton(
            title: Strings.SAVE.tr,
            onTap: save,
            btnColor: Get.theme.primaryColor,
          )),
          showButton(const SizedBox(height: 12.0)),
          showButton(
            netModel == null
                ? const Center()
                : AppButton(
                    title: Strings.DELETE.tr,
                    onTap: () {
                      confirmBottomSheet(
                        Strings.WARNING.tr,
                        Strings.DESC_NETWORK_DELETE.tr,
                        () {
                          netModel!.delete();
                          Get.back();
                          Get.back();
                        },
                        Strings.YES.tr,
                      );
                    },
                    btnColor: Colors.red,
                  ),
          ),
        ],
      ),
    );
  }
}
