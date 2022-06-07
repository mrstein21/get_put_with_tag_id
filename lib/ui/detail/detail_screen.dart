import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_trial/mixins/style/color.dart';
import 'package:movie_trial/mixins/constant/constant.dart';
import 'package:movie_trial/ui/detail/controller/detail_movie_controller.dart';
import 'package:movie_trial/ui/detail/widget/content_section.dart';
import 'package:movie_trial/ui/detail/widget/cover_section.dart';
import 'package:movie_trial/ui/detail/widget/section_header.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
   late DetailMovieController _controller;

  @override
  void initState() {
    String movie_id=Get.parameters["id"]!;
    _controller = Get.put(DetailMovieController(movie_id),
        tag: "movie-detail-$movie_id");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kColorDark,
        body: Obx((){
          if(_controller.isLoading){
            return Container(
              width: double.infinity,
              height: double.infinity,
              color: kColorBlack,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return NestedScrollView(
              headerSliverBuilder:  (BuildContext context, bool innerBoxIsScrolled){
                return <Widget>[
                  SliverLayoutBuilder(
                    builder: (context, constraint) {
                      return SliverAppBar(
                        elevation: 0,
                        floating: true,
                        backgroundColor: kColorDark,
                        expandedHeight: 340,
                        pinned: true,
                        title: constraint.scrollOffset > 10
                            ? SectionHeader(
                          name: _controller.detail.title!,
                        )
                            : Container(),
                        centerTitle: false,
                        automaticallyImplyLeading: false,
                        titleSpacing: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: CoverSection(
                             movie: _controller.detail,
                          ),
                        ),
                      );
                    },
                  )
                ];
              },
              body: ListView(
                children: [
                  ContentSection(movie: _controller.detail,controller: _controller,),
                ],
              )
          );
        }),
      ),
    );
  }
}
