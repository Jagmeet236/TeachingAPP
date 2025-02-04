import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedef.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    required super.updatedAt,
    super.description,
    super.image,
    super.imageIsFile = false,
  });

  CourseModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          description: '_empty.description',
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          groupId: '_empty.groupId',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  factory CourseModel.fromMap(DataMap map) {
    return CourseModel(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      numberOfExams: (map['numberOfExams'] as num).toInt(),
      numberOfMaterials: (map['numberOfMaterials'] as num).toInt(),
      numberOfVideos: (map['numberOfVideos'] as num).toInt(),
      groupId: map['groupId'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      image: map['image'] as String,
      imageIsFile: map['imageIsFile'] as bool,
    );
  }

  CourseModel copyWith({
    String? id,
    String? title,
    String? description,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? image,
    bool? imageIsFile,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      image: image ?? this.image,
      imageIsFile: imageIsFile ?? this.imageIsFile,
    );
  }

  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'numberOfExams': numberOfExams,
      'numberOfMaterials': numberOfMaterials,
      'numberOfVideos': numberOfVideos,
      'groupId': groupId,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'image': image,
      'imageIsFile': imageIsFile,
    };
  }
}
