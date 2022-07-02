class NewsModelQuery{
  late String newshead;
  late String newsdesc;
  late String url;
  late String img;

  NewsModelQuery({this.newshead='NEWS HEADLINE',this.newsdesc='DESC',this.url='abc',this.img='abc'});

  factory NewsModelQuery.fromMap(Map news)
  {
    return NewsModelQuery(
      newshead: news['title'],
      newsdesc: news['description'],
      img: news['urlToImage'],
      url: news['url'],
    );
  }
}