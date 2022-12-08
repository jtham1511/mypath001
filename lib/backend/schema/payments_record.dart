import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'payments_record.g.dart';

abstract class PaymentsRecord
    implements Built<PaymentsRecord, PaymentsRecordBuilder> {
  static Serializer<PaymentsRecord> get serializer =>
      _$paymentsRecordSerializer;

  DocumentReference? get paymentUser;

  DocumentReference? get paymentProduct;

  DateTime? get paymentDate;

  String? get paymentAmount;

  String? get paymentStatus;

  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference? get ffRef;
  DocumentReference get reference => ffRef!;

  static void _initializeBuilder(PaymentsRecordBuilder builder) => builder
    ..paymentAmount = ''
    ..paymentStatus = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('payments');

  static Stream<PaymentsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  static Future<PaymentsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s))!);

  PaymentsRecord._();
  factory PaymentsRecord([void Function(PaymentsRecordBuilder) updates]) =
      _$PaymentsRecord;

  static PaymentsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference})!;
}

Map<String, dynamic> createPaymentsRecordData({
  DocumentReference? paymentUser,
  DocumentReference? paymentProduct,
  DateTime? paymentDate,
  String? paymentAmount,
  String? paymentStatus,
}) {
  final firestoreData = serializers.toFirestore(
    PaymentsRecord.serializer,
    PaymentsRecord(
      (p) => p
        ..paymentUser = paymentUser
        ..paymentProduct = paymentProduct
        ..paymentDate = paymentDate
        ..paymentAmount = paymentAmount
        ..paymentStatus = paymentStatus,
    ),
  );

  return firestoreData;
}
