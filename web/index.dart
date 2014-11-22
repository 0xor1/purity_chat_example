/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library StopwatchClient;

import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:purity/client.dart';
import 'package:purity_chat_example/view/chat_app.dart';

void main(){
  initPolymer().run((){
    initConsumerSettings(
      (chatApp, proxyEndPoint){
        var consumer = new ChatAppConsumer(chatApp);
        document.body.children.add(consumer.view);
      },
      (){
        //No shutdown code required for this app
      },
      'ws');
  });
}