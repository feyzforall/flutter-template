import 'package:json_annotation/json_annotation.dart';

part 'token.g.dart';

@JsonSerializable()
class Token {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_in')
  final int expiresIn;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: '.issued')
  final String issued;
  @JsonKey(name: '.expires')
  final String expires;

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.issued,
    required this.expires,
  });
}
