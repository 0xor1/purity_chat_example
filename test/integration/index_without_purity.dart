/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library chat.test.integration.raw;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:purity_oauth2/mock_model/oauth2.dart';
import 'package:purity_chat_example/model/chat.dart' as model;
import 'package:purity_chat_example/view/chat_app.dart' as view;

void main(){
  initPolymer().run((){
    var chatRoom = new model.ChatRoom();

    var chatApp1 = new model.ChatApp(new MockLogin(), chatRoom);
    var consumer1 = new view.ChatAppConsumer(chatApp1);
    querySelector('#client-one').children.add(consumer1.view);

    var chatApp2 = new model.ChatApp(new MockLogin(), chatRoom);
    var consumer2 = new view.ChatAppConsumer(chatApp2);
    querySelector('#client-two').children.add(consumer2.view);

    var chatApp3 = new model.ChatApp(new MockLogin(), chatRoom);
    var consumer3 = new view.ChatAppConsumer(chatApp3);
    querySelector('#client-three').children.add(consumer3.view);

    var chatApp4 = new model.ChatApp(new MockLogin(), chatRoom);
    var consumer4 = new view.ChatAppConsumer(chatApp4);
    querySelector('#client-four').children.add(consumer4.view);
  });
}