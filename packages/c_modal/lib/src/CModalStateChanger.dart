part of cmodal;

/// Changes the state of the modal and all provide properties
/// associated to that modal.
class CModalStateChanger{

  /// Custom modal display
  ///
  /// When set, this modal would always be displayed,
  /// irrespective of the [state] assigned.
  Widget? displayedModal;

  /// When set to true, modal is dismissed when modal background is
  /// tapped.
  bool? dismissOnOutsideClick;

  /// Sets state to the modal.
  ///
  /// Modals are displayed based on their state.
  ///
  /// Modals are assigned to state from [CModal.builder] or by default.
  CModalState state;

  /// Assigns myPlan to be displayed for the modals when default modal is
  /// provided.
  String? displayMessage;

  /// Called when modal background is tapped.
  void Function()? onOutsideClick;

  /// Called when back button is tapped when modal is visible.
  void Function()? onBackPress;

  /// Called when the modal is dismissed.
  void Function()? onCloseModal;

  /// When set to true, Navigates back when modal is visible and
  /// back is pressed.
  bool? popOnBackPress;

  /// When set to true, dismisses the modal when back is pressed.
  bool? dismissOnBackPress;

  /// Determines the duration modal background fades in.
  Duration? fadeDuration;

  /// Constructs the state to be assigned to the modal with all
  /// properties associated with the modal.
  CModalStateChanger({required this.state, this.onBackPress,
    this.popOnBackPress, this.dismissOnBackPress: true,
    this.displayMessage, this.onOutsideClick, this.dismissOnOutsideClick, this.fadeDuration,
    this.displayedModal, this.onCloseModal,
  }):assert((displayedModal != null && displayMessage == null) || displayMessage == null);

}