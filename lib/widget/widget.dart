import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:koimedic/widget/common.dart';

class CustomTextFormField extends StatefulWidget {
  final String hinttext;
  final bool obsecuretext;
  final TextEditingController? controller;
  const CustomTextFormField({
    super.key,
    required this.hinttext,
    required this.obsecuretext,
    this.controller,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obsecuretext,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(18),
          // border: InputBorder.none,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12)),
          hintText: widget.hinttext,
          hintStyle: Common().hinttext),
    );
  }
}

class CustomElevatedButton extends StatefulWidget {
  final String message;
  final FutureOr<void> Function() function;
  final Color? color;
  const CustomElevatedButton({
    super.key,
    required this.message,
    required this.function,
    this.color = const Color.fromARGB(255, 255, 17, 0),
  });

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        setState(() {
          loading = true;
        });
        // ignore: unnecessary_null_comparison
        if (widget.function != null) {
          await widget.function();
        }

        setState(() {
          loading = false;
        });
      },
      style: ButtonStyle(
          side: const WidgetStatePropertyAll(BorderSide(color: Colors.grey)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          fixedSize: const WidgetStatePropertyAll(Size.fromWidth(370)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(vertical: 20),
          ),
          backgroundColor: WidgetStatePropertyAll(widget.color)),
      child: loading
          ? const CupertinoActivityIndicator()
          : FittedBox(
              child: Text(
              widget.message,
              style: Common().semiboldwhite,
            )),
    );
  }
}

class DynamicFilledButton extends StatefulWidget {
  const DynamicFilledButton(
      {super.key, required this.child, required this.onPressed, this.color});

  final Widget child;
  // final VoidCallback onPressed;
  final Color? color;
  final FutureOr<void> Function() onPressed;

  @override
  State<DynamicFilledButton> createState() => _DynamicFilledButtonState();
}

class _DynamicFilledButtonState extends State<DynamicFilledButton> {
  bool isLoading = false;

  func() async {
    FocusManager.instance.primaryFocus?.unfocus();

    setState(() {
      isLoading = true;
    });

    await widget.onPressed();

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return FractionallySizedBox(
        widthFactor: .8,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CupertinoButton(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            color: widget.color ?? Common().black,
            onPressed: isLoading ? null : func,
            child:
                isLoading ? const CupertinoActivityIndicator() : widget.child,
          ),
        ),
      );
    }
    return FractionallySizedBox(
      widthFactor: .8,
      child: SizedBox(
        height: 48,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: widget.color ?? Common().maincolor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          onPressed: isLoading ? null : func,
          child: isLoading
              ? const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                )
              : widget.child,
        ),
      ),
    );
  }
}
