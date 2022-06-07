import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:movie_trial/mixins/constant/constant.dart';
import 'package:movie_trial/mixins/style/text.dart';
import 'package:movie_trial/model/detail_movie.dart';
import 'package:movie_trial/ui/detail/controller/detail_movie_controller.dart';
import 'package:movie_trial/ui/detail/widget/field_section.dart';
import 'package:movie_trial/ui/detail/widget/recommendation_section.dart';

import '../../../mixins/style/color.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({Key? key, required this.movie, required this.controller}) : super(key: key);
  final DetailMovie movie;
  final DetailMovieController controller;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kDefaultPadding/2,),
          FieldSection(field: "Original Title", value: movie.originalTitle!+" (${movie.title!}) "),
          SizedBox(height: kDefaultPadding/2,),
          FieldSection(field: "Genres", value: movie.genresString),
          SizedBox(height: kDefaultPadding/2,),
          FieldSection(field: "Tagline", value: movie.tagline==""?"N/A":movie.tagline!),
          SizedBox(height: kDefaultPadding/2,),
          FieldSection(field: "Synopsis", value: movie.overview!),
          SizedBox(height: kDefaultPadding,),
          Obx((){
              if(controller.recommendation.isEmpty){
                return Container();
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Recommended Movie",style: kTextAveHev14.copyWith(
                      color: kColorWhite
                  ),),
                  SizedBox(height: kDefaultPadding/2,),
                  Container(
                    height:125,
                    child: ListView.builder(
                        itemCount:  controller.recommendation.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_,i){
                          return RecommendationSection(movie: controller.recommendation[i]);
                        }
                    ),
                  ),
                ],
              );
            }
          )
        ],
      ),
    );
  }
}
