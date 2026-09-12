import 'package:flutter/material.dart';
import 'package:task_manager_app/controller/auth_controller.dart';

import '../screens/update_profile_screen.dart';


class TMAppBar extends StatelessWidget implements PreferredSize{
  final bool fromUpdateProfile;
  const TMAppBar({
    super.key,  this.fromUpdateProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.green,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage("https://cdn.pixabay.com/photo/2024/02/24/22/37/ai-generated-8594846_640.png"),
            radius: 25,
          ),
          SizedBox(width: 10,),
          Column(crossAxisAlignment: .start,
            children: [
              Text("${AuthController.userData?.firstName} ${AuthController.userData?.lastName}",style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
              ),),
              Text("${AuthController.userData?.email}",style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Colors.white
              ),),

            ],
          ),
          Spacer(),
          if(!fromUpdateProfile)CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>UpdateProfileScreen()));
                },
                icon: Icon(Icons.edit,color: Colors.black,size: 20,)
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
