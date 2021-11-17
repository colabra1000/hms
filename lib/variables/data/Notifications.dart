

part of data;

int notificationIdCounter = 0;

List _notifications = [

  ...List.generate(GlobalData.appointments.length, (i){
    Map appointment = GlobalData.appointments[i];

    if(appointment["status"] == 0)
      return null;

    return {
      "id" : notificationIdCounter ++,
      // 1 is accepted, 2 is cancelled
      // 1 is appointment_booked, 2 is appointment_cancelled
      "payloadId" : appointment["id"],
      "typeId" : appointment["status"] == 1 ? 1 : 2,
      "organisationId" : appointment["organisationId"],
      "organisationName" : appointment["organisationName"],
      "time" : appointment["time"],
    };


  }),


  ...List.generate(GlobalData.messages.length, (i){
    Map message = GlobalData.messages[i];

    if(message["readStatus"] == 2){
      return null;
    }

      return {
        "id" : notificationIdCounter ++,
        // 1 is accepted, 2 is cancelled
        // 1 is appointment_booked, 2 is appointment_cancelled
        "payloadId" : message["id"],
        "typeId" : 0,
        "organisationId" : message["organisationId"],
        "organisationName" : message["organisationName"],
        "time" : message["time"],
      };

  }),

  // {
  //   "id" : 0,
  //   "type" : DataHelper.getNotificationType(0, GlobalData.notificationTypes),
  //   "typeId" : 0,
  //   "organisationId" : 3,
  //   "organisationName" : DataHelper.getOrganisationName(3, GlobalData.organisations),
  //   "time" : "2021-01-03 12:23:14.592815",
  //  },
  //
  // {
  //   "id" : 1,
  //   "type" : DataHelper.getNotificationType(0, GlobalData.notificationTypes),
  //   "typeId" : 0,
  //   "organisationId" : 2,
  //   "organisationName" : DataHelper.getOrganisationName(2, GlobalData.organisations),
  //   "time" : "2021-02-04 12:23:14.592815",
  // },
  //
  // {
  //   "id" : 2,
  //   "type" : DataHelper.getNotificationType(1, GlobalData.notificationTypes),
  //   "typeId" : 0,
  //   "organisationId" : 4,
  //   "organisationName" : DataHelper.getOrganisationName(4, GlobalData.organisations),
  //   "time" : "2021-03-05 12:23:14.592815",
  //   },
  //
  // {
  //   "id" : 3,
  //   "type" : DataHelper.getNotificationType(1, GlobalData.notificationTypes),
  //   "typeId" : 0,
  //   "organisationId" : 6,
  //   "organisationName" : DataHelper.getOrganisationName(6, GlobalData.organisations),
  //   "time" : "2021-01-07 12:23:14.592815",
  // },
  //
  // {
  //   "id" : 4,
  //   "type" : DataHelper.getNotificationType(2, GlobalData.notificationTypes),
  //   "typeId" : 0,
  //   "organisationId" : 3,
  //   "organisationName" : DataHelper.getOrganisationName(3, GlobalData.organisations),
  //   "time" : "2021-03-04 12:23:14.592815",
  //  },


];