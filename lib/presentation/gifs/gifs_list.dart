import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif_app/domain/gif.dart';
import 'package:flutter_gif_app/presentation/gifs/gifs_list_model.dart';
import 'package:flutter_gif_app/presentation/gifs/preview_gif.dart';
import 'package:flutter_gif_app/presentation/widgets/error_layout.dart';
import 'package:flutter_gif_app/util/design_utils.dart';
import 'package:flutter_gif_app/util/values.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shimmer/shimmer.dart';

class GifsList extends StatefulWidget {
  const GifsList();

  @override
  State<GifsList> createState() => _GifsListState();
}

class _GifsListState extends State<GifsList> with DesignUtils {
  late final GifsListModel _model;

  final PagingController<int, Gif> _pagingController =
      PagingController(firstPageKey: 0);
  final _gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: kIsWeb ? 15 : 2,
  );
  Object? _activeCallbackIdentity;

  @override
  void initState() {
    super.initState();

    _model = GifsListModel(context);

    _pagingController.addPageRequestListener((offset) async {
      final callbackIdentity = Object();
      _activeCallbackIdentity = callbackIdentity;

      Timer.run(() async {
        try {
          final gifs = await _model.fetchGifs(offset);

          if (callbackIdentity == _activeCallbackIdentity) {
            _pagingController.appendPage(gifs, offset + GifsListModel.limit);
          }
        } catch (e) {
          if (callbackIdentity == _activeCallbackIdentity) {
            _pagingController.error = e;
          }
        }
      });
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PagedGridView<int, Gif>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<Gif>(
        itemBuilder: (context, item, index) {
          return PreviewGif(
            gif: item,
            isInLeft: index.isEven,
          );
        },
        firstPageProgressIndicatorBuilder: (context) => Shimmer.fromColors(
          baseColor: isLight(context) ? shimmerBaseColor : shimmerBaseColorDark,
          highlightColor: isLight(context)
              ? shimmerHighlightColor
              : shimmerHightlightColorDark,
          child: SizedBox(
            width: 1,
            height: 1,
            child: GridView.builder(
              gridDelegate: _gridDelegate,
              itemCount: GifsListModel.limit,
              itemBuilder: (context, index) => ShimmerPreviewGif(
                isInLeft: index.isEven,
              ),
            ),
          ),
        ),
        noItemsFoundIndicatorBuilder: (context) => Container(
          padding: const EdgeInsets.only(
            left: marginLat,
            top: marginVert,
            right: marginLat,
            bottom: marginVert,
          ),
          child: const Center(
            child: Text(
              "We haven't found anything with that search criteria, try modifying it to see if you have more luck!",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        firstPageErrorIndicatorBuilder: (context) => Container(
          padding: const EdgeInsets.only(
            left: marginLat,
            top: marginVert,
            right: marginLat,
            bottom: marginVert,
          ),
          child: Center(
            child: ErrorLayout(),
          ),
        ),
      ),
      gridDelegate: _gridDelegate,
    );
  }
}
