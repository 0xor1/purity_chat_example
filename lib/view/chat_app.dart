import 'dart:html';
import 'package:purity/purity.dart' as purity;
import 'package:purity_chat_example/interface/chat.dart';
import 'package:polymer/polymer.dart';
import 'package:paper_elements/paper_button.dart';
import 'package:purity_chat_example/view/chat_room.dart';
import 'package:purity_oauth2/interface/oauth2.dart';

@CustomTag('chat-app')
class ChatApp extends PolymerElement with purity.Receiver{

  ChatAppConsumer consumer;
  DivElement root;
  PaperButton loginButton;
  ChatRoomConsumer chatRoomConsumer;
  WindowBase _loginWindow;

  ChatApp.created(): super.created();

  @override
  void attached() {
    super.attached();
    root = $['root'];
    loginButton = $['login-button'];
    loginButton.onClick.listen((_) => consumer.source.login());
  }

  void _initSourceBinding(){
    listen(consumer.source, OAuth2LoginUrlRedirection, _handleOAuth2LoginUrlRedirection);
    listen(consumer.source, OAuth2LoginAccessGranted, _handleOAuth2LoginAccessGranted);
    listen(consumer.source, ChatRoomAccessed, _handleChatRoomAccessed);
  }

  void _handleOAuth2LoginUrlRedirection(purity.Event<OAuth2LoginUrlRedirection> e){
    _loginWindow = window.open(e.data.url, 'google-login');
  }

  void _handleOAuth2LoginAccessGranted(purity.Event<OAuth2LoginAccessGranted> e){
    if(_loginWindow != null) _loginWindow.close();
  }

  void _handleChatRoomAccessed(purity.Event<ChatRoomAccessed> e){
    loginButton.remove();
    chatRoomConsumer = new ChatRoomConsumer(e.data.chatRoomAccessPoint);
    root.append(chatRoomConsumer.view);
  }
}

class ChatAppConsumer extends purity.Consumer{
  final ChatApp view = new Element.tag('chat-app');

  ChatAppConsumer(src) : super(src){
    registerChatTranTypes();
    registerPurityOAuth2TranTypes();
    view.consumer = this;
    view._initSourceBinding();
  }

  void dispose(){
    view.remove();
    view.chatRoomConsumer.dispose();
    super.dispose();
  }
}
