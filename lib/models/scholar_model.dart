class Scholar {
  final int id;
  final String famousName;
  final String bornOn;
  final String diedOn;
  final String livedIn;
  final String nickName;

  const Scholar({
    required this.id,
    required this.famousName,
    this.bornOn = '',
    this.diedOn = '',
    required this.livedIn,
    this.nickName = '',
  });

  // Factory constructor to create a Scholar from a JSON map
  factory Scholar.fromJson(Map<String, dynamic> json) {
    return Scholar(
      id: json['id'] as int,
      famousName: json['famous_name'] as String,
      bornOn: json['born_on'] as String? ?? '',
      diedOn: json['died_on'] as String? ?? '',
      livedIn: json['lived_in'] as String,
      nickName: json['nick_name'] as String? ?? '',
    );
  }

  // Method to convert Scholar to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'famous_name': famousName,
      'born_on': bornOn,
      'died_on': diedOn,
      'lived_in': livedIn,
      'nick_name': nickName,
    };
  }
}