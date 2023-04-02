// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Note _$$_NoteFromJson(Map<String, dynamic> json) => _$_Note(
      id: json['id'] as int?,
      nameNote: json['nameNote'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      dateCreation: json['dateCreation'] == null
          ? null
          : DateTime.parse(json['dateCreation'] as String),
      dateEdit: json['dateEdit'] == null
          ? null
          : DateTime.parse(json['dateEdit'] as String),
    );

Map<String, dynamic> _$$_NoteToJson(_$_Note instance) => <String, dynamic>{
      'id': instance.id,
      'nameNote': instance.nameNote,
      'content': instance.content,
      'category': instance.category,
      'dateCreation': instance.dateCreation?.toIso8601String(),
      'dateEdit': instance.dateEdit?.toIso8601String(),
    };
