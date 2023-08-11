mixin AuthRepositoryMixin {
  Future<bool> signIn({required String username, required String password});
  Future<bool> signUp({
    required String username,
    required String password,
    required String nickname,
  });
  Future<bool> signOut();
}
