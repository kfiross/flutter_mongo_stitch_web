library flutter_mongo_stitch_web;

//import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:flutter_mongo_stitch_platform_interface/flutter_mongo_stitch_platform_interface.dart';
import 'package:flutter_mongo_stitch_web/utils.dart';
import 'implementation.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// The web implementation of [FlutterMongoStitchPlatform].
///
/// This class implements the `package:flutter_mongo_stitch` functionality for the web.
class FlutterMongoStitchPlugin extends FlutterMongoStitchPlatform {
  FlutterMongoStitchPlugin(){
    // Inject the desired libraries
    injectJSLibraries([
      "https://s3.amazonaws.com/stitch-sdks/js/bundles/4.9.0/stitch.js",
      "https://fluttermongostitch.s3.us-east-2.amazonaws.com/stitchUtils.js"
    ]);
  }

  static void registerWith(Registrar registrar) /*async*/ {
    // Registers this class as the default instance of [FlutterMongoStitchPlatform]
    FlutterMongoStitchPlatform.instance = FlutterMongoStitchPlugin();
  }

  var _mongoClient = MyMongoClient();


  @override
  Future connectToMongo(String appId) async{
    _mongoClient.connectMongo(appId);
    return Future.value(true);
  }

  ///==========================================================

  @override
  Future insertDocument({
    @required String collectionName,
    @required String databaseName,
    @required Map<String, Object> data,
  }) async {
    await _mongoClient.insertDocument(databaseName, collectionName, data);
    return Future.value(true);
  }

  @override
  Future insertDocuments({
    @required String collectionName,
    @required String databaseName,
    @required List<String> list,
  }) async {
    await _mongoClient.insertDocuments(databaseName, collectionName, list);
    return Future.value(true);
  }

  @override
  Future findDocuments(
      {String collectionName, String databaseName, dynamic filter,
        String projection, int limit, String sort}) async {
    var list = await _mongoClient.findDocuments(databaseName, collectionName, filter);
    return Future.value(list);
  }

  @override
  Future findFirstDocument(
      {String collectionName, String databaseName, dynamic filter, String projection}) async {
    //todo, ADD: final String projection = call.arguments['projection'];

    var list = await _mongoClient.findDocument(databaseName, collectionName, filter);
    return Future.value(list);
  }

  @override
  Future deleteDocument(
      {String collectionName, String databaseName, dynamic filter}) async {
    String resultString =  await _mongoClient.deleteDocument(databaseName, collectionName, filter);
    Map<String, dynamic> map = json.decode(resultString);

    return Future.value(map["deletedCount"]);
  }

  @override
  Future deleteDocuments(
      {String collectionName, String databaseName, dynamic filter}) async {
    String resultString =  await _mongoClient.deleteDocuments(databaseName, collectionName, filter);
    Map<String, dynamic> map = json.decode(resultString);

    return Future.value(map["deletedCount"]);
  }

  @override
  Future countDocuments(
      {String collectionName, String databaseName, dynamic filter}) async {
    var size = await _mongoClient.countDocuments(databaseName, collectionName, filter);
    return Future.value(size);
  }

  @override
  Future updateDocument(
      {String collectionName,
        String databaseName,
        String filter,
        String update}) async {
    String resultString = await _mongoClient.updateDocument(databaseName, collectionName, filter, update);
    Map<String, dynamic> map = json.decode(resultString);

    return Future.value(<int>[map["matchedCount"] , map["modifiedCount"]]);
  }

  @override
  Future updateDocuments(
      {String collectionName,
        String databaseName,
        String filter,
        String update}) async {

    String resultString = await _mongoClient.updateDocuments(databaseName, collectionName, filter, update);
    Map<String, dynamic> map = json.decode(resultString);

    return Future.value(<int>[map["matchedCount"] , map["modifiedCount"]]);
  }

  /// ===========

  @override
  Future signInAnonymously() async {
    var authResult = await _mongoClient.loginAnonymously();
    return Future.value(authResult);
  }

  @override
  Future/*<CoreStitchUser>*/ signInWithUsernamePassword(
      String username, String password) async {
    var authResult = await _mongoClient.signInWithUsernamePassword(username, password);
    return Future.value(authResult);
  }

//  @override
//  Future/*<CoreStitchUser>*/ signInWithGoogle(String authCode) async{
//    throw UnimplementedError('signInWithGoogle() has not been implemented.');
//  }
//
//  @override
//  Future/*<CoreStitchUser>*/ signInWithFacebook(String accessToken) async{
//    throw UnimplementedError('signInWithFacebook() has not been implemented.');
//  }

  @override
  Future logout() async {
    await _mongoClient.logout();
    return Future.value(true);
  }

  @override
  Future getUserId() async {
    var id = await _mongoClient.getUserId();
    return Future.value(id);
  }

  @override
  Future<bool> registerWithEmail(String email, String password) async {
    var authResult = await _mongoClient.registerWithEmail(email, password);
    return Future.value(authResult);
  }

  @override
  Future/*<CoreStitchUser>*/ getUser() async{
    var authResult = await _mongoClient.getUser();
    return Future.value(authResult);
  }

  @override
  Future<bool> sendResetPasswordEmail(String email) async {
    await _mongoClient.sendResetPasswordEmail(email);
    return Future.value(true);
  }

  /// =====

  @override
  Future callFunction(String name, {List args, int requestTimeout}) async{
    var result = _mongoClient.callFunction(name, args);//, timeout);
    return Future.value(result);
  }

