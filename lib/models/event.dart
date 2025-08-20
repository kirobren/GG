
class Event {
final String id; 
final String title;
final String date;
final String description;
final String imageUrl;
final String location;
final String sportCategory;

Event({
required this.id,
required this.title,
required this.date,
required this.description,
required this.imageUrl,
required this.location,
required this.sportCategory, 
});

Map<String, dynamic> toJson() => {
'id': id,
'title': title,
'date': date,
'description': description,
'imageUrl': imageUrl,
'location': location,
'sportCategory': sportCategory, 
};

factory Event.fromJson(Map<String, dynamic> json) => Event(
id: json['id'] as String? ?? '',
title: json['title'] as String? ?? 'No Title',
date: json['date'] as String? ?? 'No Date',
description: json['description'] as String? ?? 'No Description',
imageUrl: json['imageUrl'] as String? ?? '',
location: json['location'] as String? ?? 'Unknown Location',
sportCategory: json['sportCategory'] as String? ?? 'Other',
);

@override
bool operator ==(Object other) {
if (identical(this, other)) return true;
return other is Event && other.id == id;
}

@override
int get hashCode => id.hashCode;
}
