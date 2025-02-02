import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/core/utils/typedef.dart';
import 'package:education_app/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:education_app/src/authentication/data/models/user_model.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {
  String _uid = 'Test uid';

  @override
  String get uid => _uid;
  set uid(String value) {
    if (_uid != value) _uid = value;
  }
}

class MockUserCredential extends Mock implements UserCredential {
  MockUserCredential([User? user]) : _user = user;
  User? _user;
  @override
  User? get user => _user;
  set user(User? value) {
    if (_user != value) _user = value;
  }
}

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late FirebaseAuth authClient;
  late FirebaseFirestore cloudStoreClient;
  late MockFirebaseStorage dbClient;
  late AuthenticationRemoteDataSource dataSource;
  late UserCredential userCredential;
  late MockUser mockUser;
  late DocumentReference<DataMap> documentReference;
  const tUser = LocalUserModel.empty();
  setUpAll(() async {
    authClient = MockFirebaseAuth();
    cloudStoreClient = FakeFirebaseFirestore();
    documentReference = cloudStoreClient.collection('users').doc();
    await documentReference
        .set(tUser.copyWith(uid: documentReference.id).toMap());

    dbClient = MockFirebaseStorage();
    mockUser = MockUser()..uid = documentReference.id;
    userCredential = MockUserCredential(mockUser);
    dataSource = AuthenticationRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
    when(() => authClient.currentUser).thenReturn(mockUser);
  });
  const tPassword = 'Test Password';
  const tFullName = 'Test full name';
  const tEmail = 'Test email';
  final tFirebaseAuthException = FirebaseAuthException(
    code: 'user-not-found',
    message: 'There is no user record corresponding to this identifier. '
        'The user may have been deleted',
  );
  group('forgotPassword', () {
    test(
      'should complete successfully when no [Exception] is thrown',
      () async {
        when(
          () => authClient.sendPasswordResetEmail(
            email: any(named: 'email'),
          ),
        ).thenAnswer((_) async => Future.value());

        final call = dataSource.forgotPassword(tEmail);
        expect(call, completes);

        verify(() => authClient.sendPasswordResetEmail(email: tEmail))
            .called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
    test(
        'should throw [ServerException] when [FirebaseAUthException] '
        'is thrown', () async {
      when(
        () => authClient.sendPasswordResetEmail(
          email: any(
            named: 'email',
          ),
        ),
      ).thenThrow(
        tFirebaseAuthException,
      );
      final call = dataSource.forgotPassword;
      expect(() => call(tEmail), throwsA(isA<ServerException>()));
      verify(() => authClient.sendPasswordResetEmail(email: tEmail)).called(1);
      verifyNoMoreInteractions(authClient);
    });
  });
  group('signIn', () {
    test('should return [LocalUserModel] when no [Exception] is thrown',
        () async {
      when(
        () => authClient.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);
      final result = await dataSource.signIn(
        email: tEmail,
        password: tPassword,
      );
      expect(result.uid, userCredential.user!.uid);
      expect(result.email, '');
      verify(
        () => authClient.signInWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      verifyNoMoreInteractions(authClient);
    });
    test(
      'should throw [ServerException] when user is '
      'null after signin in',
      () async {
        final emptyUserCredential = MockUserCredential();
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => emptyUserCredential);
        final call = dataSource.signIn;
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(
            isA<ServerException>(),
          ),
        );
        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
    test(
      'should throw [ServerException] when [FirebaseAuthException] '
      'thrown',
      () async {
        when(
          () => authClient.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);
        final call = dataSource.signIn;
        expect(
          () => call(email: tEmail, password: tPassword),
          throwsA(isA<ServerException>()),
        );
        verify(
          () => authClient.signInWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
        verifyNoMoreInteractions(authClient);
      },
    );
  });

  group('signUp', () {
    test('should complete successfully when no [Exception] is thrown',
        () async {
      when(
        () => authClient.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => userCredential);

      when(() => userCredential.user?.updateDisplayName(any())).thenAnswer(
        (_) async => Future.value(),
      );
      when(() => userCredential.user?.updatePhotoURL(any())).thenAnswer(
        (_) async => Future.value(),
      );

      final call = dataSource.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );
      expect(
        call,
        completes,
      );
      verify(
        () => authClient.createUserWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
        ),
      ).called(1);
      await untilCalled(
        () => userCredential.user?.updateDisplayName(any()),
      );
      await untilCalled(
        () => userCredential.user?.updatePhotoURL(any()),
      );
      verify(() => userCredential.user?.updateDisplayName(tFullName)).called(1);
      verify(() => userCredential.user?.updatePhotoURL(kDefaultAvatar))
          .called(1);
      verifyNoMoreInteractions(authClient);
    });
    test(
      'should throw [ServerException] when [FirebaseAuthException] '
      'thrown',
      () async {
        when(
          () => authClient.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tFirebaseAuthException);
        final call = dataSource.signUp;
        expect(
          call(
            email: tEmail,
            password: tPassword,
            fullName: tFullName,
          ),
          throwsA(isA<ServerException>()),
        );

        verify(
          () => authClient.createUserWithEmailAndPassword(
            email: tEmail,
            password: tPassword,
          ),
        ).called(1);
      },
    );
  });
  group('updateUser', () {
    setUp(() {
      registerFallbackValue(MockAuthCredential());
    });
    test(
      'should update user displayName successfully when no [Exception] '
      'is thrown',
      () async {
        when(() => mockUser.updateDisplayName(any()))
            .thenAnswer((_) async => Future.value);
        await dataSource.updateUser(
          action: UpdateUserAction.displayName,
          userData: tFullName,
        );
        verify(() => mockUser.updateDisplayName(tFullName)).called(1);
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));
        final userData =
            await cloudStoreClient.collection('users').doc(mockUser.uid).get();
        if (userData.data() != null) {
          expect(userData.data()!['fullName'], tFullName);
        }
      },
    );
    test(
      'should update user email successfully when no [Exception] '
      'is thrown',
      () async {
        when(() => mockUser.verifyBeforeUpdateEmail(any()))
            .thenAnswer((_) async => Future.value);
        await dataSource.updateUser(
          action: UpdateUserAction.email,
          userData: tEmail,
        );
        verify(() => mockUser.verifyBeforeUpdateEmail(tEmail)).called(1);
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePassword(any()));

        final userData =
            await cloudStoreClient.collection('users').doc(mockUser.uid).get();
        if (userData.data() != null) {
          expect(userData.data()!['email'], tEmail);
        }
      },
    );
    test(
      'should update user bio successfully when no [Exception] '
      'is thrown',
      () async {
        const newBio = 'new Bio';
        when(() => mockUser.updateDisplayName(any()))
            .thenAnswer((_) async => Future.value);
        await dataSource.updateUser(
          action: UpdateUserAction.bio,
          userData: newBio,
        );
        verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        final userData = await cloudStoreClient
            .collection('users')
            .doc(documentReference.id)
            .get();
        if (userData.data() != null) {
          expect(userData.data()!['bio'], newBio);
        }
        // verifyNoMoreInteractions(mockUser);
        verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.updatePhotoURL(any()));
        verifyNever(() => mockUser.updatePassword(any()));
      },
    );
    test(
        'should update user password successfully when no [Exception] '
        'is thrown', () async {
      when(() => mockUser.updatePassword(any())).thenAnswer(
        (_) async => Future.value(),
      );
      when(() => mockUser.reauthenticateWithCredential(any()))
          .thenAnswer((_) async => userCredential);

      when(() => mockUser.email).thenReturn(tEmail);

      await dataSource.updateUser(
        action: UpdateUserAction.password,
        userData: jsonEncode({
          'oldPassword': 'oldPassword',
          'newPassword': tPassword,
        }),
      );

      verify(() => mockUser.updatePassword(tPassword));
      verifyNever(() => mockUser.updateDisplayName(any()));
      verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
      verifyNever(() => mockUser.updatePhotoURL(any()));

      final userData = await cloudStoreClient
          .collection('users')
          .doc(documentReference.id)
          .get();

      expect(userData.data()!['password'], null);
    });
    test(
      'should update user profilePic successfully when no [Exception] '
      'is thrown',
      () async {
        final newProfilePic = File('assets/images/onBoarding_background.png');
        when(() => mockUser.updatePhotoURL(any())).thenAnswer(
          (_) async => Future.value(),
        );
        await dataSource.updateUser(
          action: UpdateUserAction.profilePic,
          userData: newProfilePic,
        );

        verify(() => mockUser.updatePhotoURL(any())).called(1);
        verifyNever(() => mockUser.updateDisplayName(any()));
        verifyNever(() => mockUser.verifyBeforeUpdateEmail(any()));
        verifyNever(() => mockUser.updatePassword(any()));
        expect(dbClient.storedFilesMap.isNotEmpty, isTrue);
      },
    );
  });
}
