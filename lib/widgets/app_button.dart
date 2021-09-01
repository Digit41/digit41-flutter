import 'dart:async';
import 'dart:math';

import 'package:digit41/utils/app_theme.dart';
import 'package:digit41/utils/images_path.dart';
import 'package:digit41/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppButton extends StatefulWidget {
  String? title;
  Color? btnColor;
  Color? borderColor;
  Color? titleColor;
  GestureTapCallback? onTap;
  Widget? icon;
  double? titleSize;

  AppButton({
    @required this.title,
    this.btnColor,
    @required this.onTap,
    this.titleColor,
    this.borderColor,
    this.icon,
    this.titleSize,
  });

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with TickerProviderStateMixin {
  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      lowerBound: 0.0,
      upperBound: 0.05,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double scale = 1 - _animationController!.value;
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        setState(() {
          _animationController!.reverse();
        });
        Timer(Duration(milliseconds: 350), () {
          widget.onTap!();
          setState(() {
            _animationController!.forward();
          });
        });
      },
      child: Transform.scale(
        scale: scale,
        child: Container(
          decoration: BoxDecoration(
            color: widget.btnColor,
            border: widget.borderColor != null
                ? Border.all(width: 2.0, color: widget.borderColor!)
                : null,
            borderRadius: BorderRadius.all(Radius.circular(28.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black12, blurRadius: 5.0),
              BoxShadow(color: Colors.black12, blurRadius: 5.0),
              BoxShadow(color: Colors.black12, blurRadius: 5.0),
            ],
          ),
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // if (widget.icon != null)
              //   Container(width: 25.0, child: widget.icon),
              Expanded(
                child: Text(
                  widget.title!,
                  style: TextStyle(
                    color: widget.titleColor ?? Colors.black,
                    fontSize: widget.titleSize ?? 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 28.0,
                child: widget.icon ??
                    Transform.rotate(
                      angle: englishAppLanguage() ? 0.0 : pi,
                      child: Image.asset(
                        Images.ARROW_RIGHT,
                        color: widget.titleColor,
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppButton1 extends StatelessWidget {
  String title;
  GestureTapCallback? onTap;
  Widget icon;

  AppButton1({required this.title, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(
          AppTheme.gray.withOpacity(0.8),
        ),
        elevation: MaterialStateProperty.all(3.0),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.0)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: GetPlatform.isWeb ? 14.0 : 5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [icon, const SizedBox(width: 4.0), Text(title)],
        ),
      ),
    );
  }
}
