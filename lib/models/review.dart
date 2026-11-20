class Review {
  final int id;
  final String productName;
  final int rating;
  final String comment;
  final List<String> tags;

  const Review({
    required this.id,
    required this.productName,
    required this.rating,
    required this.comment,
    required this.tags,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    final rating = json['rating'] as int;
    if (rating < 1 || rating > 5) {
      throw const FormatException('Rating tidak valid');
    }
    return Review(
      id: json['id'] as int,
      productName: json['product_name'] as String,
      rating: rating,
      comment: json['comment'] as String,
      tags: List<String>.from(json['tags'] as List),
    );
  }
}

class ReviewPage {
  final int count;
  final bool hasNext;
  final List<Review> reviews;

  const ReviewPage({
    required this.count,
    required this.hasNext,
    required this.reviews,
  });

  factory ReviewPage.fromJson(Map<String, dynamic> json) => ReviewPage(
    count: json['count'] as int,
    hasNext: json['next'] != null,
    reviews: (json['results'] as List)
        .map((item) => Review.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList(),
  );
}
