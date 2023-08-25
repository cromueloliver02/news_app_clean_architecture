import 'package:equatable/equatable.dart';

class Article extends Equatable {
  final String id;
  final String author;
  final String title;
  final String description;
  final String url;
  final String imageUrl;
  final String publishedAt;
  final String content;

  const Article({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.content,
  });

  @override
  String toString() {
    return 'Article(id: $id, author: $author, title: $title, description: $description, url: $url, imageUrl: $imageUrl, publishedAt: $publishedAt, content: $content)';
  }

  @override
  List<Object> get props {
    return [
      id,
      author,
      title,
      description,
      url,
      imageUrl,
      publishedAt,
      content,
    ];
  }

  Article copyWith({
    String Function()? id,
    String Function()? author,
    String Function()? title,
    String Function()? description,
    String Function()? url,
    String Function()? imageUrl,
    String Function()? publishedAt,
    String Function()? content,
  }) {
    return Article(
      id: id != null ? id() : this.id,
      author: author != null ? author() : this.author,
      title: title != null ? title() : this.title,
      description: description != null ? description() : this.description,
      url: url != null ? url() : this.url,
      imageUrl: imageUrl != null ? imageUrl() : this.imageUrl,
      publishedAt: publishedAt != null ? publishedAt() : this.publishedAt,
      content: content != null ? content() : this.content,
    );
  }
}
