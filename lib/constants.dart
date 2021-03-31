class Constants {
  static const graphQL = 'https://api.cryptobadge.app/graphql';
  static const authorizationEndPoint = 'https://canpass.me/oauth2/authorize';
  static const tokenEndPoint = 'https://canpass.me/oauth2/token';
  static const redirectUrl = 'https://www.google.com.vn/';
  static const canPassAccessTokenRef = 'CAN_PASS_ACCESS_TOKEN';
  static const readAccountQuery = """
      query {
            me {
              id
              name
              email
              path
              resourceUrl
              canAccounts
            }
      }
    """;
}