import 'package:logger/logger.dart';
export 'package:logger/logger.dart';

Logger getLogger(String className){
  return Logger(
      printer: SimpleLogPrinter(className)
  );
}

class SimpleLogPrinter extends LogPrinter{

  final String className;
  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    // var emoji = PrettyPrinter.levelColors[event.];
    return [color!("$className - ${event.message}")];
  }

}