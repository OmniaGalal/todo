class Users{
  String? id;
  String? Name;
  String? Email;
  Users({required this.id,required this.Name, required this.Email});
  Map<String, dynamic> toFireStore(){

 return
   {
     "id":id,
     "Name":Name,
     "Email":Email
   };
 }

 Users.fromFireStore(Map<String,dynamic> data):this(
   id:data["id"],
   Email: data["Email"],
   Name: data["Name"]
 );
}