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

    final updatedImageList = _updateImageList(rearImage: value);

    state = state.copyWith(imageRearID: imageRearID
      , imageList: updatedImageList,
      isValidImageID: Formz.validate([imageRearID, state.imageFrontID])
    );
  }

  onImageFrontIDChanged(String value) {
    final imageFrontID = ImageId.dirty(value);

    final updatedImageList = _updateImageList(frontImage: value);


    state = state.copyWith(imageFrontID: imageFrontID,
      imageList: updatedImageList,
      isValidImageID: Formz.validate([state.imageRearID, imageFrontID])
    );

  }

  onImageOfFaceChanged(String value) {
    final imageOfFace = ImageId.dirty(value);

    final updatedImageList = _updateImageList(faceImage: value);

    state = state.copyWith(imageOfFace: imageOfFace, imageList: updatedImageList, isValidImageID: Formz.validate([state.imageRearID, imageOfFace]));
  }

  onIsValidImageIDChanged(bool value) {
    state = state.copyWith(isValidImageID: value);
  }

  // List<String> _updateImageList({String? frontImage, String? rearImage, String? faceImage}) {
  //   // Crear una copia de la lista actual.
  //   final List<String> updatedList = List<String>.from(state.imageList);
  //
  //   //front [0] rear [1] face [2]
  //   final hasFrontImage = updatedList.isNotEmpty;
  //   final hasRearImage = updatedList.length > 1;
  //   final hasFaceImage = updatedList.length > 2;
  //
  //
  //   if (frontImage == null && rearImage == null && frontImage == null) return updatedList;
  //
  //   if (frontImage != null){
  //     if (hasFrontImage) {
  //       updatedList[0] = frontImage;
  //     } else {
  //       updatedList.add(frontImage);
  //     }
  //   }else if (rearImage != null){
  //     if (hasRearImage) {
  //       updatedList[1] = rearImage;
  //     } else {
  //       updatedList.add(rearImage);
  //     }
  //   }else if (faceImage != null){
  //     if (hasFaceImage) {
  //       updatedList[2] = faceImage;
  //     } else {
  //       updatedList.add(faceImage);
  //     }
  //   }
  //   return updatedList;
  // }


  List<String> _updateImageList({
    String? frontImage,
    String? rearImage,
    String? faceImage,
  }) {
    final List<String> updatedList = List<String>.from(state.imageList);


    final hasFrontImage = updatedList.isNotEmpty;
    final hasRearImage = updatedList.length > 1;
    final hasFaceImage = updatedList.length > 2;

    if (frontImage == null && rearImage == null && faceImage == null) return updatedList;

    if (frontImage != null) {
      if (!hasFrontImage) updatedList.add(frontImage);
    }else if (rearImage != null) {
      if (!hasRearImage) updatedList.add(rearImage);
    }else if (faceImage != null) {
      if (!hasFaceImage) updatedList.add(faceImage);
    }

    if (frontImage != null) updatedList[0] = frontImage;
    if (rearImage != null) updatedList[1] = rearImage;
    if (faceImage != null) updatedList[2] = faceImage;

    return updatedList;
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
  final ImageId imageOfFace;
  final bool isValidImageID;
  final List<String> imageList;

  const CreateAccountDeliveryImageState( {
    this.isValidImageID = false,
    this.imageRearID = const ImageId.pure(),
    this.imageFrontID = const ImageId.pure(),
    this.imageOfFace = const ImageId.pure(),
    this.imageList = const [],
  });

  CreateAccountDeliveryImageState copyWith({
    ImageId? imageRearID,
    ImageId? imageFrontID,
    ImageId? imageOfFace,
    bool? isValidImageID,
    List<String>? imageList,
  }) {
    return CreateAccountDeliveryImageState(
      imageOfFace: imageOfFace ?? this.imageOfFace,
      imageRearID: imageRearID ?? this.imageRearID,
      imageFrontID: imageFrontID ?? this.imageFrontID,
      isValidImageID: isValidImageID ?? this.isValidImageID,
      imageList: imageList ?? this.imageList,
    );
  }

  @override
  String toString() {
    return '''CreateAccountDeliveryImageState(
      imageRearID: $imageRearID,
      imageFrontID: $imageFrontID,
      isValidImageID: $isValidImageID,
      imageList: $imageList,
      imageOfFace: $imageOfFace,
    )''';
  }
}
