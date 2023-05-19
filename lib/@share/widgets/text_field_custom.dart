import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart';
import '../values/colors.dart';
import '../values/styles.dart';

TextFormField phoneFormFieldCustom(
        {TextEditingController? controller,
        FocusNode? focusNode,
        Widget? icon,
        bool fieldRequiredDanger = true,
        Widget? suffixIcon,
        String? hintText,
        String? errorText,
        String? labelText,
        String? Function(String?)? validator,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
          labelText: labelText,
          filled: true, //<-- SEE HERE
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: hintText,
          hintStyle: appStyle.copyWith(color: Colors.grey)),
    );
TextFormField textFormFieldCustom(
        {TextEditingController? controller,
        bool readOnly = false,
        FocusNode? focusNode,
        Widget? icon,
        Widget? suffixIcon,
        bool fieldRequiredDanger = true,
        String? hintText,
        String? errorText,
        String? labelText,
        String? Function(String?)? validator,
        void Function()? onTap,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      controller: controller,
      keyboardType: TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: labelText,
          filled: true, //<-- SEE HERE
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: hintText,
          hintStyle: appStyle.copyWith(color: Colors.grey)),
    );

TextFormField textFormFieldPasswordCustom(
        {TextEditingController? controller,
        Widget? suffixIcon,
        String? hintText,
        String? errorText,
        FocusNode? focusNode,
        String? labelText,
        required bool obscureText,
        bool fieldRequiredDanger = true,
        String? Function(String?)? validator,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
          labelText: labelText,
          filled: true, //<-- SEE HERE
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20.0),
          ),
          hintText: hintText,
          hintStyle: appStyle.copyWith(color: Colors.grey)),
    );
TextFormField textFormFieldProfile(
        {TextEditingController? controller,
        FocusNode? focusNode,
        Widget? icon,
        Widget? suffixIcon,
        String? initValue,
        String? errorText,
        bool canEdit = true,
        String? Function(String?)? validator,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      controller: controller,
      keyboardType: TextInputType.text,
      initialValue: initValue,
      readOnly: canEdit ? false : true,
      decoration: InputDecoration(
        filled: true, //<-- SEE HERE
        fillColor: gray.shade50,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redDanger, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redDanger),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: canEdit
              ? BorderSide(color: bluePrimary, width: 1.5)
              : const BorderSide(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        suffixIcon: canEdit
            ? Icon(
                Icons.edit,
                size: 18,
                color: Colors.grey.shade400,
              )
            : const SizedBox(),
      ),
    );
TextFormField textFieldPhoneEmail(
        {FocusNode? focusNode,
        String? text,
        String? errorText,
        bool isKeyNumber = false,
        bool fieldRequiredDanger = true,
        TextEditingController? textEditingController,
        Function? validator,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      onChanged: onChanged,
      textInputAction: TextInputAction.done,
      controller: textEditingController ?? TextEditingController(text: text),
      validator: (value) {
        if (validator == null) {
          if (isNullOrEmptyString(value) && fieldRequiredDanger) {
            return "Không để trống";
          }
          return null;
        } else {
          return validator(value);
        }
      },
      keyboardType: isKeyNumber ? TextInputType.phone : null,
      decoration: InputDecoration(
        filled: true, //<-- SEE HERE
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bluePrimary, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redDanger, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: redDanger),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: bluePrimary, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
TextFormField textFieldChatCustom(
        {TextEditingController? controller,
        FocusNode? focusNode,
        bool fieldRequiredDanger = true,
        String? hintText,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      focusNode: focusNode,
      textDirection: TextDirection.ltr,
      cursorColor: Colors.white,
      style: appStyle.copyWith(color: Colors.white),
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          filled: true, //<-- SEE HERE
          fillColor: pink,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          hintText: hintText,
          hintStyle: appStyle.copyWith(color: Colors.white)),
    );
TextFormField textFieldChangeNameCustom(
        {TextEditingController? controller,
        FocusNode? focusNode,
        bool fieldRequiredDanger = true,
        String? hintText,
        String? initValue,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      initialValue: initValue,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      focusNode: focusNode,
      textDirection: TextDirection.ltr,
      style: appStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          filled: true, //<-- SEE HERE
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          // border: OutlineInputBorder(

          //   borderRadius: BorderRadius.circular(20.0),
          //   borderSide: const BorderSide(
          //     width: 0,
          //     style: BorderStyle.none,
          //   ),
          // ),
          hintText: hintText,
          hintStyle: appStyle.copyWith(color: Colors.grey)),
    );
TextFormField textFieldChangePassCustom(
        {TextEditingController? controller,
        FocusNode? focusNode,
        bool fieldRequiredDanger = true,
        String? hintText,
        String? initValue,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      obscureText: true,
      initialValue: initValue,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      focusNode: focusNode,
      textDirection: TextDirection.ltr,
      style: appStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          filled: true, //<-- SEE HERE
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 5),
            borderRadius: BorderRadius.circular(5.0),
          ),
          // border: OutlineInputBorder(

          //   borderRadius: BorderRadius.circular(20.0),
          //   borderSide: const BorderSide(
          //     width: 0,
          //     style: BorderStyle.none,
          //   ),
          // ),
          hintText: hintText,
          hintStyle: appStyle.copyWith(color: Colors.grey)),
    );
TextFormField textSearchFieldCustom(
        {TextEditingController? controller,
        FocusNode? focusNode,
        Widget? icon,
        Widget? prefixIcon,
        bool fieldRequiredDanger = true,
        String? hintText,
        String? errorText,
        String? labelText,
        String? Function(String?)? validator,
        void Function(String)? onFieldSubmitted,
        void Function(String)? onChanged}) =>
    TextFormField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: TextInputType.text,
      validator: validator,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          filled: true, //<-- SEE HERE
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: hintText,
          hintStyle: appStyle.copyWith(color: Colors.grey)),
    );
