/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library chat.model;

import 'package:purity/purity.dart';
import 'package:purity_oauth2/interface/oauth2.dart';
import '../interface/chat.dart';

/**
 * the [ChatApp] is simply a wrapper around an [ILogin] that emits
 * a [ChatRoomAccessed] event containing the [IChatRoomAccessPoint]
 * object once the user has logged in, and the app has retreived the
 * users basic profile info.
 */
class ChatApp extends Source implements IChatApp{

  final ILogin _login;
  final ChatRoom _chatRoom;
  ChatRoomAccessPoint accessPoint;

  ChatApp(this._login, this._chatRoom){
    registerChatTranTypes();
    listen(_login, All, _loginHandler);
  }

  void login(){
    _login.login();
  }

  void _loginHandler(Event e){
    emit(e.data);
    if(e.data is OAuth2LoginAccessGranted){
      _login.requestUserDetails();
    }else if(e.data is OAuth2LoginUserDetails){
      OAuth2LoginUserDetails user = e.data;
      accessPoint = _chatRoom.getAccessPoint(user.displayName, user.imageUrl);
      emit(new ChatRoomAccessed()..chatRoomAccessPoint = accessPoint);
    }
  }

  void close(){
    _login.close();
    if(accessPoint != null){
      accessPoint._close();
    }
    ignoreAll();
  }
}

/// The [ChatRoom] is basically an [IChatRoomAccessPoint] factory, and central point for broadcasting
/// messages to the [IChatRoomAccessPoint]s it has created.
class ChatRoom extends Object with Emitter{

  IChatRoomAccessPoint getAccessPoint(String userDisplayName, String userAvatarUrl){
    emit(
      new UserEnteredChatRoom()
      ..userAvatarUrl = userAvatarUrl
      ..userDisplayName = userDisplayName);
    return new ChatRoomAccessPoint(userDisplayName, userAvatarUrl, this);
  }

  void broadcastMessage(String message, String userDisplayName, String userAvatarUrl){
    emit(
      new ChatRoomMessage()
      ..message = message
      ..userDisplayName = userDisplayName
      ..userAvatarUrl = userAvatarUrl);
  }

  void broadcastUserLeft(String userAvatarUrl, String userDisplayName){
    emit(
      new UserLeftChatRoom()
      ..userAvatarUrl = userAvatarUrl
      ..userDisplayName = userDisplayName);
  }
}

class ChatRoomAccessPoint extends Source implements IChatRoomAccessPoint{
  final String userDisplayName;
  final String userAvatarUrl;
  final ChatRoom chatRoom;

  ChatRoomAccessPoint(this.userDisplayName, this.userAvatarUrl, this.chatRoom){
    listen(chatRoom, All, (e) => emit(e.data));
  }

  void say(String message) => chatRoom.broadcastMessage(message, userDisplayName, userAvatarUrl);

  void _close(){
    ignoreAll();
    chatRoom.broadcastUserLeft(userAvatarUrl, userDisplayName);
  }
}