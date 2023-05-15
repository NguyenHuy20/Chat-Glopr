import 'package:chat_glopr/@core/network/repository/auth_repo.dart';
import 'package:chat_glopr/@core/network/repository/conversation_repo.dart';
import 'package:chat_glopr/@core/network/repository/friend_repo.dart';
import 'package:chat_glopr/@core/network/repository/message_repo.dart';
import 'package:chat_glopr/@core/network/repository/notification_repo.dart';
import 'package:chat_glopr/@core/network/repository/user_repo.dart';
import 'package:get_it/get_it.dart';

import 'network/api_client.dart';

GetIt inject = GetIt.instance;

void initDependence() {
  inject.registerLazySingleton(() => ApiClient());
  inject.registerFactory<AuthRepo>(() => AuthRepo());
  inject.registerFactory<UserRepo>(() => UserRepo());
  inject.registerFactory<ConversationRepo>(() => ConversationRepo());
  inject.registerFactory<FriendRepo>(() => FriendRepo());
  inject.registerFactory<MessageRepo>(() => MessageRepo());
  inject.registerFactory<NotificationRepo>(() => NotificationRepo());
}
