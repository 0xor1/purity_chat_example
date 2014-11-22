library app_bootstrap;

import 'package:polymer/polymer.dart';

import 'package:core_elements/core_meta.dart' as i0;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_iconset.dart' as i1;
import 'package:polymer/src/build/log_injector.dart';
import 'package:core_elements/core_icon.dart' as i2;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_focusable.dart' as i3;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_ripple.dart' as i4;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_shadow.dart' as i5;
import 'package:polymer/src/build/log_injector.dart';
import 'package:paper_elements/paper_button.dart' as i6;
import 'package:polymer/src/build/log_injector.dart';
import 'package:purity_oauth2/view/google_login.dart' as i7;
import 'package:polymer/src/build/log_injector.dart';
import 'package:purity_chat_example/view/chat_room.dart' as i8;
import 'package:polymer/src/build/log_injector.dart';
import 'package:purity_chat_example/view/chat_app.dart' as i9;
import 'package:polymer/src/build/log_injector.dart';
import 'index_without_purity.dart' as i10;
import 'package:polymer/src/build/log_injector.dart';
import 'package:smoke/smoke.dart' show Declaration, PROPERTY, METHOD;
import 'package:smoke/static.dart' show useGeneratedCode, StaticConfiguration;
import 'package:purity_oauth2/view/google_login.dart' as smoke_0;
import 'package:polymer/polymer.dart' as smoke_1;
import 'package:purity_chat_example/view/chat_room.dart' as smoke_2;
import 'package:purity_chat_example/view/chat_app.dart' as smoke_3;
abstract class _M0 {} // PolymerElement & Receiver

void main() {
  useGeneratedCode(new StaticConfiguration(
      checkedMode: false,
      getters: {
        #blurAction: (o) => o.blurAction,
        #contextMenuAction: (o) => o.contextMenuAction,
        #downAction: (o) => o.downAction,
        #focusAction: (o) => o.focusAction,
        #icon: (o) => o.icon,
        #iconSrc: (o) => o.iconSrc,
        #label: (o) => o.label,
        #raisedButton: (o) => o.raisedButton,
        #upAction: (o) => o.upAction,
        #z: (o) => o.z,
      },
      setters: {
        #icon: (o, v) { o.icon = v; },
        #iconSrc: (o, v) { o.iconSrc = v; },
        #z: (o, v) { o.z = v; },
      },
      parents: {
        smoke_3.ChatApp: _M0,
        smoke_2.ChatRoom: _M0,
        smoke_0.GoogleLoginElement: _M0,
        _M0: smoke_1.PolymerElement,
      },
      declarations: {
        smoke_3.ChatApp: {},
        smoke_2.ChatRoom: {},
        smoke_0.GoogleLoginElement: {},
      },
      names: {
        #blurAction: r'blurAction',
        #contextMenuAction: r'contextMenuAction',
        #downAction: r'downAction',
        #focusAction: r'focusAction',
        #icon: r'icon',
        #iconSrc: r'iconSrc',
        #label: r'label',
        #raisedButton: r'raisedButton',
        #upAction: r'upAction',
        #z: r'z',
      }));
  new LogInjector().injectLogsFromUrl('index_without_purity.html._buildLogs');
  configureForDeployment([
      i0.upgradeCoreMeta,
      i1.upgradeCoreIconset,
      i2.upgradeCoreIcon,
      i3.upgradePaperFocusable,
      i4.upgradePaperRipple,
      i5.upgradePaperShadow,
      i6.upgradePaperButton,
      () => Polymer.register('google-login-element', i7.GoogleLoginElement),
      () => Polymer.register('chat-room', i8.ChatRoom),
      () => Polymer.register('chat-app', i9.ChatApp),
    ]);
  i10.main();
}
