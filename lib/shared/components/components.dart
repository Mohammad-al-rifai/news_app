import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

// ignore: slash_for_doc_comments
/**
 *  Reusable Components Features:
 *      1. Timing.
 *      2. Refactoring.
 *      3. Quality.
 *      4. Clean Code.
 */

Widget defaultButton({
  required Function function,
  required String text,
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: () => function(),
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? onSubmitted,
  Function? onChanged,
  Function? onTap,
  bool isPassword = false,
  Function? suffixPressed,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: (value) => validate(value),
      onFieldSubmitted: (value) {
        if (onSubmitted != null) {
          onSubmitted(value);
        }
      },
      onChanged: (value) {
        if (onChanged != null) {
          onChanged(value);
        }
      },
      onTap: () {
        if (onTap != null) {
          onTap();
        }
      },
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(
                  suffix,
                ),
                onPressed: () {
                  if (suffixPressed != null) {
                    suffixPressed();
                  }
                },
              )
            : null,
      ),
    );

Widget myDivider() => const Padding(
      padding: EdgeInsetsDirectional.only(start: 20.0, end: 20.0),
      child: Divider(
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget buildArticleItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          navigateTo(
            context,
            WebViewScreen(
              article['url'],
            ),
          );
        },
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(
                      article['urlToImage'] == null
                          ? 'https://cdn.pixabay.com/photo/2015/04/19/08/33/flower-729512_960_720.jpg'
                          : '${article['urlToImage']}',
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: SizedBox(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyText1,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

Widget articleBuilder(list, context, {bool isSearch = false}) =>
    Conditional.single(
      context: context,
      conditionBuilder: (context) => list.isNotEmpty,
      widgetBuilder: (context) => ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length,
      ),
      fallbackBuilder: (context) => isSearch
          ? Container()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
