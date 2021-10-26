//****************************
// Copyright (C),视游互动-家有课堂
// 创建时间：2021年 08月20日 11:46
// 项目名称：kt720_flutter  
// @author 赵强
// @version 1.0
// 文件名称：langure  
// 类说明：  
//***************************/

import 'package:get/get_navigation/src/root/internacionalization.dart';
//语言
class Langure extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'home_lab': 'Home',
    },
    'zh_CN': {
      'home_lab': '首页',
    }
  };

}