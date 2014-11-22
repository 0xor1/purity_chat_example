/**
 * author: Daniel Robinson  http://github.com/0xor1
 */

library chat.interface;

@MirrorsUsed(
  targets: const[
    IChatApp,
    IChatRoomAccessPoint
  ], override: '*')
import 'dart:mirrors';
import 'package:purity/purity.dart';

abstract class IChatApp implements Source{
  void requestLoginObject();
}

abstract class IChatRoomAccessPoint implements Source{
  void say(String message);
}

class LoginObjectRequest extends Transmittable{
  Source get login => get('login');
  void set login (Source o) => set('login', o);
}

class ChatRoomAccessed extends Transmittable{
  Source get chatRoomAccessPoint => get('chatRoomAccessPoint');
  void set chatRoomAccessPoint (Source o) => set('chatRoomAccessPoint', o);
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
   new TranRegistration.subtype(LoginObjectRequest, () => new LoginObjectRequest()),
   new TranRegistration.subtype(ChatRoomAccessed, () => new ChatRoomAccessed()),
   new TranRegistration.subtype(ChatRoomMessage, () => new ChatRoomMessage()),
   new TranRegistration.subtype(UserEnteredChatRoom, () => new UserEnteredChatRoom()),
   new TranRegistration.subtype(UserLeftChatRoom, () => new UserLeftChatRoom())
]);