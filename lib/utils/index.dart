// 处理url
String handleUrl(url) {
  RegExp isUri = new RegExp(r'^\/\/');

  if (isUri.hasMatch(url)) {
    url = 'https:' + url;
  }

  return url;
}

// 处理颜色
int handleColor(String color) {
  return int.parse(('0xff' + color.substring(1)).toString());
}
