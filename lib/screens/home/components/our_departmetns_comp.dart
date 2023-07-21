import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:singleclinic/common/widgets/heading_tile.dart';
import 'package:singleclinic/scoped_models/department_scoped_model.dart';
import 'package:singleclinic/screens/department/department_screen.dart';
import 'package:singleclinic/screens/doctors/doctors_list_screen.dart';
import 'package:singleclinic/utils/extensions/padding.dart';
import 'package:singleclinic/utils/helper.dart';

class OurDepartments extends StatelessWidget {
  const OurDepartments({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DepartmentScopedModel>(
      model: DepartmentScopedModel.instance,
      child: Builder(builder: (context) {
        DepartmentScopedModel.of(context).getDepartments();
        return ScopedModelDescendant<DepartmentScopedModel>(
            builder: (context, _, model) {
          return Column(
            children: [
              HeadingTile(
                title: "Our Departments",
                route: DepartmentListScreen.routeName,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Column(
                    children: [
                      Card(
                        shape: CircleBorder(),
                        child: IconButton(
                          onPressed: () {
                            print(model.departmentsList[index].id.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorsListScreen(
                                            filtersMap: {
                                              "department_id": model
                                                  .departmentsList[index].name
                                                  .toString()
                                            })));
                          },
                          iconSize: 50,
                          icon: Image.network(getDepartmentImageUrl(
                                  model.departmentsList[index].image))
                              .p(5),
                        ),
                      ),
                      Text(
                        model.departmentsList[index].name,
                        style: GoogleFonts.poppins(fontSize: 11),
                      )
                    ],
                  ).px(10),
                  itemCount: model.departmentsList.length,
                ),
              )
            ],
          );
        });
      }),
    );
  }
}
