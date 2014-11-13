/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library chat.interface;

import 'package:purity/purity.dart';

abstract class IChatApp implements Source{
  /// initiates the user login flow, if successful this should result in a
  /// [ChatRoomAccessed] event containing an [IChatRoomAccessPoint] Source
  void login();
}

abstract class IChatRoomAccessPoint implements Source{
  void say(String message);
}

class ChatRoomAccessed extends Transmittable{
  dynamic get chatRoomAccessPoint => get('chatRoomAccessPoint');
  void set chatRoomAccessPoint (dynamic o) => set('chatRoomAccessPoint', o);
}

class UserEnteredChatRoom extends Transmittable{
  String get userAvatarUrl => get('userAvatarUrl');
  void set userAvatarUrl (String o) => set('userAvatarUrl', o);
  String get userDisplayName => get('userDisplayName');
  void set userDisplayName (String o) => set('userDisplayName', o);
}

class UserLeftChatRoom extends Transmittable{
  String get userAvatarUrl => get('userAvatarUrl');
  void set userAvatarUrl (String o) => set('userAvatarUrl', o);
  String get userDisplayName => get('userDisplayName');
  void set userDisplayName (String o) => set('userDisplayName', o);
}

class ChatRoomMessage extends Transmittable{
  String get message => get('message');
  void set message (String o) => set('message', o);
  String get userAvatarUrl => get('userAvatarUrl');
  void set userAvatarUrl (String o) => set('userAvatarUrl', o);
  String get userDisplayName => get('userDisplayName');
  void set userDisplayName (String o) => set('userDisplayName', o);
}

final Registrar registerChatTranTypes = generateRegistrar('chat.interface', 'ci', [
   new TranRegistration.subtype(ChatRoomAccessed, () => new ChatRoomAccessed()),
   new TranRegistration.subtype(ChatRoomMessage, () => new ChatRoomMessage()),
   new TranRegistration.subtype(UserEnteredChatRoom, () => new UserEnteredChatRoom()),
   new TranRegistration.subtype(UserLeftChatRoom, () => new UserLeftChatRoom())
]);