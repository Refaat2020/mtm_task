import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mtm_task/constant/k_colors.dart';
import 'package:mtm_task/cubit/search_destination_cubit.dart';
import 'package:mtm_task/ui/widgets/back_button.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchDestinationScreen extends StatefulWidget {

  @override
  _SearchDestinationScreenState createState() =>
      _SearchDestinationScreenState();
}

class _SearchDestinationScreenState extends State<SearchDestinationScreen> {

  final RefreshController _placesController = RefreshController();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SearchDestinationCubit>().getCity(_placesController);
  }
  @override
  Widget build(BuildContext context) {
    final searchSource= context.watch<SearchDestinationCubit>();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Padding(
            padding:  EdgeInsets.only(top: 10.h),
            child: Container(
              width: ScreenUtil().screenWidth / 1.2,
              // color: Colors.white,
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
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  hintText: "Destination",
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
                    // searchSource.searchSourcePlace(_placesController);
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
        body:  BlocBuilder<SearchDestinationCubit, SearchDestinationState>(
          builder: (context, state) {
            if (state is SearchDestinationLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }else if(state is SearchDestinationFetched){
              return SmartRefresher(
                controller: _placesController,
                enablePullUp: true,
                enablePullDown: false,
                onRefresh: () {
                  // searchSource.limit = 10;
                  searchSource.paginateLocalList(_placesController);

                },
                onLoading: ()async {
                  if ( _placesController.isLoading == true) {
                    searchSource.paginateLocalList(_placesController);

                  }

                },
                child: ListView.builder(
                  itemCount: state.city.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 20.h),
                  // controller: _scrollController,
                  itemBuilder: (context, index) {
                    return  GestureDetector(
                      onTap: (){
                        searchSource.selectPlace(context, state.city[index].name!);
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

                                Column(
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().screenWidth-100.w,
                                      child: Text(
                                          state.city[index].name!,
                                        overflow: TextOverflow.fade,
                                        maxLines: 3,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 15.sp,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().screenWidth-100.w,
                                      child: Text(
                                        state.city[index].country!,
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
