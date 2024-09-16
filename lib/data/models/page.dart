class Page<T> {
  List<T> content;
  final int totalPages;
  final int totalElements;
  final int number;
  final int size;

  Page(
      {required this.content,
      required this.totalPages,
      required this.totalElements,
      required this.number,
      required this.size});

  factory Page.fromJson(Map<String, dynamic> json,
      {T Function(Map<String, dynamic> content)? mappedContent}) {
    List<T> listContent = [];

    if (mappedContent != null) {
      json["content"].forEach((data) {
        T content = mappedContent(data);

        listContent.add(content);
      });
    }

    return Page(
      content: mappedContent != null ? listContent : json["content"],
      totalPages: json["totalPages"],
      totalElements: json["totalElements"],
      number: json["number"],
      size: json["size"],
    );
  }
}
