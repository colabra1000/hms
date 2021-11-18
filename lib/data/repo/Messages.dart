part of data;

List _messages = [
  {
    "id" : 0,
    "userId" : 0,
    "organisationId" : 5,
    "time" : DateTime.now().toString(),
    "organisationName" : DataHelper.getOrganisationName(5, GlobalData.organisations),
    "readStatus" : 0,
    // "readStatus" : DataHelper.getMessageReadStatus(0, GlobalData.readStatus),
    "subject" : "Covid vaccination",
    "message" : "Hi Aitem. This is Alex from Dr. Smith's office, its time for our second covid 10 vaccination."
                "please contact s to schedule an appointment."
  },

  {
    "id" : 1,
    "userId" : 0,
    "organisationId" : 3,
    "time" : "2021-05-03 20:18:04.865617",
    "organisationName" : DataHelper.getOrganisationName(3, GlobalData.organisations),
    // "readStatus" : DataHelper.getMessageReadStatus(2, GlobalData.readStatus),
    "readStatus" : 2,
    "subject" : "Reminder (Appointment)",
    "message" : "Hi, Aitem. this blake from downtown medical center."
                "this is a friendly reminder that you have an appointment scheduled for august 2nd"
                "at 3:30 pm. we look forward t seeing you then."
  },

  {
    "id" : 2,
    "userId" : 0,
    "organisationId" : 6,
    "time" : "2021-06-22 20:18:04.865617",
    "organisationName" : DataHelper.getOrganisationName(6, GlobalData.organisations),
    "readStatus" : 1,
    // "readStatus" : DataHelper.getMessageReadStatus(1, GlobalData.readStatus),
    "subject" : "Initial appointment",
    "message" : "Hi, Aitem. this is peggy from downtown medical center. we received a"
                "referral from your primary care physician and need to schedule your initial"
                "appointment. please call or reply to this text with your availability."
                "we look forward to caring for you!"
  },

  {
    "id" : 3,
    "userId" : 0,
    "organisationId" : 1,
    "time" : DateTime.now().subtract(Duration(days: 1)).toString(),
    "organisationName" : DataHelper.getOrganisationName(1, GlobalData.organisations),
    // "readStatus" : DataHelper.getMessageReadStatus(0, GlobalData.readStatus),
    "readStatus" : 0,
    "subject" : "Outstanding balance",
    "message" : "Hi, Aitem. this is stephanie from downtown medical center. our records indicate that you"
    "have an outstanding balance that is 30 days past due."
    "please call or reply in resolving this matter. thank you."
  },

  {
    "id" : 4,
    "userId" : 0,
    "organisationId" : 2,
    "time" : "2021-01-16 20:18:04.865617",
    "organisationName" : DataHelper.getOrganisationName(2, GlobalData.organisations),
    // "readStatus" : DataHelper.getMessageReadStatus(2, GlobalData.readStatus),
    "readStatus" : 1,
    "subject" : "Follow up",
    "message" : "Hi, Miranda. this is steven from downtown medical center. we wanted to check in and"
    "see how you're doing following last week's procedure. we hope you're feeling well."
    "if you need assistance or have any questions, please call or chat us up."
  },


];