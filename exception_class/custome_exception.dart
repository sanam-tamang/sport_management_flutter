//making custome exception class
//all the failure will be in failure class
class Failure {
  final String failure;
  const Failure(this.failure);
  @override
  String toString() {
    return failure;
  }
}

//when no internet connection out there
class CustomeSocketException {
  @override
  String toString() {
    return "No internet connection";
  }
}

//when page not found
class CustomeHttpException {
  @override
  String toString() {
    return "404 Error ! Page not found";
  }
}

//when error decoding json data
class CustomeFormatException {
  @override
  String toString() {
    return "Internal Error";
  }
}
