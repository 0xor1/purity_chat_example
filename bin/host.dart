/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library chat.host;

import 'dart:io';
import 'package:purity/host.dart';
import 'package:purity_chat_example/model/chat.dart';
import 'package:purity_oauth2/model/oauth2.dart';

void main(){

  var chatRoom = new ChatRoom();

  new Host(
    InternetAddress.ANY_IP_V4,
    4346,
    Platform.script.resolve('../web').toFilePath(),
    (_) => new ChatApp(generateLogin(), chatRoom),
    (chatApp) => chatApp.close(),
    0)
  ..start()
  .then((router){
    Login.setupOAuth2RedirectRouteListener(router, '/oauth2redirect');
  });
}

GoogleLogin generateLogin(){
  return new GoogleLogin(
      'http://localhost:4346/oauth2redirect',
      '699137532585-f9lnapfhl52t6fmr38r6vg6tsd375bbh.apps.googleusercontent.com',
      'Bq67VLXsFkaZKdfaJ1A1vU8A',
      ['https://www.googleapis.com/auth/userinfo.profile']);
}