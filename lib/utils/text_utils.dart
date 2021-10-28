import 'package:flutter/cupertino.dart';

class TextUtils {
  //使用 textController 时位置处理
  static TextEditingValue buildTextEditingValue(String value) {
    return TextEditingValue(
        ///用来设置文本 controller.text = "0000"
        text: value,
        ///设置光标的位置
        selection: TextSelection.fromPosition(
          ///用来设置文本的位置
          TextPosition(
              affinity: TextAffinity.downstream,
              /// 光标向后移动的长度
              offset: value.length),
        ));
  }
}
