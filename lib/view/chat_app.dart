import 'dart:html';
import 'package:purity/purity.dart' as purity;
import 'package:purity_chat_example/interface/chat.dart';
import 'package:polymer/polymer.dart';
import 'package:purity_chat_example/view/chat_room.dart';
import 'package:purity_oauth2/view/google_login.dart';

@CustomTag('chat-app')
class ChatApp extends PolymerElement with purity.Receiver{

  ChatAppConsumer consumer;
  DivElement root;
  ChatRoomConsumer chatRoomConsumer;
  GoogleLoginConsumer googleLoginConsumer;
  WindowBase _loginWindow;

  ChatApp.created(): super.created();

  @override
  void attached() {
    super.attached();
    root = $['root'];
  }

  void _initSourceBinding(){
    consumer.source.requestLoginObject();
    listen(consumer.source, ChatRoomAccessed, _handleChatRoomAccessed);
    listen(consumer.source, LoginObjectRequest, _handleLoginObjectRequest);
  }

  void _handleChatRoomAccessed(purity.Event<ChatRoomAccessed> e){
    googleLoginConsumer.dispose();
    chatRoomConsumer = new ChatRoomConsumer(e.data.chatRoomAccessPoint);
    root.append(chatRoomConsumer.view);
  }

  void _handleLoginObjectRequest(purity.Event<LoginObjectRequest> e){
    if(googleLoginConsumer == null){
      googleLoginConsumer = new GoogleLoginConsumer(e.data.login);
      root.append(googleLoginConsumer.view);
    }
  }
}

class ChatAppConsumer extends purity.Consumer{
  final ChatApp view = new Element.tag('chat-app');

  ChatAppConsumer(src) : super(src){
    registerChatTranTypes();
    view.consumer = this;
    view._initSourceBinding();
  }

  void dispose(){
    view.remove();
    view.chatRoomConsumer.dispose();
    view.googleLoginConsumer.dispose();
    super.dispose();
  }
}
