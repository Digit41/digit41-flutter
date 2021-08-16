import 'package:digit41/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTextFormField extends StatefulWidget {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  TextInputType? textInputType;
  String hint;
  int? length;
  bool showLengthFail;
  FocusNode? nextFocusNode;
  TextDirection? textDirection;
  Widget? suffixIcon;
  Widget? prefixIcon;
  bool obscure;
  bool enable;

  FormFieldValidator<String>? validator;
  ValueChanged<String>? onFieldSubmitted;
  FormFieldValidator<String>? onChanged;
  TextInputAction? textInputAction;

  int? maxLine;

  bool autoValidateMode;
  bool autoFocus;

  AppTextFormField({
    required this.hint,
    this.validator,
    this.onFieldSubmitted,
    this.onChanged,
    this.textInputType,
    this.length,
    this.nextFocusNode,
    this.textDirection,
    this.suffixIcon,
    this.prefixIcon,
    this.enable = true,
    this.showLengthFail = true,
    this.obscure = false,
    this.maxLine,
    this.textInputAction,
    this.autoValidateMode = true,
    this.autoFocus = false,
  });

  @override
  _AppTextFormFieldState createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  @override
  void dispose() {
    widget.controller.dispose();
    widget.focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: widget.autoFocus,
      validator: widget.validator ?? selfValidator,
      onFieldSubmitted: widget.onFieldSubmitted ?? selfSubmit,
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChanged,
      maxLength: widget.length,
      textDirection: widget.textDirection,
      enabled: widget.enable,
      maxLines: widget.maxLine,
      keyboardType: widget.textInputType != null
          ? widget.textInputType
          : TextInputType.text,
      textCapitalization: TextCapitalization.none,
      textInputAction: widget.textInputAction != null
          ? widget.textInputAction
          : widget.nextFocusNode != null
              ? TextInputAction.next
              : TextInputAction.done,
      autocorrect: false,
      autovalidateMode:
          widget.autoValidateMode ? AutovalidateMode.onUserInteraction : null,
      cursorColor: Theme.of(context).primaryColor,
      style: TextStyle(height: widget.enable ? 1.6 : 2.5),
      decoration: InputDecoration(
        counterText: "",
        hintText: widget.hint,
        contentPadding: widget.maxLine != null
            ? null
            : const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 4.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        suffixIcon: widget.suffixIcon,
        prefixIcon: widget.prefixIcon,
      ),
    );
  }

  String? selfValidator(String? value) {
    if (value!.isEmpty)
      return Strings.PLEASE.tr +
          ' ' +
          Strings.ENTER_SELF.tr +
          ' ' +
          widget.hint;
    else if (widget.length != null &&
        value.length < widget.length!.toInt() &&
        widget.showLengthFail)
      return '${widget.length} ' + Strings.NUMBER.tr;
    else
      return null;
  }

  void selfSubmit(String value) {
    widget.focusNode.unfocus();
    if (widget.nextFocusNode != null)
      FocusScope.of(context).requestFocus(widget.nextFocusNode);
  }
}
