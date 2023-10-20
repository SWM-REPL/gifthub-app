// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/domain/entities/appuser.entity.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/presentation/providers/source.provider.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

final appUserProvider = FutureProvider<AppUser>((ref) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final me = await userRepository.getMe();
  try {
    await Future.delayed(
      Duration.zero,
      () => ref.watch(subscribeNotificationCommandProvider)(),
    );
  } catch (error) {
    if (error is DioException) {
      // ignore: avoid_dynamic_calls
      showSnackBar(Text(error.response?.data['error']));
    } else {
      rethrow;
    }
  }
  return me;
});
