import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import '../../view_models/login_views_models/login_text_field_view_model.dart';

class LoginTextFieldWidget extends StatefulWidget {
  LoginTextFieldWidget({
    this.hint,
    this.textInputType,
    this.controller,
    this.validationFun,
    this.onChangeFun,
    this.fieldTextDirection,
  });

  final String? hint;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?)? validationFun;
  final Function(String)? onChangeFun;
  final TextDirection? fieldTextDirection;


  @override
  State<LoginTextFieldWidget> createState() => _LoginTextFieldWidgetState();
}

class _LoginTextFieldWidgetState extends State<LoginTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<LoginTextFieldViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: TextFormField(
        onChanged: widget.onChangeFun,
        controller: widget.controller,
        validator: widget.validationFun,
        textDirection: widget.fieldTextDirection,
        keyboardType: widget.textInputType,
        obscuringCharacter: "*",
        obscureText: provider.getItIsObscureOrNot(widget.textInputType, provider),
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: (widget.textInputType == TextInputType.visiblePassword)
              ? IconButton(
                  onPressed: () {
                    provider.changeEyeIconAndColor();
                  },
                  icon: Icon(
                    provider.eyeIcon,
                    color: provider.eyeColor,
                  ),
                )
              : const Icon(Icons.alternate_email_rounded),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
          ),
        ),
      ),
    );
  }
}
