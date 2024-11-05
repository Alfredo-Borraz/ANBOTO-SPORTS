import 'dart:convert';

class EventModel {
  final int? id;
  final String? name;
  final String? information;
  final int? participantsCount;
  final List<String>? participants;
  final bool? invitationSent;

  EventModel({
    this.id,
    this.name,
    this.information,
    this.participantsCount,
    this.participants,
    this.invitationSent,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      information: json['information'] as String?,
      participantsCount: json['participants_count'] as int?,
      participants: json['participants'] is String
          ? List<String>.from(jsonDecode(json['participants']) as List)
          : List<String>.from(json['participants'] as List),
      invitationSent: json['invitation_sent'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'information': information,
      'participants_count': participantsCount,
      'participants': jsonEncode(participants),
      'invitation_sent': invitationSent == true ? 1 : 0,
    };
  }
}

List<EventModel> events = [];
