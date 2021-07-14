class APIResponse<T>{
  T data;
  bool error;
  APIResponse({required this.data, this.error = false});
}
