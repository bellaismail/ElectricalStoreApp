import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store_app2/view_models/register_views_models/register_text_field_view_model.dart';

import '../../constant.dart';

class RegisterTextFieldWidget extends StatefulWidget {
  RegisterTextFieldWidget({
    this.hint,
    this.textInputType,
    this.suffixIcon,
    this.controller,
    this.iconButtonFun,
    this.validator,
    this.onChangeFun,
    this.fieldTextDirection,
  });

  final String? hint;
  final TextInputType? textInputType;
  IconData? suffixIcon;
  final String? Function(String?)? validator;
  final Function()? iconButtonFun;
  TextEditingController? controller;
  final Function(String)? onChangeFun;
  final TextDirection? fieldTextDirection;

  @override
  State<RegisterTextFieldWidget> createState() =>
      _RegisterTextFieldWidgetState();
}

class _RegisterTextFieldWidgetState extends State<RegisterTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<RegisterTextFieldViewModel>(context);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        onChanged: widget.onChangeFun,
        textDirection: widget.fieldTextDirection,
        keyboardType: widget.textInputType,
        obscuringCharacter: "*",
        obscureText: widget.suffixIcon == Icons.visibility_off_rounded ? true : false,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: widget.hint,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: widget.suffixIcon == null
              ? null
              : IconButton(
                  onPressed: widget.iconButtonFun,
                  //     () {
                  //   setState(() {
                  //     if (widget.suffixIcon == Icons.visibility_off_rounded) {
                  //       widget.suffixIcon = Icons.visibility;
                  //     } else {
                  //       widget.suffixIcon = Icons.visibility_off_rounded;
                  //     }
                  //   });
                  // },
                  icon: Icon(widget.suffixIcon),
                ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(kDefaultPadding / 1.5),
          ),
        ),
      ),
    );
  }
}
