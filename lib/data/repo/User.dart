  part of data;

  Map _user = {
    "id" : 0,
    "firstName" : "Aitem",
    "lastName" : "Quancy",
    "myPlan" : 1,
    "appointments" : DataHelper.getUserAppointments(0, GlobalData.appointments),
    "notifications" : DataHelper.getNotifications(0, GlobalData.notifications),

    "country" : 0,
    "dateOfBirth" : "1995-12-05 20:56:14.592815",
    "email" : "emailtest@test.com",
    "gender" : 1,
    "bloodGroup" : 1,
    "genotype" : 1
  };