import 'package:education_app/core/enums/update_user.dart';
import 'package:education_app/src/authentication/data/dataSources/authentication_remote_data_source.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';

void main() {
  late FakeFirebaseFirestore cloudStoreClient;
  late MockFirebaseAuth authClient;
  late MockFirebaseStorage dbClient;
  late AuthenticationRemoteDataSource dataSource;
  setUp(() async {
    cloudStoreClient = FakeFirebaseFirestore();
    final googleSignIn = MockGoogleSignIn();
    final signinAccount = await googleSignIn.signIn();
    final googleAuth = await signinAccount!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Sign in.
    final mockUser = MockUser(
      uid: 'someUid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    authClient = MockFirebaseAuth(mockUser: mockUser);
    final result = await authClient.signInWithCredential(credential);
    final user = result.user;
    dbClient = MockFirebaseStorage();
    dataSource = AuthenticationRemoteDataSourceImpl(
      authClient: authClient,
      cloudStoreClient: cloudStoreClient,
      dbClient: dbClient,
    );
  });

  const tPassword = 'Test Password';
  const tFullName = 'Test Full Name';
  const tEmail = 'testemail@mail.org';

  test('signUp', () async {
    // act
    await dataSource.signUp(
      email: tEmail,
      fullName: tFullName,
      password: tPassword,
    );

    // expect that the user was created in the firestore and the
    // authClient also this user
    expect(
      authClient.currentUser,
      isNotNull,
    );
    expect(
      authClient.currentUser!.displayName,
      tFullName,
    );

    final user = await cloudStoreClient
        .collection('users')
        .doc(
          authClient.currentUser!.uid,
        )
        .get();

    expect(user.exists, isTrue);
  });
  test('signIn', () async {
    await dataSource.signUp(
      email: 'newEmail@mail.com',
      fullName: tFullName,
      password: tPassword,
    );
    await authClient.signOut();

    await dataSource.signIn(
      email: 'newEmail@mail.com',
      password: tPassword,
    );
    expect(
      authClient.currentUser,
      isNotNull,
    );
    expect(
      authClient.currentUser!.email,
      'newEmail@mail.com',
    );
  });
  group('updateUser', () {
    test('displayName', () async {
      // act
      await dataSource.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      );
      await dataSource.updateUser(
        action: UpdateUserAction.displayName,
        userData: 'new name',
      );
      expect(authClient.currentUser!.displayName, 'new name');
    });
    test('email', () async {
      await dataSource.updateUser(
        action: UpdateUserAction.email,
        userData: 'newemail@mail.conm',
      );
      expect(authClient.currentUser!.email, 'newemail@mail.conm');
    });
  });
}
