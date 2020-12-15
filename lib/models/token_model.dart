class Token {
  final String channel;
  final String token;
  final String appId;
  final String uid;

  Token({this.channel, this.token, this.appId, this.uid});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      channel: json['channel'],
      token: json['token'],
      appId: json['appId'],
      uid: json['uid'],
    );
  }
}
