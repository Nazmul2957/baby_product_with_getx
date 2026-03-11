// lib/core/utils/pagination_helper.dart

class PaginationHelper {
  int currentPage = 0;
  bool hasMore = true;

  void reset() {
    currentPage = 0;
    hasMore = true;
  }

  void nextPage() {
    if (hasMore) currentPage++;
  }

  void checkHasMore(int fetchedItems, int pageSize) {
    hasMore = fetchedItems >= pageSize;
  }
}


///how to use this///
// final PaginationHelper paginator = PaginationHelper();
//
// void loadMore() async {
//   if (!paginator.hasMore) return;
//
//   final data = await repository.getProducts(page: paginator.currentPage);
//   paginator.checkHasMore(data.length, 10);
//   paginator.nextPage();
// }