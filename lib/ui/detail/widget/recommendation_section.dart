import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_trial/mixins/routes/routes.dart';
import 'package:movie_trial/mixins/style/color.dart';
import 'package:movie_trial/mixins/style/text.dart';
import 'package:movie_trial/model/movie.dart';

import '../../../mixins/constant/constant.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({Key? key, required this.movie}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        goToDetail(movie.id);
      },
      child: Container(
        margin: EdgeInsets.only(right: kDefaultPadding/2),
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: 100,
              height: 80,
              imageUrl: kImageAddress+movie.poster_path,
              imageBuilder: (context,imageProvider)=>Image(image: imageProvider,fit: BoxFit.cover,),
              placeholder: (context, url) => Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(height: kDefaultPadding/4,),
            Text(movie.title,style: kTextAveHev14.copyWith(
                color: kColorWhite,
                fontSize: 12
            ),maxLines: 2,overflow: TextOverflow.ellipsis,),
          ],
        ),
      ),
    );
  }
}
