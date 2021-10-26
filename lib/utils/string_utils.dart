/*
 * @Description: 字符串工具类
 * @Author: 赵强
 * @Date: 2019-07-15 13:29:07
 * @LastEditTime: 2019-09-19 15:22:06
 * @LastEditors: Please set LastEditors
 */
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart';

class StringUtils {
  /** 返回当前时间戳 */
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  /** 复制到剪粘板 */
  static copyToClipboard(final String text) {
    if (text == null) return;
    Clipboard.setData(new ClipboardData(text: text));
  }

  // md5 加密
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }

  static String getReplaceString(
      String raw, String replaceStr, int start, int end) {
    int length = raw.length;
    if (start >= length || end >= length || start > end) {
      return raw;
    }
    StringBuffer sb = new StringBuffer();
    for (int i = 0; i < length; i++) {
      String c = raw[i];
      if (i >= start && i <= end) {
        sb.write(replaceStr);
      } else {
        sb.write(c);
      }
    }
    return sb.toString();
  }

  ///大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  /// 此方法中前三位格式有：
  /// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isMobileChina(String str) {
    return new RegExp('^(1[0-9][0-9])\\d{8}\$').hasMatch(str);
  }

  static String imageWrapAssets(String url) {
    return "assets/images/" + url;
  }




  //生成网络请求签名
  static String GetSign(Map<String, String> paramMap,String appKey, String appSecret, String timestamp, String nonce){
    Map<String, String> signMap =Map();
    signMap.addAll(paramMap);
    signMap["appKey"]= appKey;
    signMap["timestamp"]= timestamp;
    signMap["nonce"]=nonce;
    Map<String, String> filterMap = paraFilter(signMap);
    String needSignStr = createLinkString(filterMap);
    needSignStr = needSignStr + appSecret;
    String sign = generateMd5(needSignStr);
    return sign;
  }

  static Map<String, String> paraFilter(Map<String, String> sArray) {
    Map<String, String> result = Map();
    if (sArray != null && sArray.length > 0) {

      List<String> tKeys=sArray.keys.toList();
      for(int i=0;i<tKeys.length;i++){

        String key = tKeys[i];
        String? value = sArray[key];
        if (value != null && (!value.isEmpty) && (key!="sign")) {
          result[key]= value;
        }
      }
      return result;
    } else {
      return result;
    }
  }

   static String createLinkString(Map<String, String> paramMap) {
    List<String> tKeys = paramMap.keys.toList();
    tKeys.sort();
    String prestr = "";
    for(int i = 0; i < tKeys.length; ++i) {
      String key = tKeys[i];
      String? value = paramMap[key];
      if (i == tKeys.length - 1) {
        prestr = prestr + key + "=" + value!;
      } else {
        prestr = prestr + key + "=" + value! + "&";
      }
    }
    return prestr;
  }


   static int GetRandom() {
    int max = 9999999;
    int min = 1000000;
    Random random = Random();
    int s = random.nextInt(max) % (max - min + 1) + min;
    return s;
  }

  static Map<String, String> getRequestMap(){

    return {};
  }

}
