import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:sarti_mobile/models/inputs/image_id.dart';

///state provider
final createAccountDeliveryImagesProvider = StateNotifierProvider.autoDispose<
    CreateAccountDeliveryImageNotifier, CreateAccountDeliveryImageState>((ref) {
  return CreateAccountDeliveryImageNotifier();
});

// implementation of notifier
class CreateAccountDeliveryImageNotifier
    extends StateNotifier<CreateAccountDeliveryImageState> {
  CreateAccountDeliveryImageNotifier()
      : super(const CreateAccountDeliveryImageState());

  onImageRearIDChanged(String value) {
    final imageRearID = ImageId.dirty(value);

    final updatedImageList = _updateImageList(rearImage: value);

    state = state.copyWith(
        imageRearID: imageRearID,
        imageList: updatedImageList,
        isValid: _validateForm(state));
  }

  onImageFrontIDChanged(String value) {
    final imageFrontID = ImageId.dirty(value);

    final updatedImageList = _updateImageList(frontImage: value);

    state = state.copyWith(
        imageFrontID: imageFrontID,
        imageList: updatedImageList,
        isValid: _validateForm(state));
  }

  onImageOfFaceChanged(String value) {
    final imageOfFace = ImageId.dirty(value);

    final updatedImageList = _updateImageList(faceImage: value);

    state = state.copyWith(
        imageOfFace: imageOfFace,
        imageList: updatedImageList,
        isValid: _validateForm(state));
  }

  onIsValidImageIDChanged(bool value) {
    state = state.copyWith(isValid: value);
  }

  onIsFormPostedChanged(bool value) {
    state = state.copyWith(isFormPosted: value);
  }

  onSubmitted() {
    _touchEveryField();
    if (!_validateForm(state)) return;

    print('Submitted $state');
  }

  _touchEveryField() {
    final imageRearID = ImageId.dirty(state.imageRearID.value);
    final imageFrontID = ImageId.dirty(state.imageFrontID.value);
    final imageOfFace = ImageId.dirty(state.imageOfFace.value);
    final isValid = _validateForm(state);

    state = state.copyWith(
      imageRearID: imageRearID,
      imageFrontID: imageFrontID,
      imageOfFace: imageOfFace,
      isFormPosted: true,
      isValid: isValid,
    );
  }

  bool _validateForm(CreateAccountDeliveryImageState state) {
    return Formz.validate([
      state.imageFrontID,
      state.imageRearID,
      state.imageOfFace,
    ]);
  }

  List<String> _updateImageList({
    String? frontImage,
    String? rearImage,
    String? faceImage,
  }) {
    final List<String> updatedList = List<String>.from(state.imageList);

    final hasFrontImage = updatedList.isNotEmpty;
    final hasRearImage = updatedList.length > 1;
    final hasFaceImage = updatedList.length > 2;

    if (frontImage == null && rearImage == null && faceImage == null)
      return updatedList;

    if (frontImage != null) {
      if (!hasFrontImage) updatedList.add(frontImage);
    } else if (rearImage != null) {
      if (!hasRearImage) updatedList.add(rearImage);
    } else if (faceImage != null) {
      if (!hasFaceImage) updatedList.add(faceImage);
    }

    if (frontImage != null) updatedList[0] = frontImage;
    if (rearImage != null) updatedList[1] = rearImage;
    if (faceImage != null) updatedList[2] = faceImage;

    return updatedList;
  }
}

// state of provider
class CreateAccountDeliveryImageState {
  final ImageId imageRearID;
  final ImageId imageFrontID;
  final ImageId imageOfFace;
  final bool isValid;
  final List<String> imageList;
  final bool isFormPosted;

  const CreateAccountDeliveryImageState({
    this.isValid = false,
    this.imageRearID = const ImageId.pure(),
    this.imageFrontID = const ImageId.pure(),
    this.imageOfFace = const ImageId.pure(),
    this.imageList = const [],
    this.isFormPosted = false,
  });

  CreateAccountDeliveryImageState copyWith({
    ImageId? imageRearID,
    ImageId? imageFrontID,
    ImageId? imageOfFace,
    bool? isValid,
    List<String>? imageList,
    bool? isFormPosted,
  }) {
    return CreateAccountDeliveryImageState(
      imageOfFace: imageOfFace ?? this.imageOfFace,
      imageRearID: imageRearID ?? this.imageRearID,
      imageFrontID: imageFrontID ?? this.imageFrontID,
      isValid: isValid ?? this.isValid,
      imageList: imageList ?? this.imageList,
      isFormPosted: isFormPosted ?? this.isFormPosted,
    );
  }

  @override
  String toString() {
    return '''CreateAccountDeliveryImageState(
      imageRearID: $imageRearID,
      imageFrontID: $imageFrontID,
      isValidImageID: $isValid,
      imageList: $imageList,
      imageOfFace: $imageOfFace,
      isFormPosted: $isFormPosted,
    )''';
  }
}
