part of cmodal;

class CModalStateChanger{

  Widget? modalDisplay;

  bool? dismissOnOutsideClick;

  CModalState state;

  String? displayMessage;

  void Function()? onOutsideClick;

  void Function()? onBackPress;

  bool? popOnBackPress;

  bool? dismissOnBackPress;

  Duration? fadeDuration;

  CModalStateChanger({required this.state, this.onBackPress,
    this.popOnBackPress, this.dismissOnBackPress: true,
    this.displayMessage, this.onOutsideClick, this.dismissOnOutsideClick, this.fadeDuration,
    this.modalDisplay
  }):assert((modalDisplay != null && displayMessage == null) || displayMessage == null);

}