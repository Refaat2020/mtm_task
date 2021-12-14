import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mtm_task/constant/k_colors.dart';
import 'package:mtm_task/cubit/search_source_cubit.dart';
import 'package:mtm_task/ui/widgets/back_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final RefreshController _placesController = RefreshController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearchSourceCubit>().initialize();

  }
  @override
  Widget build(BuildContext context) {
    final searchSource= context.watch<SearchSourceCubit>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Padding(
          padding:  EdgeInsets.only(top: 10.h),
          child: Container(
            width: ScreenUtil().screenWidth / 1.2,
            decoration:  BoxDecoration(
              color: Colors.black12,
              borderRadius:
              BorderRadius.all(Radius.circular(10.r)),
            ),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              keyboardType: TextInputType.text,
              // controller: search.textEditingController,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(
                  left: 10.w,
                ),
                hintText: "Your location",
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                enabledBorder: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.white, width: 1.1)),
                focusedBorder: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.white, width: 1.1)),
                border: const OutlineInputBorder(
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(
                        color: Colors.white, width: 1.1)),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  searchSource.searchSourcePlace(_placesController);
                }
              },
            ),
          ),
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: ScreenUtil().screenHeight/15,
        leadingWidth: 55.w,
        leading: BackButtonWidget(),
      ),
      body:  BlocBuilder<SearchSourceCubit, SearchSourceState>(
        builder: (context, state) {
          if (state is SearchSourceLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }else if(state is SearchSourceFetched){
            return SmartRefresher(
              controller: _placesController,
              enablePullUp: true,
              enablePullDown: false,
              onRefresh: () {
                searchSource.limit = 10;
                searchSource.searchSourcePlace(_placesController);

              },
              onLoading: ()async {
                if ( _placesController.isLoading == true) {
                  searchSource.searchSourcePlace(_placesController);

                }

              },
              child: ListView.builder(
                itemCount: state.places.length,
                padding: EdgeInsets.only(top: 30.h),
                itemBuilder: (context, index) {
                  return  GestureDetector(
                    onTap: (){
                      searchSource.selectPlace(context,state.places[index].get("name").toString());
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 25.w,),
                              Icon(
                                Icons.location_on_rounded,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                              SizedBox(width: 10.w,),

                              SizedBox(
                                width: ScreenUtil().screenWidth-100.w,
                                child: Text(
                                  state.places[index].get("name"),
                                  overflow: TextOverflow.fade,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),


                            ],
                          ),

                          Divider(
                            height: 50.h,
                            color: Colors.black12,
                            endIndent: 10,
                            indent: 10,
                            thickness: 1.6,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: Text("There are No Places Yet",style: TextStyle(fontSize: 14.sp,color: kButton,fontWeight: FontWeight.w600),),
          );
        },
      )
    );
  }
}
