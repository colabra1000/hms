

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
      "userId" : appointment["userId"],
      "payloadId" : appointment["id"],
      "typeId" : appointment["status"] == 1 ? 1 : 2,
      "organisationId" : appointment["organisationId"],
      "organisationName" : appointment["organisationName"],
      "time" : appointment["timeDue"],
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
        "userId" : message["userId"],
        "payloadId" : message["id"],
        "typeId" : 0,
        "organisationId" : message["organisationId"],
        "organisationName" : message["organisationName"],
        "time" : message["time"],
      };

  }),


];