import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/src/models/country_model.dart';
import 'package:intl_phone_number_input/src/utils/util.dart';

/// [Item]
class Item extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;
  final TextStyle? textStyle;
  final bool withCountryNames;
  final bool isCountryCodeVisible;
  final double? leadingPadding;
  final bool trailingSpace;
  final double iconWidth;

  const Item({
    Key? key,
    this.country,
    this.showFlag,
    this.useEmoji,
    this.textStyle,
    this.withCountryNames = false,
    this.isCountryCodeVisible = false,
    this.leadingPadding = 12,
    this.trailingSpace = true,
    this.iconWidth = 32,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String dialCode = (country?.dialCode ?? '');
    if (trailingSpace) {
      dialCode = dialCode.padRight(5, "   ");
    }
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(width: leadingPadding),
          _Flag(
            country: country,
            showFlag: showFlag,
            useEmoji: useEmoji,
            width: iconWidth,
          ),
          if (isCountryCodeVisible) ...[
            SizedBox(width: 12.0),
            Text(
              '$dialCode',
              textDirection: TextDirection.ltr,
              style: textStyle,
            ),
          ],
        ],
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final Country? country;
  final bool? showFlag;
  final bool? useEmoji;
  final double? width;

  const _Flag({
    Key? key,
    this.country,
    this.showFlag,
    this.useEmoji,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return country != null && showFlag!
        ? Container(
            child: useEmoji!
                ? Text(
                    Utils.generateFlagEmojiUnicode(country?.alpha2Code ?? ''),
                    style: Theme.of(context).textTheme.headlineSmall,
                  )
                : Image.asset(
                    country!.flagUri,
                    width: width,
                    package: 'intl_phone_number_input',
                    errorBuilder: (context, error, stackTrace) {
                      return SizedBox.shrink();
                    },
                  ),
          )
        : SizedBox.shrink();
  }
}
