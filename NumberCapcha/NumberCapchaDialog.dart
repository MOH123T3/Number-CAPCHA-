// ignore_for_file: file_names, unnecessary_this, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'NumberCapcha.dart';

class NumberCaptchaDialog extends StatefulWidget {
  const NumberCaptchaDialog(
    this.titleText,
    this.placeholderText,
    this.checkCaption,
    this.invalidText, {
    Key? key,
    this.accentColor,
  }) : super(key: key);

  final String titleText;
  final String placeholderText;
  final String checkCaption;
  final String invalidText;
  final Color? accentColor;

  @override
  State<NumberCaptchaDialog> createState() => _NumberCaptchaDialogState();
}

class _NumberCaptchaDialogState extends State<NumberCaptchaDialog> {
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String code = '';

  bool? isValid;
  bool? _validate;
  @override
  initState() {
    generateCode();
    super.initState();
  }

  void generateCode() {
    Random random = Random();
    code = (random.nextInt(9000) + 1000).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Material(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    widget.titleText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.accentColor ?? Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberCaptcha(
                      code,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: widget.accentColor ?? Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: Material(
                        // ignore: sort_child_properties_last
                        child: InkWell(
                          onTap: () {
                            generateCode();
                          },
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isValid == false
                          ? Colors.red
                          : widget.accentColor ?? Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: textController,
                          autofocus: true,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(4),
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: widget.placeholderText,
                          ),
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (String value) {
                            isValid = null;
                            _validate = null;
                            if (textController.text == code) {
                              isValid = true;
                              _validate = true;
                              Navigator.pop(context, true);
                            } else if (textController.text == "") {
                              isValid = false;
                              _validate = true;
                              setState(() {});
                            } else {
                              setState(() {
                                _validate = false;
                                isValid = true;
                              });
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: widget.accentColor ?? Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              isValid = null;
                              _validate = null;

                              if (textController.text == code) {
                                isValid = true;
                                _validate = true;
                                Navigator.pop(context, true);
                              } else if (textController.text == "") {
                                isValid = false;
                                _validate = true;
                                setState(() {});
                              } else {
                                setState(() {
                                  _validate = false;
                                  isValid = true;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Center(
                                child: Text(
                                  widget.checkCaption,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: _validate == false ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          widget.invalidText,
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: isValid == false ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text(
                          "Please enter number",
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
