import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:telereso/remote_state.dart';
import 'package:telereso/telereso.dart';
import 'src/constants.dart';

class RemoteImage {
  static Widget asset(String name, {
    Key key,
    AssetBundle bundle,
    ImageFrameBuilder frameBuilder,
    ImageErrorWidgetBuilder errorBuilder,
    String semanticLabel,
    bool excludeFromSemantics = false,
    double scale,
    double width,
    double height,
    Color color,
    BlendMode colorBlendMode,
    BoxFit fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String package,
    FilterQuality filterQuality = FilterQuality.low,
    int cacheWidth,
    int cacheHeight,
  }) {
    print("$TAG_DRAWABLE: reqeust image $name");
    final defautImage = Image.asset(name,
        key: key,
        bundle: bundle,
        frameBuilder: frameBuilder,
        errorBuilder: errorBuilder,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        scale: scale,
        width: width,
        height: height,
        color: color,
        colorBlendMode: colorBlendMode,
        fit: fit,
        alignment: alignment,
        repeat: repeat = ImageRepeat.noRepeat,
        centerSlice: centerSlice,
        matchTextDirection: matchTextDirection,
        gaplessPlayback: gaplessPlayback,
        isAntiAlias: isAntiAlias,
        package: package,
        filterQuality: filterQuality,
        cacheWidth: cacheWidth,
        cacheHeight: cacheHeight);

    return Telereso.instance.getRemoteImage(name) != null
        ? CachedNetworkImage(
      imageUrl: Telereso.instance.getRemoteImage(name),
      placeholder: (context, url) => defautImage,
      errorWidget: (context, url, error) => defautImage,
    ) : defautImage;
  }
}
