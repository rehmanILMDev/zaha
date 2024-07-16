
import 'package:zaha/features/on_broad_feat/domain/entities/onbroading_entity.dart';

class OnboardingModel extends Onboarding {
  OnboardingModel({
    required String title,
    required String description,
    required String imageUrl,
  }) : super(title: title, description: description, imageUrl: imageUrl);

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}
