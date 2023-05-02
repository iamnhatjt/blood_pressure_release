import 'build_constants.dart';
import 'main.dart';

void main() {
  BuildConstants.setEnvironment(Environment.prod);
  mainDelegate();
}
