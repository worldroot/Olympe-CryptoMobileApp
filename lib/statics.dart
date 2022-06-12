enum Environment {
  production,
  development,
}

Environment env = Environment.development;

String baseURL = (env == Environment.development)
    ? "10.0.2.2:5000" // or 10.0.2.2:3000
    : "guitare.herokuapp.com";

String baseUploadsURL = (env == Environment.development)
    ? "http://10.0.2.2:5000/uploads/"
    : "https://guitare.herokuapp.com/uploads/";