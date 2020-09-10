class User {
    final String token;
    final dynamic id;
    final String email; 
    final Map company;

    User(this.token, this.id, this.email, {this.company});

    Map<String, dynamic> toJSON() => <String, dynamic>{
        'token': this.token,
        'id': this.id,
        'email': this.email
    };

    factory User.fromJSON(Map<String, dynamic> json) => new User(
        json['token'],
        json['id'],
        json['email']
    );

    @override
    String toString() {
        return '{token: $token, id: $id, email: $email}';
    }
}