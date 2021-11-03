part of cmodal;

class CModalController{


  BuildContext? context;

  CModalController();

  ValueNotifier<CModalState> _notify = ValueNotifier(CModalState.none);


  CModalState get _state => _notify.value;

  set _state(CModalState value){
    _notify.value = value;
  }

  String? displayMessage;

  //click outside modal display;
  void Function()? onOutsideClick;

  bool? dismissOnOutsideClick;

  //when back is pressed.
  void Function()? onBackPress;
  //pops the whole page when back is pressed.
  bool? popOnBackPress;

  //dismiss only the model when back is pressed.
  bool? dismissOnBackPress = true;

  Duration? fadeDuration;


  set changeModalState(CModalStateChanger cModalStateChanger){

    this.popOnBackPress = cModalStateChanger.popOnBackPress;
    this.onBackPress = cModalStateChanger.onBackPress;
    this.dismissOnBackPress = cModalStateChanger.dismissOnBackPress;
    this.dismissOnOutsideClick = cModalStateChanger.dismissOnOutsideClick;
    this.displayMessage = cModalStateChanger.displayMessage;
    this.onOutsideClick = cModalStateChanger.onOutsideClick;
    this.fadeDuration = cModalStateChanger.fadeDuration;
    this._state = cModalStateChanger.state;

  }

}