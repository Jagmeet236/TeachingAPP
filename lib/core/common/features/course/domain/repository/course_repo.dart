import 'package:education_app/core/common/features/course/domain/entities/course.dart';
import 'package:education_app/core/utils/typedef.dart';

abstract class CourseRepo {
  const CourseRepo();
  ResultFuture<List<Course>> getCourses();
  ResultFuture<void> addCourse(Course course);
}
