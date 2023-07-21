import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LazyLoaderFooter extends StatelessWidget {
  const LazyLoaderFooter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (BuildContext context,LoadStatus mode){
        Widget body ;
        if(mode==LoadStatus.idle){
          body =  Text("pull up load");
        }
        else if(mode==LoadStatus.loading){
          body =  CupertinoActivityIndicator();
        }
        else if(mode == LoadStatus.failed){
          body = Text("Load Failed!Click retry!");
        }
        else if(mode == LoadStatus.canLoading){
          body = Text("release to load more");
        }
        else{
          body = Text("No more Data");
        }
        return Container(
          height: 55.0,
          child: Center(child:body),
        );
      },
    );
  }
}