  @override
  Future setupWatchCollection(String collectionName, String databaseName, {List<String> ids, bool asObjectIds, String filter}){
    if(filter == null) {
      if (ids == null || ids.isEmpty) {
        _mongoClient.setupWatchCollection(databaseName, collectionName);
      }
      else {
        _mongoClient.setupWatchCollection(databaseName, collectionName, [ids, asObjectIds]);
      }
    }
    else{

      _mongoClient.setupWatchCollection(databaseName, collectionName, filter);

    }

    return Future.value(true);
  }

//  @override
//  aggregate({@required String collectionName, @required String databaseName,}){
//    throw UnimplementedError('aggregate() has not been implemented.');
//  }
//
//  _insertDocument(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final HashMap data = call.arguments["data"];
//
//    await _mongoClient.insertDocument(databaseName, collectionName, data);
//    return true;
//  }
//
//  _insertDocuments(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final List list = call.arguments["list"];
//
//    await _mongoClient.insertDocuments(databaseName, collectionName, list);
//    return true;
//  }
//
//  _deleteDocument(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//
//    String resultString =  await _mongoClient.deleteDocument(databaseName, collectionName, filter);
//    Map<String, dynamic> map = json.decode(resultString);
//
//    return map["deletedCount"];
//  }
//
//  _deleteDocuments(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//
//    String resultString =  await _mongoClient.deleteDocuments(databaseName, collectionName, filter);
//    Map<String, dynamic> map = json.decode(resultString);
//
//    return map["deletedCount"];
//  }
//
//  _findDocuments(MethodCall call) async {
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//
//    var list = await _mongoClient.findDocuments(databaseName, collectionName, filter);
//    return list;
//  }
//
//  _findDocument(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//    //todo, ADD: final String projection = call.arguments['projection'];
//
//
//    var list = await _mongoClient.findDocument(databaseName, collectionName, filter);
//    return list;
//
//  }
//
//  _countDocuments(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//
//    var size = await _mongoClient.countDocuments(databaseName, collectionName, filter);
//    return size;
//  }
//
//  _updateDocument(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//    final String update = call.arguments['update'];
//
//    String resultString = await _mongoClient.updateDocument(databaseName, collectionName, filter, update);
//    Map<String, dynamic> map = json.decode(resultString);
//
//    return <int>[map["matchedCount"] , map["modifiedCount"]];
//
//  }
//
//  _updateDocuments(MethodCall call) async{
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//    final String update = call.arguments['update'];
//
//    String resultString = await _mongoClient.updateDocuments(databaseName, collectionName, filter, update);
//    Map<String, dynamic> map = json.decode(resultString);
//
//    return [map["matchedCount"] , map["modifiedCount"]];
//  }
//
//  _aggregate(MethodCall call) async{}

  ///====================================================================

//  _signInAnonymously() async {
//    var authResult = await _mongoClient.loginAnonymously();
//    return authResult;
//  }
//
//  _signInWithUsernamePassword(MethodCall call) async{
//    final String username = call.arguments["username"];
//    final String password = call.arguments["password"];
//
//
//    var authResult =
//    await _mongoClient.signInWithUsernamePassword(username, password);
//    return authResult;
//  }
//
//  _signInWithGoogle(MethodCall call) async{
//    final String authCode = call.arguments["code"];
//
//    var authResult =
//    await _mongoClient.signInWithGoogle(authCode);
//    return authResult;
//  }
//
//  _signInWithFacebook(MethodCall call) async{
//
//  }
//
//  _registerWithEmail(MethodCall call) async{
//    final String email = call.arguments["email"];
//    final String password = call.arguments["password"];
//
//    var authResult = await _mongoClient.registerWithEmail(email, password);
//    return authResult;
//  }
//
//  _logout() async{
//    await _mongoClient.logout();
//    return true;
//  }
//
//  _getUserId() async{
//    var id = await _mongoClient.getUserId();
//    return id;
//  }
//
//  _getUser() async{
//    var authResult = await _mongoClient.getUser();
//    return authResult;
//  }
//
//  _sendResetPasswordEmail(MethodCall call) async{
//    final String email = call.arguments["email"];
//
//    await _mongoClient.sendResetPasswordEmail(email);
//    return true;
//  }

  ///====================================================================

//  _callFunction(MethodCall call) async {
//    final String name = call.arguments["name"];
//    final List args = call.arguments["args"] ?? [];
//    //final int timeout = call.arguments["timeout"] ?? 15000;
//
//    var result = _mongoClient.callFunction(name, args);//, timeout);
//    return result;
//  }

  ///??///?

//  _setupWatchCollection(MethodCall call){
//    final String databaseName = call.arguments['database_name'];
//    final String collectionName = call.arguments['collection_name'];
//    final String filter = call.arguments['filter'];
//    final List ids = call.arguments['ids'];
//    final bool asObjectIds = call.arguments['as_object_ids'] ?? false;
//
//    print(call.arguments);
//
//
//
//    if(filter == null) {
//      if (ids == null || ids.isEmpty) {
//        _mongoClient.setupWatchCollection(databaseName, collectionName);
//      }
//      else {
//        _mongoClient.setupWatchCollection(databaseName, collectionName, [ids, asObjectIds]);
//      }
//    }
//    else{
//
//      _mongoClient.setupWatchCollection(databaseName, collectionName, filter);
//
//    }
//  }
}

