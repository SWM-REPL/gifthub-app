// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 🌎 Project imports:
import 'package:gifthub/presentation/providers/appuser.provider.dart';
import 'package:gifthub/presentation/providers/command.provider.dart';
import 'package:gifthub/utility/navigator.dart';
import 'package:gifthub/utility/show_snack_bar.dart';

class UserNicknameEditorView extends ConsumerStatefulWidget {
  final formKey = GlobalKey<FormState>();
  final nicknameController = TextEditingController();

  UserNicknameEditorView({super.key});

  @override
  ConsumerState<UserNicknameEditorView> createState() =>
      _UserNicknameEditorViewState();
}

class _UserNicknameEditorViewState
    extends ConsumerState<UserNicknameEditorView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('닉네임 변경'),
    );
  }

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    const double padding = 15;

    final appUser = ref.watch(appUserProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(padding),
          child: Form(
            key: widget.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '새로운 닉네임을 입력해주세요',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: padding),
                TextFormField(
                  controller: widget.nicknameController,
                  validator: _validateNickname,
                  decoration: InputDecoration(
                    hintText: appUser.when(
                      data: (data) => data.nickname,
                      loading: () => '',
                      error: (error, stackTrace) => '',
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: MediaQuery.of(context)
                .padding
                .copyWith(top: 0)
                .add(const EdgeInsets.all(padding)),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : _handleChangeClicked,
                child: const Padding(
                  padding: EdgeInsets.all(padding),
                  child: Text('변경 완료'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String? _validateNickname(String? value) {
    if (value == null || value.isEmpty) {
      return '닉네임을 입력해주세요';
    } else if (value.length < 2) {
      return '닉네임은 2자 이상 입력해주세요';
    } else if (value.length > 12) {
      return '닉네임은 12자 이하로 입력해주세요';
    }
    return null;
  }

  void _handleChangeClicked() async {
    try {
      setState(() => isLoading = true);
      if (widget.formKey.currentState!.validate()) {
        final appUser = await ref.watch(appUserProvider.future);
        await ref.watch(updateUserCommandProvider)(
          appUser.id,
          nickname: widget.nicknameController.text,
        );
        ref.invalidate(appUserProvider);
        navigateBack();
      }
    } catch (error) {
      if (error is DioException) {
        showSnackBar(Text(error.message ?? '알 수 없는 오류가 발생했습니다.'));
      } else {
        rethrow;
      }
    } finally {
      setState(() => isLoading = false);
    }
  }
}
