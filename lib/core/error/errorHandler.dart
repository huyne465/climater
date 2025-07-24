String handleHttpError(int? statusCode) {
  switch (statusCode) {
    case 400:
      return 'Bad request. Please check your input.';
    case 401:
      return 'Unauthorized. Invalid API key.';
    case 404:
      return 'City not found. Please check the city name.';
    case 429:
      return 'Too many requests. Please try again later.';
    case 500:
      return 'Server error. Please try again later.';
    default:
      return 'HTTP Error: $statusCode';
  }
}
