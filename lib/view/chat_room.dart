import 'dart:html';
import 'package:purity/purity.dart' as purity;
import 'package:purity_chat_example/interface/chat.dart';
import 'package:polymer/polymer.dart';

@CustomTag('chat-room')
class ChatRoom extends PolymerElement with purity.Receiver{

  ChatRoomConsumer consumer;
  DivElement feed;
  TextAreaElement input;

  ChatRoom.created(): super.created();

  @override
  void attached() {
    super.attached();
    feed = $['feed'];
    input = $['input'];
    _initHtmlBinding();
  }

  @override
  void detached() {
    super.detached();
  }

  void _initSourceBinding(){
    listen(consumer.source, ChatRoomMessage, _handleChatRoomMessage);
    listen(consumer.source, UserEnteredChatRoom, _handleUserEnteredChatRoom);
    listen(consumer.source, UserLeftChatRoom, _handleUserLeftChatRoom);
  }

  void _initHtmlBinding(){
    var regex = new RegExp(r'\S');
    input.onKeyUp.listen((e){
      var message = input.value.trim();
      if(e.keyCode == KeyCode.ENTER && !e.shiftKey && message.length > 0){
        consumer.source.say(message);
        input.value = '';
      }
    });
  }

  void _writeEntryToFeed(String userAvatarUrl, String title, String body){
    // TODO replace this with another custom polymer element
    feed.appendHtml('''
      <div class="entry">
        <div class="heading">
          <img width="30" height="30" src="$userAvatarUrl">
          <strong>$title</strong>
        </div>
        <div class="body">$body</div>
      </div>
    ''');
    feed.children.last.scrollIntoView();
  }

  void _handleChatRoomMessage(purity.Event<ChatRoomMessage> e){
    var msg = e.data;
    _writeEntryToFeed(msg.userAvatarUrl, msg.userDisplayName, msg.message);
  }

  void _handleUserEnteredChatRoom(purity.Event<UserEnteredChatRoom> e){
    var userEntered = e.data;
    _writeEntryToFeed(userEntered.userAvatarUrl, userEntered.userDisplayName + ' has entered the chat room.', '');
  }

  void _handleUserLeftChatRoom(purity.Event<UserLeftChatRoom> e){
    var userEntered = e.data;
    _writeEntryToFeed(userEntered.userAvatarUrl, userEntered.userDisplayName + ' has left the chat room.', '');
  }
}

class ChatRoomConsumer extends purity.Consumer{
  final ChatRoom view = new Element.tag('chat-room');

  ChatRoomConsumer(src) : super(src){
    registerChatTranTypes();
    view.consumer = this;
    view._initSourceBinding();
  }

  void dispose(){
    view.remove();
    super.dispose();
  }
}
