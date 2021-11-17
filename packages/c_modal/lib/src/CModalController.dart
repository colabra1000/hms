part of cmodal;

class CModalController{

  // The current context of the application when modal is visible.
  BuildContext? context;

  CModalController();

  // notifier for changing modal state
  ValueNotifier<CModalState> _notify = ValueNotifier(CModalState.none);


  CModalState get _state => _notify.value;

  // The user defined modal to display.
  Widget? _modalDisplay;

  set _state(CModalState value){
    _notify.value = value;
  }

  // message to display when default modal is displayed.
  String? _displayMessage;

  // called when modal background is clicked.
  void Function()? _onOutsideClick;

  // when set to true, modal is dismissed when modal background is clicked.
  bool? _dismissOnOutsideClick;

  // called when back is pressed when modal is visible.
  void Function()? _onBackPress;

  // called when modal is dismissed.
  void Function()? _onCloseModal;

  // when set to true, page is popped when back is pressed.
  bool? _popOnBackPress;

  // when set to true, modal is dismissed when back is pressed.
  bool? _dismissOnBackPress = true;

  // determines the duration as modal background is fadded in.
  Duration? _fadeDuration;



  /// Changes the state of the modal.
  ///
  /// Assigned [CModalStateChanger].
  ///
  /// See [CModalStateChanger] for options that can be provided when changing
  /// state of the modal.
  set changeModalState(CModalStateChanger cModalStateChanger){

    //if cmodalStateChange state is none then should not set onCloseModal function.
    assert((cModalStateChanger.state == CModalState.none && cModalStateChanger.onCloseModal == null)||
        (cModalStateChanger.state != CModalState.none));

    this._popOnBackPress = cModalStateChanger.popOnBackPress;
    this._onBackPress = cModalStateChanger.onBackPress;
    this._dismissOnBackPress = cModalStateChanger.dismissOnBackPress;
    this._dismissOnOutsideClick = cModalStateChanger.dismissOnOutsideClick;
    this._displayMessage = cModalStateChanger.displayMessage;
    this._onOutsideClick = cModalStateChanger.onOutsideClick;
    this._fadeDuration = cModalStateChanger.fadeDuration;
    this._state = cModalStateChanger.state;
    this._modalDisplay = cModalStateChanger.displayedModal;
    this._onCloseModal = cModalStateChanger.onCloseModal ?? this._onCloseModal;


    if(cModalStateChanger.state == CModalState.none){
      this._onCloseModal?.call();
      this._onCloseModal = null;
    }



  }

  /// Dismisses the current modal that is displayed.
  dismissModal(){
    changeModalState = CModalStateChanger(state: CModalState.none);
  }

}