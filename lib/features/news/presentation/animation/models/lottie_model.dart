enum LotieAnimationModel {
  empty(name: 'empty'),
  notFound(name: 'not_found2'),
  error(name: 'error'),
  loading(name: 'loading_page');

  final String name;
  const LotieAnimationModel({
    required this.name,
  });
}
