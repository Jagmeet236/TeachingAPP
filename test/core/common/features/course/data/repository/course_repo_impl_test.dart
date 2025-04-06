import 'package:dartz/dartz.dart';
import 'package:education_app/core/common/features/course/data/datasources/course_remote_data_src.dart';
import 'package:education_app/core/common/features/course/data/models/course_model.dart';
import 'package:education_app/core/common/features/course/data/repository/course_repo_impl.dart';
import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/common/features/course/domain/repository/course_repo.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCourseRemoteDataSrc extends Mock implements CourseRemoteDataSrc {}

void main() {
  late CourseRemoteDataSrc remoteDataSource;
  late CourseRepoImpl repoImpl;
  final tCourse = CourseModel.empty();
  setUp(() {
    remoteDataSource = MockCourseRemoteDataSrc();
    repoImpl = CourseRepoImpl(remoteDataSource);
    registerFallbackValue(tCourse);
  });
  const tServerException = ServerException(
    message: 'Something went wrong ',
    statusCode: '500',
  );
  test('should be a subclass of [CourseRepo]', () {
    expect(repoImpl, isA<CourseRepo>());
  });

  group('addCourse', () {
    test(
      'should complete successfully when call to remote source is '
      'successful',
      () async {
        when(() => remoteDataSource.addCourse(tCourse)).thenAnswer(
          (_) async => Future.value(),
        );

        final result = await repoImpl.addCourse(tCourse);

        expect(result, equals(const Right<dynamic, void>(null)));
        verify(() => remoteDataSource.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
    test(
      'should return [Failure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.addCourse(any())).thenThrow(
          tServerException,
        );
        final result = await repoImpl.addCourse(tCourse);
        expect(
          result,
          Left<Failure, void>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.addCourse(tCourse)).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
  group('getCourse', () {
    test(
        'should return [List<Course>] when call to remote source '
        'is successful', () async {
      when(() => remoteDataSource.getCourse())
          .thenAnswer((_) async => [tCourse]);

      final result = await repoImpl.getCourses();
      expect(
        result,
        isA<Right<dynamic, List<Course>>>(),
      );
      verify(() => remoteDataSource.getCourse()).called(1);
      verifyNoMoreInteractions(remoteDataSource);
    });
    test(
      'should return [Failure] when call to remote source is '
      'unsuccessful',
      () async {
        when(() => remoteDataSource.getCourse()).thenThrow(
          tServerException,
        );
        final result = await repoImpl.getCourses();
        expect(
          result,
          Left<Failure, void>(
            ServerFailure.fromException(tServerException),
          ),
        );
        verify(() => remoteDataSource.getCourse()).called(1);
        verifyNoMoreInteractions(remoteDataSource);
      },
    );
  });
}
