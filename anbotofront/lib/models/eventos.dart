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
      id: json['id'],
      name: json['name'],
      information: json['information'],
      participantsCount: json['participants_count'],
    participants: List<String>.from(jsonDecode(json['participants'])),
       invitationSent: json['invitation_sent'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'information': information,
      'participantsCount': participantsCount,
      'participants': participants,
      'invitationSent': invitationSent,
    };
  }
}

List<EventModel> events = [];
