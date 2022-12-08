import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'instagram_post_record.g.dart';

abstract class InstagramPostRecord
    implements Built<InstagramPostRecord, InstagramPostRecordBuilder> {
  static Serializer<InstagramPostRecord> get serializer =>
      _$instagramPostRecordSerializer;

  @BuiltValueField(wireName: 'post_fav')
  bool? get postFav;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(InstagramPostRecordBuilder builder) =>
      builder..postFav = false;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('instagram_post');

  static Stream<InstagramPostRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<InstagramPostRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s))!);

  InstagramPostRecord._();
  factory InstagramPostRecord(
          [void Function(InstagramPostRecordBuilder) updates]) =
      _$InstagramPostRecord;

  static InstagramPostRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createInstagramPostRecordData({
  bool? postFav,
}) {
  final firestoreData = serializers.toFirestore(
    InstagramPostRecord.serializer,
    InstagramPostRecord(
      (i) => i..postFav = postFav,
    ),
  );

  return firestoreData;
}
