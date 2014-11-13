/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library chat.test.integration.purity;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:purity/local.dart';
import 'package:purity/client.dart' as client;
import 'package:purity_chat_example/model/chat.dart' as model;
import 'package:purity_chat_example/view/chat_app.dart' as view;
import 'package:purity_oauth2/mock_model/oauth2.dart';

void main(){

  initPolymer();

  var chatRoom = new model.ChatRoom();

  var host = new Host(
    (_) => new model.ChatApp(new MockLogin(), chatRoom),
    (chatApp) => chatApp.close(),
    0);

  var hostView = new client.LocalHostView(host);

  initConsumerSettings(
    (chatApp, proxyEndPoint){
      var consumer = new view.ChatAppConsumer(chatApp);
      hostView.addNewClientView(proxyEndPoint, consumer.view, 300);
    },
    (){});

  document.body.append(hostView.html);
}
