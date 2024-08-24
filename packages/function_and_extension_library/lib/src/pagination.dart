List<dynamic> paginate({
  required int current,
  required int total,
}) {
  const int maxPagesToShow = 5; // Maximum number of pages to display

  if (current <= 0 || total <= 0) {
    throw ArgumentError('Both current and total must be greater than zero.');
  }

  List<dynamic> pages = [];

  // Case: Total pages are less than or equal to the maximum pages to show
  if (total <= maxPagesToShow) {
    pages.addAll(List<int>.generate(total, (index) => index + 1));
  } else {
    // Add the first page
    pages.add(1);

    // Add ellipsis if there are skipped pages before the current page
    if (current > 2) {
      pages.add('...');
    }

    // Calculate start and end range around the current page
    int start = current - 1;
    int end = current + 1;

    // Add page numbers within the range
    for (int i = start; i <= end; i++) {
      if (i > 1 && i < total) {
        pages.add(i);
      }
    }

    // Add ellipsis if there are skipped pages after the current page
    if (current < total - 1) {
      pages.add('...');
    }

    // Add the last page
    pages.add(total);
  }
  return pages;
}
