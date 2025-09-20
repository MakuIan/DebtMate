class AddFriendResult {
  final bool success;
  final String? message;

  AddFriendResult.success([this.message]) : success = true;
  AddFriendResult.failure(this.message) : success = false;
}
