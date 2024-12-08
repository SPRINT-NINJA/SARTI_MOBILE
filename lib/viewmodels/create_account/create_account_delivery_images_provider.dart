import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/models/inputs/image_id.dart';


enum FormStatus { invalid, valid, validating, submitting, submitted, posting }

///state provider
final createAccountDeliveryImagesProvider = StateNotifierProvider.autoDispose<
    CreateAccountDeliveryImageNotifier, CreateAccountDeliveryImageState>((ref) {
  return CreateAccountDeliveryImageNotifier();
});

// implementation of notifier
class CreateAccountDeliveryImageNotifier
    extends StateNotifier<CreateAccountDeliveryImageState> {
  CreateAccountDeliveryImageNotifier() : super(const CreateAccountDeliveryImageState());

  onImageRearIDChanged(String value) {
    final imageRearID = ImageId.dirty(value);
    state = state.copyWith(imageRearID: imageRearID);
  }

  onImageFrontIDChanged(String value) {
    final imageFrontID = ImageId.dirty(value);
    state = state.copyWith(imageFrontID: imageFrontID);
  }

  onIsValidImageIDChanged(bool value) {
    state = state.copyWith(isValidImageID: value);
  }


  onValidateID() {
    final imageRearID = ImageId.dirty(state.imageRearID.value);
    final imageFrontID = ImageId.dirty(state.imageFrontID.value);
    final isValidImageID = Formz.validate([imageRearID, imageFrontID]);

    state = state.copyWith(
      imageRearID: imageRearID,
      imageFrontID: imageFrontID,
      isValidImageID: isValidImageID,
    );

    print('ID $state');
  }

  onSubmitted() {
    _touchEveryField();
    if (!_validateForm(state)) return;

    print('Submitted $state');
  }

  _touchEveryField() {
    final imageRearID = ImageId.dirty(state.imageRearID.value);
    final imageFrontID = ImageId.dirty(state.imageFrontID.value);

    state = state.copyWith(
      imageRearID: imageRearID,
      imageFrontID: imageFrontID,
    );
  }

  bool _validateForm(CreateAccountDeliveryImageState state) {
    return Formz.validate([
          state.imageFrontID,
          state.imageRearID,
        ]);
  }
}

// state of provider
class CreateAccountDeliveryImageState {
  final ImageId imageRearID;
  final ImageId imageFrontID;
  final bool isValidImageID;

  const CreateAccountDeliveryImageState( {
    this.isValidImageID = false,
    this.imageRearID = const ImageId.pure(),
    this.imageFrontID = const ImageId.pure(),
  });

  CreateAccountDeliveryImageState copyWith({
    ImageId? imageRearID,
    ImageId? imageFrontID,
    bool? isValidImageID,
  }) {
    return CreateAccountDeliveryImageState(
      imageRearID: imageRearID ?? this.imageRearID,
      imageFrontID: imageFrontID ?? this.imageFrontID,
      isValidImageID: isValidImageID ?? this.isValidImageID,
    );
  }

  @override
  String toString() {
    return '''CreateAccountDeliveryImageState(
      imageRearID: $imageRearID,
      imageFrontID: $imageFrontID,
      isValidImageID: $isValidImageID,
    )''';
  }
}
