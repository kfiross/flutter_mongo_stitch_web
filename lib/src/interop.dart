@JS()
library stitch.js;

import 'dart:async';
import 'dart:convert';
import 'dart:js_util';

import "package:js/js.dart";

@JS('Mongo')
class Mongo {
  external Mongo();

  external void connectMongo(String appId);

  external insertDocument(String databaseName, String collectionName, data);

  external insertDocuments(
      String databaseName, String collectionName, List listData);

  external deleteDocument(
      String? databaseName, String? collectionName, String? filter);

  external deleteDocuments(
      String? databaseName, String? collectionName, String? filter);

  external findDocument(
      String? databaseName, String? collectionName, String? filter);

  external findDocuments(
      String? databaseName, String? collectionName, String? filter);

  external countDocuments(
      String? databaseName, String? collectionName, String? filter);

  external updateDocument(
      String? databaseName, String? collectionName, String? filter, String? update);

  external updateDocuments(
      String? databaseName, String? collectionName, String? filter, String? update);

  external loginAnonymously();

  external signInWithUsernamePassword(String username, String password);

  external signInWithGoogle(String authCode);

  external signInWithFacebook(String token);

  external signInWithCustomJwt(String token);

  external signInWithCustomFunction(String token);

  external registerWithEmail(String username, String password);

  external linkCredentials(String credJson);

  external logout();

  external getUserId();

  external getAccessToken();

  external getRefreshToken();

  external getUser();

  external sendResetPasswordEmail(String email);

  external callFunction(String name, List? args); //, int timeout);

  ///STREAM SOLUTION
  external setupWatchCollection(
      String databaseName, String collectionName, filter);

  external setupAuthListener();
}

class MyMongoClient {
  var _mongo = Mongo();

  void connectMongo(String appId) => _mongo.connectMongo(appId);

  //////

  Future<String> insertDocument(
      String databaseName, String collectionName, Map data) async {
    var result = await promiseToFuture(
        _mongo.insertDocument(databaseName, collectionName, json.encode(data)));
    return result;
  }

  Future<Map?> insertDocuments(
      String databaseName, String collectionName, List listData) async {
    var map = await promiseToFuture(
        _mongo.insertDocuments(databaseName, collectionName, listData));
    return jsonDecode(map);
  }

  Future deleteDocument(
      String? databaseName, String? collectionName, String? filter) async {
    var result = await promiseToFuture(
        _mongo.deleteDocument(databaseName, collectionName, filter));
    return result;
  }

  Future deleteDocuments(
      String? databaseName, String? collectionName, String? filter) async {
    var result = await promiseToFuture(
        _mongo.deleteDocuments(databaseName, collectionName, filter));
    return result;
  }

  Future<String> findDocument(
      String? databaseName, String? collectionName, String? filter) async {
    var docs = await promiseToFuture(
        _mongo.findDocument(databaseName, collectionName, filter));
    return docs;
  }

  Future<List<dynamic>> findDocuments(
      String? databaseName, String? collectionName, String? filter) async {
    var docs = await promiseToFuture(
        _mongo.findDocuments(databaseName, collectionName, filter));
    return docs;
  }

  Future<int> countDocuments(
      String? databaseName, String? collectionName, String? filter) async {
    var docsCount = await promiseToFuture(
        _mongo.countDocuments(databaseName, collectionName, filter));
    return docsCount;
  }

  Future updateDocument(String? databaseName, String? collectionName,
      String? filter, String? update) async {
    var docsUpdatedCount = await promiseToFuture(
        _mongo.updateDocument(databaseName, collectionName, filter, update));
    return docsUpdatedCount;
  }

  Future updateDocuments(String? databaseName, String? collectionName,
      String? filter, String? update) async {
    var docsUpdatedCount = await promiseToFuture(
        _mongo.updateDocuments(databaseName, collectionName, filter, update));
    return docsUpdatedCount;
  }

  //////

  Future<Map> loginAnonymously() async {
    String result = await promiseToFuture(_mongo.loginAnonymously());
    Map userMap = json.decode(result);
    return {"id": userMap['id']};
  }

  Future<Map> signInWithUsernamePassword(
      String username, String password) async {
    String result = await promiseToFuture(
        _mongo.signInWithUsernamePassword(username, password));
    Map userMap = json.decode(result);
    return {"id": userMap['id']};
  }

  Future<Map> signInWithGoogle(String authCode) async {
    String result = await promiseToFuture(_mongo.signInWithGoogle(authCode));
    Map userMap = json.decode(result);
    return {"id": userMap['id']};
  }

  Future<Map> signInWithFacebook(String token) async {
    String result = await promiseToFuture(_mongo.signInWithFacebook(token));
    Map userMap = json.decode(result);
    return {"id": userMap['id']};
  }

  Future<Map> signInWithCustomJwt(String token) async {
    String result = await promiseToFuture(_mongo.signInWithCustomJwt(token));
    Map userMap = json.decode(result);
    return {"id": userMap['id']};
  }

  Future<Map> signInWithCustomFunction(String jsonData) async {
    String result =
        await promiseToFuture(_mongo.signInWithCustomFunction(jsonData));
    Map userMap = json.decode(result);
    return {"id": userMap['id']};
  }

  Future<bool> registerWithEmail(String username, String password) async {
    /*String result =*/ await promiseToFuture(
        _mongo.registerWithEmail(username, password));
    return true;
  }

  Future<Map> linkCredentials(String credJson) async {
    String result = await promiseToFuture(_mongo.linkCredentials(credJson));
    Map userMap = json.decode(result);
    return {"id": userMap['id']};
  }

  Future<bool> logout() async {
    await promiseToFuture(_mongo.logout());
    return true;
  }

  Future<String> getUserId() async => await promiseToFuture(_mongo.getUserId());

  Future<String> getAccessToken() async => await promiseToFuture(_mongo.getAccessToken());

  Future<String> getRefreshToken() async => await promiseToFuture(_mongo.getRefreshToken());

  Future<Map?> getUser() async {
    String result = await promiseToFuture(_mongo.getUser());
    Map? userMap = json.decode(result);
    return userMap;
  }

  Future<bool> sendResetPasswordEmail(String email) async {
    await promiseToFuture(_mongo.sendResetPasswordEmail(email));
    return true;
  }

  Future callFunction(String name, List? args /*, int timeout*/) async {
    var result =
        await promiseToFuture(_mongo.callFunction(name, args /*, timeout*/));
    return result;
  }

  /// WEB-only solution

  setupWatchCollection(String databaseName, String collectionName, [filter]) {
    _mongo.setupWatchCollection(databaseName, collectionName, filter);
  }
}
