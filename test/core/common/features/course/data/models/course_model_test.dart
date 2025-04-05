import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/common/features/course/data/models/course_model.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../../fixtures/fixture_reader.dart';

void main() {
  final timestampData = {
    '_seconds': 1677483548,
    '_nanoseconds': 123456000,
  };
  final date = DateTime.fromMillisecondsSinceEpoch(timestampData['_seconds']!)
      .add(Duration(microseconds: timestampData['_nanoseconds']!));
  final timeStamp = Timestamp.fromDate(date);

  final tCourseModel = CourseModel(
    id: '_empty.id',
    title: '_empty.title',
    description: '_empty.description',
    numberOfExams: 0,
    numberOfMaterials: 0,
    numberOfVideos: 0,
    groupId: '_empty.groupId',
    createdAt: timeStamp.toDate(),
    updatedAt: timeStamp.toDate(),
  );

  final tMap = jsonDecode(fixture('course.json')) as DataMap;
  tMap['createdAt'] = timeStamp;
  tMap['updatedAt'] = timeStamp;

  test('should be a subclass of [Course] entity', () {
    expect(
      tCourseModel,
      isA<Course>(),
    );
  });
  group('empty', () {
    test('should return a [CourseModel] with empty data', () {
      final result = Course.empty();
      expect(result.title, '_empty.title');
    });
  });
  group('fromMap', () {
    test('should return a valid [CourseModel] from the map', () {
      // act
      final result = CourseModel.fromMap(tMap);

      // assert
      expect(result, isA<CourseModel>());
      expect(result, equals(tCourseModel));
    });
  });
  group('toMap', () {
    test('should return a valid [DataMap] from the model ', () {
      final result = tCourseModel.toMap()
        ..remove('createdAt')
        ..remove('updatedAt');
      final map = DataMap.from(tMap)
        ..remove('createdAt')
        ..remove('updatedAt');
      expect(result, equals(map));
    });
  });
  group('copyWith', () {
    test('should return a valid [CourseModel] with updated values', () {
      final result = tCourseModel.copyWith(title: 'New Title');
      expect(result.title, 'New Title');
    });
  });
}
