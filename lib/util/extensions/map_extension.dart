extension MapExtensions on Map {
  Map<String, dynamic> validateApiResponse() {
    bool status = this["success"] ?? false;
    return {
      "type": status ? "success" : "error",
      "message": this["message"] ?? "No message found from the server",
      "data": this["data"]
    };
  }
}
