import 'dart:io';

import 'package:chat_glopr/@core/network/environment_config.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketClientUtils {
  SocketClientUtils();

  static Future<io.Socket> configSocket() async {
    final socket = io.io(
        'https://chat-glopr-dev.up.railway.app/',
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    return socket;
  }

  Future<void> emitMsg(String event, [dynamic data]) async {
    final socket = await SocketClientUtils.configSocket();
    socket.emit(event, data);
  }

  Future<void> onConnect(void Function(dynamic) handlerOnConnect) async {
    try {
      final socket = await SocketClientUtils.configSocket();
      socket.onConnect(handlerOnConnect);
    } catch (_) {}
  }

  Future<void> onEvent(
      String event, dynamic Function(dynamic) handlerOnEvent) async {
    try {
      final socket = await SocketClientUtils.configSocket();
      socket.on(event, handlerOnEvent);
    } catch (_) {}
  }

  Future<void> onDisconnect(void Function(dynamic) handlerOnDisconnect) async {
    try {
      final socket = await SocketClientUtils.configSocket();
      socket.onDisconnect(handlerOnDisconnect);
    } catch (_) {}
  }

  Future<void> disconnect() async {
    try {
      final socket = await SocketClientUtils.configSocket();
      socket.disconnect();
    } catch (_) {}
  }
}
