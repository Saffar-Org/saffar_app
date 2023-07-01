/// Helpers used inside a model.
class ModelHelper {
  /// Throws [Exception('Model <model name>: <model name> has no <key>')]
  /// if required field's key is not present in map.
  static throwExceptionIfRequiredFieldsNotPresentInMap(
    String modelName,
    Map<dynamic, dynamic> map,
    List<String> keys,
  ) {
    for (final key in keys) {
      if (map[key] == null || map[key] == '') {
        throw Exception('Model $modelName: $modelName has no $key');
      }
    }
  }
}
